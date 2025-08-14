// lib/features/home/presentation/widgets/show_card.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;

  const ShowCard({
    super.key,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              show.banner ??
                  'https://placehold.co/150x100/36454F/FFFFFF?text=${show.name.split(' ').first}',
              height: 100,
              width: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                width: 150,
                color: theme.colorScheme.surfaceContainerHighest,
                child: Center(
                  child: Icon(Icons.movie_filter_outlined,
                      color: theme.colorScheme.onSurface.withOpacity(0.5)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            show.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${show.date ?? ''} | ${show.time ?? ''}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
