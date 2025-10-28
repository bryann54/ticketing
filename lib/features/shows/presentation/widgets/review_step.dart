// lib/features/shows/presentation/widgets/steps/review_step.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';
import 'package:intl/intl.dart';

class ReviewStep extends StatelessWidget {
  final String showName;
  final String showType;
  final VenueModel? venue;
  final DateTime date;
  final TimeOfDay time;
  final File? selectedImage;
  final String? existingBannerUrl;

  const ReviewStep({
    super.key,
    required this.showName,
    required this.showType,
    this.venue,
    required this.date,
    required this.time,
    this.selectedImage,
    this.existingBannerUrl,
  });

  String _getShowTypeLabel() {
    switch (showType.toUpperCase()) {
      case 'ON_VENUE':
        return 'On Venue';
      case 'OFF_VENUE':
        return 'Virtual Event';
      default:
        return 'Event';
    }
  }

  Color _getShowTypeColor() {
    switch (showType.toUpperCase()) {
      case 'ON_VENUE':
        return const Color(0xFF00C896);
      case 'OFF_VENUE':
        return const Color(0xFF8B5FBF);
      default:
        return const Color(0xFF6C757D);
    }
  }

  @override
  Widget build(BuildContext context) {
    String _formatDateTime() {
      final formattedDate = DateFormat('MMM dd, yyyy').format(date);
      final formattedTime = time.format(context);
      return '$formattedDate at $formattedTime';
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Review Event',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please review all the details before creating your event',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 32),

          // Summary Card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Banner Image Preview
                if (selectedImage != null || existingBannerUrl != null)
                  _buildBannerPreview(context),
                
                // Event Details
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Name
                      _ReviewItem(
                        icon: Icons.event_rounded,
                        title: 'Event Name',
                        value: showName,
                        isPrimary: true,
                      ),
                      const SizedBox(height: 20),

                      // Event Type
                      _ReviewItem(
                        icon: Icons.category_rounded,
                        title: 'Event Type',
                        value: _getShowTypeLabel(),
                        valueColor: _getShowTypeColor(),
                      ),
                      const SizedBox(height: 20),

                      // Venue or Virtual Info
                      if (showType == 'ON_VENUE' && venue != null)
                        _ReviewItem(
                          icon: Icons.location_on_rounded,
                          title: 'Venue',
                          value: venue!.name,
                        )
                      else if (showType == 'OFF_VENUE')
                        _ReviewItem(
                          icon: Icons.videocam_rounded,
                          title: 'Location',
                          value: 'Virtual Event',
                          valueColor: const Color(0xFF8B5FBF),
                        ),
                      if (showType == 'ON_VENUE' && venue != null) 
                        const SizedBox(height: 20),

                      // Date & Time
                      _ReviewItem(
                        icon: Icons.calendar_today_rounded,
                        title: 'Date & Time',
                        value: _formatDateTime(),
                      ),
                      const SizedBox(height: 20),

                      // Banner Status
                      _ReviewItem(
                        icon: Icons.photo_rounded,
                        title: 'Cover Image',
                        value: (selectedImage != null || existingBannerUrl != null) 
                            ? 'Added' 
                            : 'Not added',
                        valueColor: (selectedImage != null || existingBannerUrl != null)
                            ? const Color(0xFF00C896)
                            : const Color(0xFF6C757D),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Ready to Create Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF00C896).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF00C896).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C896),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ready to create',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF00C896),
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'All event details are complete. Tap "Create Event" to proceed.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF00C896).withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Additional Info for Virtual Events
          if (showType == 'OFF_VENUE') ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5FBF).withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF8B5FBF).withOpacity(0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: const Color(0xFF8B5FBF),
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Virtual event streaming details and links can be added in the event settings after creation.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF8B5FBF),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBannerPreview(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        height: 120,
        width: double.infinity,
        child: Stack(
          children: [
            // Image
            if (selectedImage != null)
              Image.file(
                selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            else if (existingBannerUrl != null)
              CachedNetworkImage(
                imageUrl: existingBannerUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: const Icon(Icons.broken_image_rounded),
                ),
              ),
            
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            
            // Label
            Positioned(
              bottom: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Cover Image',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;
  final bool isPrimary;

  const _ReviewItem({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: isPrimary
                    ? Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        )
                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: valueColor ?? Theme.of(context).colorScheme.onSurface,
                        ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}