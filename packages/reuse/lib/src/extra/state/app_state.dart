// lib/common/state/app_state.dart

import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  // Define your global state variables here
  bool _isDarkMode = false;
  String _currentUser = '';

  // Getter for dark mode
  bool get isDarkMode => _isDarkMode;

  // Getter for current user
  String get currentUser => _currentUser;

  // Method to toggle dark mode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notify listeners about the state change
  }

  // Method to set the current user
  void setCurrentUser(String user) {
    _currentUser = user;
    notifyListeners(); // Notify listeners about the state change
  }

// Additional state management methods can be added here
}
//Purpose: Manages global app state and provides state management across the application.
// Usage: Used to manage and provide global state accessible throughout the app.
