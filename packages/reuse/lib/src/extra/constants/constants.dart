// lib/common/constants.dart

class Constants {
  // Strings
  static const String appName = 'Sunlit';
  static const String welcomeMessage = 'Welcome to My Sunlit App';
  static const String errorMessage = 'An unexpected error occurred';

  // URLs
  static const String apiBaseUrl = 'https://api.example.com/';
  static const String privacyPolicyUrl = 'https://example.com/privacy-policy';

  // Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration timeoutDuration = Duration(seconds: 30);

  // Numbers
  static const int maxLoginAttempts = 3;
  static const double defaultPadding = 16.0;

  // Colors (if you use hex codes or color names, define them here)
  static const int primaryColor = 0xFF6200EE; // Purple
  static const int accentColor = 0xFF03DAC6; // Teal

  // Fonts
  static const String fontFamily = 'Roboto';
  static const double fontSizeLarge = 18.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeSmall = 14.0;

  // Other constants
  static const int maxItemsPerPage = 20;
  static const String dateFormat = 'yyyy-MM-dd';
}
//Purpose: Defines constant values used across the application, such as strings, numbers, and other fixed values.
// Usage: Used to store constant values for easy access and modification.
