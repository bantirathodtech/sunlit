// lib/common/settings.dart

import 'package:shared_preferences/shared_preferences.dart';

// Define keys for preferences
const String _keyThemeMode = 'theme_mode';
const String _keyLanguage = 'language';

// Enum for theme modes
enum ThemeMode {
  light,
  dark,
}

// Enum for supported languages
enum Language {
  en,
  es,
  fr,
}

class AppSettings {
  // Singleton pattern
  static final AppSettings _instance = AppSettings._internal();
  factory AppSettings() => _instance;
  AppSettings._internal();

  // SharedPreferences instance
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get and set theme mode
  ThemeMode get themeMode {
    final int? index = _prefs.getInt(_keyThemeMode);
    return ThemeMode.values[index ?? 0];
  }

  set themeMode(ThemeMode mode) {
    _prefs.setInt(_keyThemeMode, mode.index);
  }

  // Get and set language
  Language get language {
    final int? index = _prefs.getInt(_keyLanguage);
    return Language.values[index ?? 0];
  }

  set language(Language lang) {
    _prefs.setInt(_keyLanguage, lang.index);
  }

// You can add more settings as needed
}
//Purpose: Manages app settings and preferences for user customization.
// Usage: Used to store and retrieve app settings and preferences.
