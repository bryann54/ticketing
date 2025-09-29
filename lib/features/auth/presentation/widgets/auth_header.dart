// lib/features/auth/presentation/widgets/auth_header.dart

import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // App Icon/Logo placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.confirmation_number_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),

        Text(
          'Welcome to Ticketing',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Color(0xFF1F1F1F),
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        Text(
          'Your gateway to amazing events',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isDark ? Colors.grey[300] : Color(0xFF5F6368),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
