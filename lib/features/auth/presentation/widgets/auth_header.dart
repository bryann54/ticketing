// lib/features/auth/presentation/widgets/auth_header.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Logo/Icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('assets/tickoyako.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Title
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
