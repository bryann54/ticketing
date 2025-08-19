// lib/features/home/presentation/widgets/venue_card.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';

class VenueCard extends StatelessWidget {
  final VenueModel venue;
  final VoidCallback? onTap; // Add onTap to the constructor

  const VenueCard({
    super.key,
    required this.venue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      // Wrap the card in InkWell
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://placehold.co/150x100/4F3645/FFFFFF?text=${venue.abbreviation}',
                height: 100,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  width: 150,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(Icons.location_city_outlined,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              venue.name,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              venue.address,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
