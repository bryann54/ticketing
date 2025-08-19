// lib/features/home/presentation/widgets/home_error_state.dart

import 'package:flutter/material.dart';
import 'package:ticketing/core/errors/failures.dart'; // Import your Failure class

class HomeErrorState extends StatelessWidget {
  final Failure failure;
  final VoidCallback? onRetry;

  const HomeErrorState({
    super.key,
    required this.failure,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Extract the error message from the failure object.
    // The message is typically a human-readable string.
    String errorMessage = 'An unknown error occurred.';
    if (failure is ServerFailure) {
      errorMessage = failure.toString();
    } else if (failure is ConnectionFailure) {
      // This is the corrected line
      errorMessage = 'Network error. Please check your connection.';
    } else if (failure is CacheFailure) {
      errorMessage = 'Failed to load data from cache.';
    } else {
      errorMessage = 'An unexpected error occurred.';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
