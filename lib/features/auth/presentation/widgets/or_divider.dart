// lib/features/auth/presentation/widgets/or_divider.dart

import 'package:flutter/material.dart';
import 'package:ticketing/common/res/colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        const SizedBox(height: AppColors.elementSpacing),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or',
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppColors.elementSpacing),
      ],
    );
  }
}
