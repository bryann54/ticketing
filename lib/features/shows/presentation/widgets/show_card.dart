// lib/features/home/presentation/widgets/show_card.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/home/presentation/bloc/home_bloc.dart';
import 'package:ticketing/features/home/presentation/bloc/home_event.dart';
import 'package:intl/intl.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;
  final VoidCallback? onTap;

  const ShowCard({
    super.key,
    required this.show,
    this.onTap,
  });

  String _formatDateTime() {
    if (show.date == null) return 'Date TBD';

    final date = show.date!;
    final time = show.time;

    String formattedDate = DateFormat('MMM dd').format(date);

    if (time != null) {
      String formattedTime = DateFormat('h:mm a').format(time);
      return '$formattedDate • $formattedTime';
    }

    return formattedDate;
  }

  String _getShowTypeLabel() {
    switch (show.showType?.toUpperCase()) {
      case 'ON_VENUE':
        return 'ON VENUE';
      case 'OFF_VENUE':
        return 'OFF VENUE';
      default:
        return 'TBD';
    }
  }

  Color _getShowTypeColor() {
    switch (show.showType?.toUpperCase()) {
      case 'ON_VENUE':
        return const Color(0xFF10B981);
      case 'OFF_VENUE':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 380,
      margin: const EdgeInsets.only(right: 16),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                _buildBackgroundImage(),

                // Minimal gradient overlay
                _buildMinimalOverlay(),

                // Show type banner (top left)
                _buildShowTypeBanner(),

                // More options (top right)
                _buildCleanMoreButton(context),

                // Bottom info container
                _buildBottomInfoContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return CachedNetworkImage(
      imageUrl: show.banner ?? '',
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => _buildPlaceholderImage(),
      placeholder: (context, url) => _buildLoadingImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE5E7EB),
            Color(0xFFD1D5DB),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.theaters_rounded,
          size: 48,
          color: Color(0xFF9CA3AF),
        ),
      ),
    );
  }

  Widget _buildLoadingImage() {
    return Container(
      color: const Color(0xFFF3F4F6),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B7280)),
        ),
      ),
    );
  }

  Widget _buildMinimalOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.6, 1.0],
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.black.withValues(alpha: 0.6),
          ],
        ),
      ),
    );
  }

  Widget _buildShowTypeBanner() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _getShowTypeColor(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Text(
          _getShowTypeLabel(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCleanMoreButton(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: PopupMenuButton<String>(
        color: Colors.white,
        elevation: 12,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onSelected: (String value) {
          if (value == 'edit') {
            context.read<HomeBloc>().add(EditShow(updatedShow: show));
          } else if (value == 'delete') {
            _showDeleteConfirmationDialog(context, show.id);
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.edit_rounded,
                  color: Color(0xFF3B82F6),
                  size: 18,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Edit',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.delete_rounded,
                  color: Color(0xFFEF4444),
                  size: 18,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Delete',
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
        child: const Icon(
          Icons.more_vert_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildBottomInfoContainer(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Show Name
            Text(
              show.name,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Date and Time
            Row(
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 16,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 6),
                Text(
                  _formatDateTime(),
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // Venue Info (if available)
            if (show.venue != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 16,
                    color: Color(0xFF6B7280),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Venue #${show.venue}',
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int? showId) {
    if (showId == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFEF4444),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Delete Show',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to delete "${show.name}"?',
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'This action cannot be undone.',
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6B7280),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () {
                context.read<HomeBloc>().add(DeleteShow(showId: showId));
                Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
