import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_state.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start auth check immediately
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() {
    // Add a minimal delay for UX (optional - can be removed for instant navigation)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _navigateBasedOnAuthState();
      }
    });
  }

  void _navigateBasedOnAuthState() {
    final authState = context.read<AuthBloc>().state;

    switch (authState.status) {
      case AuthStatus.authenticated:
        context.router.replace(const MainRoute());
        break;
      case AuthStatus.unauthenticated:
      case AuthStatus.error:
        context.router.replace(const AuthRoute());
        break;
      case AuthStatus.initial:
      case AuthStatus.loading:
        // Stay on splash until auth state is resolved
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Navigate as soon as auth state changes
        if (state.status != AuthStatus.initial &&
            state.status != AuthStatus.loading) {
          _navigateBasedOnAuthState();
        }
      },
      child: Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Simple app logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.confirmation_number_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // App name
              Text(
                'Ticketing',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 40),

              // Loading indicator
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
