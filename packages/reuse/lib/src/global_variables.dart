// lib/common/config/global_variables.dart

import 'package:flutter/material.dart';

/// A class to manage global variables and constants.
class GlobalVariables {
  // Global BuildContext
  static late BuildContext buildContext;

  // Other global variables can be added here
  static bool isLoggedIn = false;
  static String currentLanguage = 'en';

  // You can add methods to update these variables if needed
  static void setLoggedIn(bool value) {
    isLoggedIn = value;
  }

  static void setCurrentLanguage(String language) {
    currentLanguage = language;
  }
}
