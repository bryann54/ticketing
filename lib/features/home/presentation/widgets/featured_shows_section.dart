// lib/features/home/presentation/widgets/featured_shows_section.dart
import 'package:flutter/material.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';

class FeaturedShowsSection extends StatelessWidget {
  final List<ShowModel> featuredShows;

  const FeaturedShowsSection({
    super.key,
    required this.featuredShows,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (featuredShows.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PageView.builder(
          itemCount: featuredShows.length,
          itemBuilder: (context, index) {
            final show = featuredShows[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(show.banner ??
                      'https://placehold.co/600x400/000000/FFFFFF?text=Featured+Show'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.3), BlendMode.darken),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          show.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${show.date ?? 'Upcoming'} - ${show.time ?? ''}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
