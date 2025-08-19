import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';

class VenueDropdown extends StatelessWidget {
  final List<VenueModel> venues;
  final int? selectedVenueId;
  final ValueChanged<int?> onChanged;

  const VenueDropdown({
    super.key,
    required this.venues,
    required this.selectedVenueId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venue',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: selectedVenueId,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          items: venues
              .map((venue) => DropdownMenuItem<int>(
                    value: venue.id,
                    child: Text(venue.name),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'Venue is required' : null,
        ),
      ],
    );
  }
}
