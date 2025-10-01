// lib/features/auth/presentation/widgets/terms_privacy_text.dart

import 'package:flutter/material.dart';

class TermsPrivacyText extends StatelessWidget {
  const TermsPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      'By continuing, you agree to our Terms of Service and Privacy Policy',
      style: TextStyle(
        fontSize: 12,
        color: isDark ? Colors.grey[400] : Colors.grey[600],
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }
}
