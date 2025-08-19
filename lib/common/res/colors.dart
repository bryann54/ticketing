// In colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryColor = Color(0xFF1B3B6F);
  static const Color secondaryColor = Color(0xFF3265B5);
  static const Color accentColor = Color(0xFF64B5F6);
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFE53935);
  static const Color textPrimary = Color(0xFF1B3B6F);
  static const Color textSecondary = Color(0xFF546E7A);
  static const Color cardColor = Colors.white;
  static const Color dividerColor = Color(0xFFE0E6ED);
  static const Color shadowColor = Color(0x1A1B3B6F);

  // Light Theme Gradient for Buttons
  static const LinearGradient lightButtonGradient = LinearGradient(
    colors: [primaryColor, accentColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark Theme Colors
  static const Color primaryColorDark = Color(0xFF2C5282);
  static const Color secondaryColorDark = Color(0xFF4299E1);
  static const Color accentColorDark = Color(0xFF90CDF4);
  static const Color backgroundDark = Color(0xFF1A202C);
  static const Color surfaceColorDark = Color(0xFF2D3748);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color textPrimaryDark = Color(0xFFE2E8F0);
  static const Color textSecondaryDark = Color(0xFFA0AEC0);
  static const Color cardColorDark = Color(0xFF2D3748);
  static const Color dividerColorDark = Color(0xFF4A5568);
  static const Color shadowColorDark = Color(0x3D000000);

  // Dark Theme Gradient for Buttons
  static const LinearGradient darkButtonGradient = LinearGradient(
    colors: [primaryColorDark, accentColorDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
