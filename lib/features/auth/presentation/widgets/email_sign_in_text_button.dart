// lib/features/auth/presentation/widgets/email_sign_in_text_button.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailSignInTextButton extends StatelessWidget {
  const EmailSignInTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigate to email/password sign-in or sign-up
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email/Password Login coming soon!')),
        );
      },
      child: Text(
        'Or sign in with email',
        style: GoogleFonts.poppins(
          color: Colors.deepPurple,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
