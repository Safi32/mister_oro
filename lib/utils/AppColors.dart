import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color lightGold = Color(0xFFF4E4C1);
  static const Color goldAccent = Color(0xFFFFD700);
  
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  
  static const Color successGreen = Color(0xFF10B981);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color warningOrange = Color(0xFFEA4335);
  static const Color infoBlue = Color(0xFF0EA5E9);
  static const Color purpleAccent = Color(0xFF7C3AED);
  
  static const Color divider = Color(0xFFE5E7EB);
  static const Color shadow = Color(0x1A000000);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGold, darkGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [surfaceWhite, Color(0xFFF8F9FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
