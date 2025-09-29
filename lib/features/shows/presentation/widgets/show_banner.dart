import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:intl/intl.dart';

class ShowBanner extends StatelessWidget {
  static const double _imageSize = 56.0;
  static const double _borderRadius = 12.0;
  static const EdgeInsets _contentPadding = EdgeInsets.all(16);
  static const EdgeInsets _margin =
      EdgeInsets.symmetric(horizontal: 8, vertical: 4);

  final ShowModel show;
  final VoidCallback? onTap;

  const ShowBanner({
    super.key,
    required this.show,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      margin: _margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Padding(
          padding: _contentPadding,
          child: Row(
            children: [
              _ImageSection(show: show),
              const SizedBox(width: 16),
              Expanded(
                child: _ContentSection(show: show),
              ),
              _TrailingSection(show: show),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final ShowModel show;

  const _ImageSection({required this.show});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ShowBanner._imageSize,
      height: ShowBanner._imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: show.banner?.isNotEmpty == true
            ? _NetworkImage(imageUrl: show.banner!)
            : _PlaceholderImage(),
      ),
    );
  }
}

class _NetworkImage extends StatelessWidget {
  final String imageUrl;

  const _NetworkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (_, __) => _LoadingImage(),
      errorWidget: (_, __, ___) => _ErrorImage(),
      fadeInDuration: const Duration(milliseconds: 150),
      memCacheWidth: 112, // 2x for crisp images
    );
  }
}

class _LoadingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withValues(alpha: 0.3),
      child: Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.1),
      child: Icon(
        Icons.broken_image_rounded,
        color: Theme.of(context).colorScheme.error.withValues(alpha: 0.6),
        size: 20,
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.08),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withValues(alpha: 0.1),
            AppColors.primaryColor.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Icon(
        Icons.theaters_rounded,
        color: AppColors.primaryColor.withValues(alpha: 0.7),
        size: 24,
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  final ShowModel show;

  const _ContentSection({required this.show});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          show.name,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        _MetadataRow(show: show),
      ],
    );
  }
}

class _MetadataRow extends StatelessWidget {
  final ShowModel show;

  const _MetadataRow({required this.show});

  @override
  Widget build(BuildContext context) {
    final metadata = _buildMetadata();

    if (metadata.isEmpty) {
      return Text(
        'Details pending',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
            ),
      );
    }

    return Row(
      children: [
        if (show.showType != null) ...[
          _TypeChip(showType: show.showType!),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            metadata.join(' • '),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  List<String> _buildMetadata() {
    final List<String> parts = [];

    if (show.date != null) {
      parts.add(DateFormat('MMM dd').format(show.date!));
    }

    if (show.time != null) {
      parts.add(DateFormat('h:mm a').format(show.time!));
    }

    return parts;
  }
}

class _TypeChip extends StatelessWidget {
  final String showType;

  const _TypeChip({required this.showType});

  static const Map<String, _TypeConfig> _configs = {
    'ON_VENUE': _TypeConfig('LIVE', Color(0xFF059669)),
    'OFF_VENUE': _TypeConfig('REMOTE', Color(0xFFD97706)),
  };

  @override
  Widget build(BuildContext context) {
    final config = _configs[showType.toUpperCase()] ??
        const _TypeConfig('TBD', Color(0xFF6B7280));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: config.color.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        config.label,
        style: TextStyle(
          color: config.color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _TypeConfig {
  final String label;
  final Color color;

  const _TypeConfig(this.label, this.color);
}

class _TrailingSection extends StatelessWidget {
  final ShowModel show;

  const _TrailingSection({required this.show});

  @override
  Widget build(BuildContext context) {
    final ticketCount = show.tickets?.length ?? 0;

    if (ticketCount == 0) {
      return Icon(
        Icons.chevron_right_rounded,
        color: Theme.of(context)
            .colorScheme
            .onSurfaceVariant
            .withValues(alpha: 0.5),
        size: 20,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$ticketCount',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'tickets',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.7),
                fontSize: 10,
              ),
        ),
      ],
    );
  }
}
