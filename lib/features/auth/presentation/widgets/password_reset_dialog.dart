import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_event.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_state.dart';
import 'package:ticketing/features/auth/presentation/widgets/auth_text_field.dart';

class PasswordResetDialog extends StatefulWidget {
  const PasswordResetDialog({super.key});

  @override
  State<PasswordResetDialog> createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends State<PasswordResetDialog> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    final isValid = email.isNotEmpty &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (_isEmailValid != isValid) {
      setState(() {
        _isEmailValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            // Password reset successful
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Reset instructions sent to ${_emailController.text}'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.errorMessage}'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                    alpha: 0.15), // Fixed: withOpacity instead of withValues
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Header
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _isEmailValid
                      ? AppColors.dividerColor.withValues(alpha: 0.1)
                      : theme.colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_reset,
                  size: 32,
                  color: _isEmailValid
                      ? AppColors.primaryColor
                      : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 24),

              // Title with subtle animation
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                child: const Text('Reset Password'),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'We\'ll send password reset instructions to your email',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 28),

              // Email Input Field
              Form(
                key: _formKey,
                child: AuthTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Email is required';
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    return emailRegex.hasMatch(value!)
                        ? null
                        : 'Please enter a valid email';
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: theme.dividerColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Send Link Button
                  Expanded(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final bool isLoading =
                            state.status == AuthStatus.loading;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: _isEmailValid && !isLoading
                                ? LinearGradient(
                                    colors: [
                                      theme.primaryColor,
                                      theme.primaryColor.withValues(
                                          alpha: 0.8), // Fixed: withOpacity
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: !_isEmailValid || isLoading
                                ? theme.colorScheme.surfaceContainerHighest
                                : null,
                          ),
                          child: ElevatedButton(
                            onPressed: _isEmailValid && !isLoading
                                ? () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context.read<AuthBloc>().add(
                                            ResetPasswordEvent(
                                              email:
                                                  _emailController.text.trim(),
                                            ),
                                          );
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: _isEmailValid
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Send Instructions',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: _isEmailValid
                                          ? Colors.white
                                          : theme.colorScheme.onSurface
                                              .withValues(
                                                  alpha:
                                                      0.4), // Fixed: withOpacity
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper function to show the dialog
void showPasswordResetDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => const PasswordResetDialog(),
  );
}
