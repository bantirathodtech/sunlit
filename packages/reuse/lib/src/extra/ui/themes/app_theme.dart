import 'package:flutter/material.dart';

import '../assets/colors.dart';
import '../assets/text_styles.dart';

// Define the overall app theme
/// Defines the overall app theme, including colors, fonts, and styling.
class AppThemeUI {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.accentColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: AppTextStyles.lightTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Convert the InputDecoration to InputDecorationTheme
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.textSecondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.textSecondaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor),
        ),
        labelStyle: TextStyle(color: AppColors.textPrimaryColor),
        hintStyle: TextStyle(color: AppColors.textSecondaryColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4.0,
        titleTextStyle: AppTextStyles.lightTextTheme.headlineLarge,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primaryDarkColor,
      hintColor: AppColors.accentDarkColor,
      scaffoldBackgroundColor: AppColors.backgroundDarkColor,
      textTheme: AppTextStyles.darkTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryDarkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Convert the InputDecoration to InputDecorationTheme
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.accentColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor),
        ),
        labelStyle: TextStyle(color: Colors.grey.shade300),
        hintStyle: TextStyle(color: Colors.grey.shade500),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDarkColor,
        foregroundColor: Colors.white,
        elevation: 4.0,
        titleTextStyle: AppTextStyles.darkTextTheme.headlineLarge,
      ),
    );
  }
}
//Purpose: Defines the overall app theme, including colors, fonts, and styling.
// Usage: Used to define and manage the app's theme and styling.
