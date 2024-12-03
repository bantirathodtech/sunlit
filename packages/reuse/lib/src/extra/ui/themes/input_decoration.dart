import 'package:flutter/material.dart';

import '../assets/colors.dart';

/// Provides consistent input field decorations and styles for text fields.
class AppInputDecorations {
  static InputDecoration lightInputDecoration({
    String? labelText,
    String? hintText,
    Icon? prefixIcon,
    Icon? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
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
    );
  }

  static InputDecoration darkInputDecoration({
    String? labelText,
    String? hintText,
    Icon? prefixIcon,
    Icon? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
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
    );
  }
} //Purpose: Provides consistent input field decorations and styles for text fields.
// Usage: Used to apply consistent styling to input fields.
