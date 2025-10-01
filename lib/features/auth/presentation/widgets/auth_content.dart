// lib/features/auth/presentation/widgets/auth_content.dart

import 'package:flutter/material.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/auth/presentation/widgets/auth_header.dart';
import 'package:ticketing/features/auth/presentation/widgets/email_sign_in_text_button.dart';
import 'package:ticketing/features/auth/presentation/widgets/auth_container.dart';

import 'package:ticketing/features/auth/presentation/widgets/terms_privacy_text.dart';


class AuthContent extends StatelessWidget {
  const AuthContent({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppColors.horizontalPadding,
        vertical: AppColors.verticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top spacing
          SizedBox(height: mediaQuery.size.height * 0.1),

          const AuthHeader(title: '',subtitle: '',),

          SizedBox(height: mediaQuery.size.height * 0.08),

          // Sign-in section
          AuthContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Get started',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppColors.largeElementSpacing),

                // Note: Google Sign-In button removed as per API change
                // const GoogleSignInButton(),
                // const OrDivider(),

                const EmailSignInTextButton(),
              ],
            ),
          ),

          const SizedBox(height: 32),

          const TermsPrivacyText(),

          // Bottom spacing
          SizedBox(height: mediaQuery.size.height * 0.05),
        ],
      ),
    );
  }
}
