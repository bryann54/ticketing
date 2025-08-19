// lib/features/home/presentation/widgets/home_initial_state.dart

import 'package:flutter/material.dart';

class HomeInitialState extends StatelessWidget {
  const HomeInitialState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Welcome! Your personalized experience awaits.',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
