import 'package:flutter/material.dart';

import 'colors.dart';

/// Defines text styles used throughout the application.
class AppTextStyles {
  static TextTheme get lightTextTheme {
    return TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor),
      headlineMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor),
      headlineSmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor),
      titleLarge: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor),
      titleMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor),
      titleSmall: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor),
      bodyLarge: TextStyle(fontSize: 16.0, color: AppColors.textPrimaryColor),
      bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.textPrimaryColor),
      bodySmall: TextStyle(fontSize: 12.0, color: AppColors.textSecondaryColor),
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
      headlineSmall: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleSmall: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white),
      bodySmall: TextStyle(fontSize: 12.0, color: AppColors.textSecondaryColor),
    );
  }
}
