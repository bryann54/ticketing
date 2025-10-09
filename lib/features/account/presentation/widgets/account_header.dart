// lib/features/account/presentation/widgets/account_header_section.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';

class AccountHeaderSection extends StatelessWidget {
  final MerchantModel merchant;
  final String userEmail;

  const AccountHeaderSection({
    super.key,
    required this.merchant,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String initials = merchant.name.isEmpty
        ? 'U'
        : merchant.name
            .split(' ')
            .map((e) => e.substring(0, 1))
            .join()
            .substring(0, merchant.name.split(' ').length > 1 ? 2 : 1)
            .toUpperCase();

    // A clean, colorful header area
    return Container(
      // 💡 Professional change: Added extra bottom padding to lift content
      // above the collapse point, and removed the fixed bottom radius.
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        // Removed explicit borderRadius for clean SliverAppBar integration
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: theme.colorScheme.primary,
            child: Text(
              initials,
              style:
                  theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
          ),

          const SizedBox(width: 16),

          // Business Name and Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchant.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  userEmail,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  merchant.businessTelephone ?? 'No phone',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
