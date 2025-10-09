// lib/features/shows/presentation/screens/shows_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/common/utils/functions.dart';
import 'package:ticketing/core/errors/failures.dart'; // Import Failure
import 'package:ticketing/features/shows/presentation/widgets/show_banner.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart'; // Import ShowModel
import 'package:ticketing/features/shows/domain/usecases/get_shows_usecase.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_bloc.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_event.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_state.dart';

@RoutePage()
class ShowsScreen extends StatefulWidget {
  const ShowsScreen({super.key});

  @override
  State<ShowsScreen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to load shows when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShowsBloc>().add(GetShowsEvent(params: GetShowsParams()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ShowsBloc>().add(GetShowsEvent(params: GetShowsParams()));
      },
      child: Scaffold(
        appBar: _buildAppBar(theme, isDark),
        body: BlocBuilder<ShowsBloc, ShowsState>(
          builder: (context, state) {
            if (state is ShowsLoading) {
              return _buildLoadingState(theme);
            } else if (state is ShowsLoaded) {
              return _buildLoadedState(theme, state.shows);
            } else if (state is ShowsError) {
              return _buildErrorState(theme, state.failure);
            }
            // Initial state or unhandled states
            return _buildInitialState(theme);
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, bool isDark) {
    return AppBar(
      elevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      title: Text(
        'your shows'.capitalize(0),
        style:TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          color: AppColors.primaryColor,
        ),
      ),
      centerTitle: true,
    
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator.adaptive(
            valueColor:
                AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading shows...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(ThemeData theme, List<ShowModel> shows) {
    if (shows.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy_outlined,
                size: 80,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              'No shows available at the moment. Check back later!',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: shows.length,
      itemBuilder: (context, index) {
        final show = shows[index];
        return ShowBanner(
          show: show,
        );
      },
    );
  }

  Widget _buildErrorState(ThemeData theme, Failure failure) {
    String errorMessage = 'An unknown error occurred.';
    if (failure is ServerFailure) {
      errorMessage = 'Server Error: ' '';
    } else if (failure is CacheFailure) {
      errorMessage = 'Failed to load shows from cache.';
    } else
      errorMessage = 'No internet connection. Please check your network.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong.',
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
                // Retry fetching shows
                context
                    .read<ShowsBloc>()
                    .add(GetShowsEvent(params: GetShowsParams()));
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
    // This state is usually very brief or just a simple placeholder
    return Center(
      child: Text(
        'Welcome! Ready to find some shows?',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
