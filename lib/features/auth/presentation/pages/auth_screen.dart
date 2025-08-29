// lib/features/auth/presentation/pages/auth_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_route/auto_route.dart'; // Import auto_route

import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_event.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_state.dart';

import 'package:ticketing/features/auth/presentation/widgets/auth_header.dart';
import 'package:ticketing/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:ticketing/features/auth/presentation/widgets/email_sign_in_text_button.dart';

@RoutePage() // ⭐ Add this annotation ⭐
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully signed in!')),
            );
            // ⭐ Use auto_route to navigate to the main app after successful login ⭐
            context.router
                .replaceNamed('/main'); // Navigate to the root of your main app
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AuthHeader(),
                const SizedBox(height: 48),
                const GoogleSignInButton(),
                const SizedBox(height: 24),
                const EmailSignInTextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
