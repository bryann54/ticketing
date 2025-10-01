// lib/features/auth/presentation/pages/auth_screen.dart

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/auth/presentation/widgets/auth_content.dart';
import 'package:ticketing/features/auth/presentation/widgets/auth_state_listener.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackgroundColor
          : AppColors.lightBackgroundColor,
      body: AuthStateListener(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: const AuthContent(),
            ),
          ),
        ),
      ),
    );
  }
}
