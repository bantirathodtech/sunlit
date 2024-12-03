// lib/common/strings.dart

class Strings {
  // General
  static const String appName = 'My Flutter App';
  static const String welcomeMessage = 'Welcome to My Flutter App';
  static const String errorMessage = 'An unexpected error occurred';
  static const String ok = 'OK';
  static const String cancel = 'Cancel';

  // Authentication
  static const String loginTitle = 'Login';
  static const String loginButton = 'Log In';
  static const String usernameHint = 'Username';
  static const String passwordHint = 'Password';
  static const String loginError = 'Invalid username or password';

  // Settings
  static const String settingsTitle = 'Settings';
  static const String changeLanguage = 'Change Language';
  static const String privacyPolicy = 'Privacy Policy';

  // Localization keys (for use with localization packages)
  static const String localizationWelcomeMessage = 'welcome_message';
  static const String localizationLoginTitle = 'login_title';

  // You can also use methods to get localized strings if using a localization package
  static String getWelcomeMessage(String locale) {
    switch (locale) {
      case 'es':
        return 'Bienvenido a Mi Aplicación Flutter';
      case 'fr':
        return 'Bienvenue dans Mon Application Flutter';
      default:
        return welcomeMessage;
    }
  }
}
//Purpose: Manages application strings and text, including localized strings if applicable.
// Usage: Used to manage and organize all text and string resources.
