import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_event.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_state.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/usecases/get_shows_usecase.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_bloc.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_event.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_state.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_bloc.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_event.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_state.dart';

@RoutePage()
@injectable
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch events to fetch full data for all shows and venues
    // This assumes your shows and venues blocs can fetch the full lists
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShowsBloc>().add(GetShowsEvent(params: GetShowsParams()));
      context.read<VenuesBloc>().add(GetVenuesEvent());
      context.read<FavouritesBloc>().add(LoadFavourites());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favourites',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, favouritesState) {
          if (favouritesState is FavouritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (favouritesState is FavouritesError) {
            return _buildErrorState(theme, favouritesState.failure);
          } else if (favouritesState is FavouritesLoaded) {
            return _buildLoadedState(theme, favouritesState);
          }
          return _buildInitialState(theme);
        },
      ),
    );
  }

  Widget _buildLoadedState(ThemeData theme, FavouritesLoaded favouritesState) {
    final favouriteShowIds = favouritesState.favouriteShowIds;
    final favouriteVenueIds = favouritesState.favouriteVenueIds;

    if (favouriteShowIds.isEmpty && favouriteVenueIds.isEmpty) {
      return _buildEmptyState(theme);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Favourited Shows Section
          if (favouriteShowIds.isNotEmpty)
            _buildShowSection(theme, favouriteShowIds),
          const SizedBox(height: 24),
          // Favourited Venues Section
          if (favouriteVenueIds.isNotEmpty)
            _buildVenueSection(theme, favouriteVenueIds),
        ],
      ),
    );
  }

  Widget _buildShowSection(ThemeData theme, List<int> favouriteShowIds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Favourited Shows',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        BlocBuilder<ShowsBloc, ShowsState>(
          builder: (context, showsState) {
            if (showsState is ShowsLoaded) {
              final favouriteShows = showsState.shows
                  .where((show) => favouriteShowIds.contains(show.id))
                  .toList();
              if (favouriteShows.isEmpty) {
                return Text(
                  'No shows found. They may have been removed.',
                  style: theme.textTheme.bodyMedium,
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favouriteShows.length,
                itemBuilder: (context, index) {
                  return _buildShowCard(theme, favouriteShows[index]);
                },
              );
            } else if (showsState is ShowsError) {
              return Text(
                'Failed to load shows.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.error),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Widget _buildVenueSection(ThemeData theme, List<int> favouriteVenueIds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Favourited Venues',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        BlocBuilder<VenuesBloc, VenuesState>(
          builder: (context, venuesState) {
            if (venuesState is VenuesLoaded) {
              final favouriteVenues = venuesState.venues
                  .where((venue) => favouriteVenueIds.contains(venue.id))
                  .toList();
              if (favouriteVenues.isEmpty) {
                return Text(
                  'No venues found. They may have been removed.',
                  style: theme.textTheme.bodyMedium,
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favouriteVenues.length,
                itemBuilder: (context, index) {
                  return _buildVenueCard(theme, favouriteVenues[index]);
                },
              );
            } else if (venuesState is VenuesError) {
              return Text(
                'Failed to load venues.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.error),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Widget _buildShowCard(ThemeData theme, ShowModel show) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            show.banner ??
                'https://placehold.co/60x60/36454F/FFFFFF?text=${show.name.split(' ').first}',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          show.name,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${show.date ?? ''} | ${show.time ?? ''}',
          style: theme.textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            context.read<FavouritesBloc>().add(ToggleFavouriteShow(show.id!));
          },
        ),
      ),
    );
  }

  Widget _buildVenueCard(ThemeData theme, VenueModel venue) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://placehold.co/60x60/4F3645/FFFFFF?text=${venue.abbreviation}',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          venue.name,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          venue.address,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            context.read<FavouritesBloc>().add(ToggleFavouriteVenue(venue.id));
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border,
                size: 80,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              'Your favourites list is empty.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add shows and venues to your wishlist by tapping the heart icon.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, Failure failure) {
    String errorMessage = 'An unknown error occurred.';
    if (failure is ServerFailure) {
      errorMessage = 'Server Error: ${failure.badResponse}';
    } else if (failure is ConnectionFailure) {
      errorMessage = 'No internet connection. Please check your network.';
    } else if (failure is ClientFailure) {
      errorMessage = 'Client Error: ${failure.error}';
    } else if (failure is GeneralFailure) {
      errorMessage = 'Error: ${failure.error}';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Failed to load favourites.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context
                    .read<ShowsBloc>()
                    .add(GetShowsEvent(params: GetShowsParams()));
                context.read<VenuesBloc>().add(GetVenuesEvent());
                context.read<FavouritesBloc>().add(LoadFavourites());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                foregroundColor: theme.colorScheme.onError,
                backgroundColor: theme.colorScheme.error,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState(ThemeData theme) {
    return Center(
      child: Text(
        'Loading favourites...',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
