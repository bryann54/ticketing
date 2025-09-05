// lib/features/auth/presentation/widgets/email_sign_in_text_button.dart

import 'package:flutter/material.dart';

class EmailSignInTextButton extends StatelessWidget {
  const EmailSignInTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email/Password authentication coming soon!'),
            backgroundColor: theme.colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: isDark ? Colors.blue[300] : Color(0xFF1976D2),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.email_outlined,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            'Sign in with email instead',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: isDark ? Colors.blue[300] : Color(0xFF1976D2),
            ),
          ),
        ],
      ),
    );
  }
}
