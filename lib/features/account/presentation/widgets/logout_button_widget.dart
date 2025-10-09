// lib/features/account/presentation/widgets/logout_button.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/account/presentation/widgets/logout_dialog.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';
// 💡 Corrected import path for event
import 'package:ticketing/features/auth/presentation/bloc/auth_event.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_state.dart';
// Assuming your AutoRoute defines the initial landing page as this:
// import 'package:ticketing/common/helpers/app_router.gr.dart';

class LogOutButton extends StatefulWidget {
  const LogOutButton({super.key});

  @override
  State<LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomLogoutDialog(
          onConfirm: () {
            Navigator.of(context).pop();
            context.read<AuthBloc>().add(const SignOutEvent());
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // 💡 Use the Enum AuthStatus for comparison
        if (state.status == AuthStatus.unauthenticated) {

          context.router.replaceAll([const SplashRoute()]);
        } else if (state.status == AuthStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logout Error: ${state.errorMessage!}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // 💡 Use the Enum AuthStatus for comparison
          final bool isLoading = state.status == AuthStatus.loading;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: GestureDetector(
                  onTapDown: (_) => _controller.forward(),
                  onTapUp: (_) {
                    _controller.reverse();
                    if (!isLoading) _showLogoutConfirmationDialog();
                  },
                  onTapCancel: () => _controller.reverse(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    // 💡 Indicate loading state by changing opacity or adding a subtle overlay
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.grey[850]!.withOpacity(isLoading ? 0.6 : 1.0)
                          : Colors.white.withOpacity(isLoading ? 0.6 : 1.0),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.black.withOpacity(0.4)
                              : Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDarkMode
                                    ? AppColors.textLight
                                    : AppColors.backgroundDark,
                              ),
                            ),
                          )
                        : FaIcon(
                            FontAwesomeIcons.rightFromBracket,
                            size: 24,
                            color: isDarkMode
                                ? AppColors.textLight
                                : AppColors.backgroundDark,
                          ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
