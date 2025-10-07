// lib/features/tickets/presentation/widgets/available_show_card.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';

class AvailableShowCard extends StatelessWidget {
  final ShowModel show;

  const AvailableShowCard({
    super.key,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    final dateString =
        show.date?.toLocal().toString().split(' ')[0] ?? 'Date N/A';
    final timeString = show.time != null
        ? '${show.time!.hour.toString().padLeft(2, '0')}:${show.time!.minute.toString().padLeft(2, '0')}'
        : 'Time N/A';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: ListTile(
        
          onTap: () {
            context.router.push(ShowDetailsRoute(show: show));
          },
          leading: Hero(
            tag: 'show_banner_${show.id ?? show.name}_${show.hashCode}',
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Container(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withValues(alpha: 0.3),
                      child: show.banner != null && show.banner!.isNotEmpty
                          ? Image.network(
                              show.banner!,
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Icon(
                                  Icons.theaters,
                                  size: 28,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Icon(
                                Icons.theaters,
                                size: 28,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              show.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                    height: 1.2,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 13,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
              ),
              const SizedBox(width: 6),
              Text(
                dateString,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Icon(
                Icons.access_time_rounded,
                size: 13,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
              ),
              const SizedBox(width: 6),
              Text(
                timeString,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.qr_code_scanner_rounded,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
