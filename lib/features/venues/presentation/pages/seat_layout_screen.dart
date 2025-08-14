import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';
import 'package:ticketing/features/venues/presentation/widgets/seat_map_section_view.dart';

@RoutePage()
class SeatLayoutScreen extends StatelessWidget {
  final VenueModel venue;
  const SeatLayoutScreen({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${venue.abbreviation} Seat Layout'),
      ),
      body: SeatMapSectionView(venue: venue),
    );
  }
}
