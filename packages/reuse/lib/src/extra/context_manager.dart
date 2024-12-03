// lib/common/context/context_manager.dart

import 'package:flutter/material.dart';

class ContextManager {
  // Singleton pattern to ensure a single instance
  static final ContextManager _instance = ContextManager._internal();

  // Private constructor
  ContextManager._internal();

  // Factory constructor to return the singleton instance
  factory ContextManager() => _instance;

  // Late variable for BuildContext
  late BuildContext _buildContext;

  // Setter for BuildContext
  void setContext(BuildContext context) {
    _buildContext = context;
  }

  // Getter for BuildContext
  BuildContext get context => _buildContext;

  // Example method to show a dialog using the stored BuildContext
  void showCustomDialog(String message) {
    showDialog(
      context: _buildContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog'),
          content: Text(message),
        );
      },
    );
  }
}
