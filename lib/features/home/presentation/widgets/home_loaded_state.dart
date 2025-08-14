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
    Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeaturedShowsSection(
            featuredShows: shows.isNotEmpty
                ? shows.sublist(0, shows.length > 3 ? 3 : shows.length)
                : [],
          ),
          const SizedBox(height: 24),
          HorizontalListSection(
            title: 'Your events',
            items: shows.sublist(shows.length > 3 ? 3 : 0),
            itemBuilder: (context, item) => ShowCard(show: item as ShowModel),
            onViewAll: () {
              context.router.push(const ShowsRoute());
            },
          ),
          const SizedBox(height: 24),
          HorizontalListSection(
            title: 'Explore Top Venues',
            items: venues,
            itemBuilder: (context, item) =>
                VenueCard(venue: item as VenueModel),
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
