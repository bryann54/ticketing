// lib/features/home/presentation/widgets/show_card.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
// Ensure this is imported
import 'package:cached_network_image/cached_network_image.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;
  final VoidCallback? onTap; // Add onTap to the constructor

  const ShowCard({
    super.key,
    required this.show,
    this.onTap, // Make it optional
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      // Wrap the card in InkWell
      onTap: onTap, // Use the provided onTap callback
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: show.banner ?? '',
                height: 100,
                width: 150,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) => Container(
                  height: 100,
                  width: 150,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(
                      Icons.movie_filter_outlined,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: 100,
                  width: 150,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(
                      Icons.movie_filter_outlined,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              show.name,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${show.date ?? ''} | ${show.time ?? ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
