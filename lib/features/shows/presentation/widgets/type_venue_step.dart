// lib/features/shows/presentation/widgets/steps/type_venue_step.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';

class TypeVenueStep extends StatelessWidget {
  final String? selectedShowType;
  final int? selectedVenueId;
  final List<VenueModel> venues;
  final ValueChanged<String?> onShowTypeChanged;
  final ValueChanged<int?> onVenueChanged;

  const TypeVenueStep({
    super.key,
    required this.selectedShowType,
    required this.selectedVenueId,
    required this.venues,
    required this.onShowTypeChanged,
    required this.onVenueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Event Type & Location',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose how and where your event will take place',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 32),

          // Event Type Selection
          _buildEventTypeSection(context),
          const SizedBox(height: 24),

          // Venue Selection (Conditional)
          if (selectedShowType == 'ON_VENUE') _buildVenueSection(context),

          // Virtual Event Info (Conditional)
          if (selectedShowType == 'OFF_VENUE') _buildVirtualEventInfo(context),
        ],
      ),
    );
  }

  Widget _buildEventTypeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // On Venue Option
              _EventTypeOption(
                title: 'On Venue',
                subtitle: 'requires seat selection from users',
                value: 'ON_VENUE',
                groupValue: selectedShowType,
                onChanged: onShowTypeChanged,
                icon: Icons.location_on_rounded,
                isSelected: selectedShowType == 'ON_VENUE',
                isFirst: true,
              ),
              Divider(height: 1, color: Theme.of(context).dividerColor),
              // Off Venue Option
              _EventTypeOption(
                title: 'Off Venue',
                subtitle: 'doesn\'t require seat selection',
                value: 'OFF_VENUE',
                groupValue: selectedShowType,
                onChanged: onShowTypeChanged,
                icon: Icons.videocam_rounded,
                isSelected: selectedShowType == 'OFF_VENUE',
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVenueSection(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Column(
        key: const ValueKey('venue_section'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Venue',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            value: selectedVenueId,
            decoration: InputDecoration(
              hintText: 'Choose a venue',
              prefixIcon: Icon(
                Icons.place_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            items: [
              const DropdownMenuItem<int>(
                value: null,
                child: Text('Select a venue...'),
              ),
              ...venues.map((venue) => DropdownMenuItem<int>(
                    value: venue.id,
                    child: Text(
                      venue.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )),
            ],
            onChanged: onVenueChanged,
            validator: (value) {
              if (selectedShowType == 'ON_VENUE' && value == null) {
                return 'Please select a venue';
              }
              return null;
            },
          ),
          if (venues.isEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.orange.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No venues available. Please create a venue first.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.orange.shade700,
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

  Widget _buildVirtualEventInfo(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: const ValueKey('virtual_info'),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Virtual Event',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Virtual event details and streaming links can be added later in the event settings.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventTypeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final IconData icon;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;

  const _EventTypeOption({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.icon,
    required this.isSelected,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(16) : Radius.zero,
        bottom: isLast ? const Radius.circular(16) : Radius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(16) : Radius.zero,
            bottom: isLast ? const Radius.circular(16) : Radius.zero,
          ),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 2,
                )
              : null,
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
