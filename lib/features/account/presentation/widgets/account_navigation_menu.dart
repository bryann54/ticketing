// lib/features/account/presentation/widgets/_account_navigation_menu.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';

// Assuming you have a file that holds all your routing definitions
// import 'package:ticketing/common/helpers/app_router.gr.dart';

class AccountNavigationMenu extends StatelessWidget {
  const AccountNavigationMenu({super.key});

  // Helper method for standard menu items
  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Theme.of(context).colorScheme.primary,
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- Group 1: Account Management ---
        Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              // _buildMenuItem(
              //   context: context,
              //   icon: Icons.check_circle_outline,
              //   title: 'Account create', // TODO: Use AppLocalizations
              //   onTap: () {
              //     // context.router.push(const AccountCreateRoute());
              //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //         content: Text('Navigate to Account Create Screen')));
              //   },
              // ),
              // Divider(indent: 16, endIndent: 16, height: 1),
              _buildMenuItem(
                context: context,
                icon: Icons.ssid_chart,
                title: 'Account update', // TODO: Use AppLocalizations
                onTap: () {
                  // context.router.push(const AccountUpdateRoute());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Navigate to Account Update Screen')));
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // --- Group 2: Mpesa Credentials ---
        Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildMenuItem(
                context: context,
                icon: Icons.account_balance_wallet_outlined,
                title: 'Mpesa creds add', 
                onTap: () {
                  context.router.push(const PaymentSetupRoute());
                
                      
                },
              ),
              Divider(indent: 16, endIndent: 16, height: 1),
              _buildMenuItem(
                context: context,
                icon: Icons.auto_fix_high,
                title: 'Mpesa creds edit', // TODO: Use AppLocalizations
                onTap: () {
                  // context.router.push(const MpesaCredsEditRoute());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Navigate to Mpesa Creds Edit Screen')));
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // --- Group 3: Log Out ---
        Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: _buildMenuItem(
            context: context,
            icon: Icons.logout,
            title: 'Log out', // TODO: Use AppLocalizations
            iconColor: Colors.red,
            onTap: () {
              // TODO: Implement Logout Logic
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logging out...')));
            },
          ),
        ),
      ],
    );
  }
}
