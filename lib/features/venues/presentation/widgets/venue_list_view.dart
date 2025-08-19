import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';
import 'package:ticketing/features/venues/presentation/widgets/venue_card.dart';

class VenueListView extends StatelessWidget {
  final List<VenueModel> venues;
  const VenueListView({super.key, required this.venues});

  @override
  Widget build(BuildContext context) {
    if (venues.isEmpty) {
      return const Center(child: Text('No venues found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: venues.length,
      itemBuilder: (context, index) {
        final venue = venues[index];
        return VenueCard(venue: venue);
      },
    );
  }
}
