// lib/features/home/presentation/widgets/home_loaded_state.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/features/home/presentation/widgets/featured_shows_section.dart';
import 'package:ticketing/features/home/presentation/widgets/horizontal_list_section.dart';
import 'package:ticketing/features/home/presentation/widgets/show_card.dart';
import 'package:ticketing/features/home/presentation/widgets/venue_card.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';

class HomeLoadedState extends StatelessWidget {
  final List<ShowModel> shows;
  final List<VenueModel> venues;

  const HomeLoadedState({
    super.key,
    required this.shows,
    required this.venues,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured / Hero Section (e.g., top shows)
          FeaturedShowsSection(
            featuredShows: shows.isNotEmpty
                ? shows.sublist(0, shows.length > 3 ? 3 : shows.length)
                : [],
          ),
          const SizedBox(height: 24),

          // Personalized for you / Recommended Shows
          HorizontalListSection(
            title: 'Your events',
            items: shows.sublist(shows.length > 3 ? 3 : 0),
            itemBuilder: (context, item) {
              final showModel = item as ShowModel;
              final venueModel = venues.firstWhere(
                (venue) => venue.id == showModel.venue,
                orElse: () => VenueModel.empty(),
              );

              return ShowCard(
                show: showModel,
                onTap: () {
                  if (venueModel.seatRows.isNotEmpty) {
                    context.router.push(SeatSelectionRoute(
                      title: '${showModel.name} at ${venueModel.name}',
                      seatRows: venueModel.seatRows,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('No seat layout available for this show.'),
                      ),
                    );
                  }
                },
              );
            },
            onViewAll: () {
              context.router.push(const ShowsRoute());
            },
          ),
          const SizedBox(height: 24),

          // Now Featuring / Popular Venues
          HorizontalListSection(
            title: 'Explore Top Venues',
            items: venues,
            itemBuilder: (context, item) {
              final venueModel = item as VenueModel;
              return VenueCard(
                venue: venueModel,
                onTap: () {
                  if (venueModel.seatRows.isNotEmpty) {
                    context.router.push(SeatSelectionRoute(
                      title: venueModel.name,
                      seatRows: venueModel.seatRows,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('No seat layout available for this venue.'),
                      ),
                    );
                  }
                },
              );
            },
            onViewAll: () {
              context.router.push(const VenuesRoute());
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
