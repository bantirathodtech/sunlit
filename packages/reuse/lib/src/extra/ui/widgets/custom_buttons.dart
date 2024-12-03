import 'package:flutter/material.dart';

class CustomButtons {
  // Primary button with default styling
  static Widget primaryButton({
    required String label,
    required VoidCallback onPressed,
    double width = double.infinity,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 16.0),
    Color color = Colors.green,
    TextStyle? textStyle,
  }) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Background color
          padding: padding,
          minimumSize: const Size(100, 40), // Set a minimum size
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          label,
          style: textStyle ?? TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  // Secondary button with outline style
  static Widget secondaryButton({
    required String label,
    required VoidCallback onPressed,
    double width = double.infinity,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 16.0),
    Color borderColor = Colors.orange,
    TextStyle? textStyle,
  }) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor), // Border color
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          label,
          style: textStyle ?? TextStyle(fontSize: 16.0, color: borderColor),
        ),
      ),
    );
  }

  // Icon button with customizable icon and style
  static Widget iconButton({
    required IconData icon,
    required VoidCallback onPressed,
    double size = 24.0,
    Color color = Colors.blue,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size, color: color),
      padding: padding,
    );
  }

  // Floating action button with default styling
  static Widget floatingActionButton({
    required VoidCallback onPressed,
    required Widget child,
    Color backgroundColor = Colors.blue,
    Color foregroundColor = Colors.white,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: child,
    );
  }
}
//Purpose: Contains custom button widgets with specific styles and functionalities.
// Usage: Used to create and reuse custom button components.
