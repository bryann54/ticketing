// lib/features/auth/presentation/widgets/google_sign_in_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_event.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_state.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state.status == AuthStatus.loading
              ? null
              : () {
                  context.read<AuthBloc>().add(SignInWithGoogleEvent());
                },
          icon: state.status == AuthStatus.loading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(FontAwesomeIcons.google, color: Colors.red),
          label: Text(
            state.status == AuthStatus.loading
                ? 'Signing In...'
                : 'Sign in with Google',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey, width: 0.5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            elevation: 3,
          ),
        );
      },
    );
  }
}
