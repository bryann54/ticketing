// lib/features/home/presentation/widgets/home_error_state.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/common/utils/functions.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:ticketing/features/home/presentation/bloc/home_bloc.dart';
import 'package:ticketing/features/home/presentation/bloc/home_event.dart';

class HomeErrorState extends StatelessWidget {
  final Failure failure;
  const HomeErrorState({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Oops! Could not load home data.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              getErrorMessage as String,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeBloc>().add(const LoadHomeData());
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
}
