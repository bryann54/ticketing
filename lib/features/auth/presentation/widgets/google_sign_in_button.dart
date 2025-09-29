// lib/features/auth/presentation/widgets/google_sign_in_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_event.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_state.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    context.read<AuthBloc>().add(SignInWithGoogleEvent());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1F1F1F),
              elevation: 1,
              shadowColor: Colors.black.withValues(alpha: 0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                  color: const Color(0xFFDADCE0),
                  width: 1,
                ),
              ),
              padding: EdgeInsets.zero,
            ),
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF1F1F1F),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Signing in...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F1F1F),
                          letterSpacing: 0.25,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Official Google "G" logo as SVG path
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CustomPaint(
                          painter: GoogleLogoPainter(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F1F1F),
                          letterSpacing: 0.25,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

// Custom painter for the official Google "G" logo
class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Scale factor to fit the logo in the given size
    final scale = size.width / 24.0;
    canvas.scale(scale);

    // Google Blue (#4285F4)
    paint.color = const Color(0xFF4285F4);
    final bluePath = Path()
      ..moveTo(22.56, 12.25)
      ..cubicTo(22.56, 11.47, 22.49, 10.72, 22.36, 10.0)
      ..lineTo(12.0, 10.0)
      ..lineTo(12.0, 14.26)
      ..lineTo(18.07, 14.26)
      ..cubicTo(17.74, 15.97, 16.79, 17.42, 15.4, 18.39)
      ..lineTo(19.06, 21.29)
      ..cubicTo(21.19, 19.36, 22.56, 16.09, 22.56, 12.25);
    canvas.drawPath(bluePath, paint);

    // Google Green (#34A853)
    paint.color = const Color(0xFF34A853);
    final greenPath = Path()
      ..moveTo(12.0, 5.0)
      ..cubicTo(14.16, 5.0, 16.11, 5.81, 17.61, 7.24)
      ..lineTo(20.85, 4.0)
      ..cubicTo(18.65, 2.0, 15.58, 0.74, 12.0, 0.74)
      ..cubicTo(7.7, 0.74, 4.11, 3.11, 2.24, 6.65)
      ..lineTo(5.5, 9.24)
      ..cubicTo(6.44, 6.62, 9.0, 5.0, 12.0, 5.0);
    canvas.drawPath(greenPath, paint);

    // Google Yellow (#FBBC04)
    paint.color = const Color(0xFFFBBC04);
    final yellowPath = Path()
      ..moveTo(2.24, 6.65)
      ..cubicTo(1.46, 8.48, 1.0, 10.49, 1.0, 12.74)
      ..cubicTo(1.0, 14.99, 1.46, 17.0, 2.24, 18.83)
      ..lineTo(5.5, 16.24)
      ..cubicTo(5.19, 15.49, 5.0, 14.15, 5.0, 12.74)
      ..cubicTo(5.0, 11.33, 5.19, 9.99, 5.5, 9.24)
      ..lineTo(2.24, 6.65);
    canvas.drawPath(yellowPath, paint);

    // Google Red (#EA4335)
    paint.color = const Color(0xFFEA4335);
    final redPath = Path()
      ..moveTo(12.0, 19.48)
      ..cubicTo(9.0, 19.48, 6.44, 17.86, 5.5, 15.24)
      ..lineTo(2.24, 17.83)
      ..cubicTo(4.11, 21.37, 7.7, 23.74, 12.0, 23.74)
      ..cubicTo(15.43, 23.74, 18.4, 22.6, 20.55, 20.83)
      ..lineTo(17.28, 18.24)
      ..cubicTo(16.25, 18.95, 14.24, 19.48, 12.0, 19.48);
    canvas.drawPath(redPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
