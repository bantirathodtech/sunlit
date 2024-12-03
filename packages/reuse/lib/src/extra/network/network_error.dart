// lib/common/network_error.dart

import 'package:flutter/material.dart';

// Define network-related error classes
class NetworkError implements Exception {
  final String message;
  NetworkError(this.message);

  @override
  String toString() => 'NetworkError: $message';
}

class TimeoutError extends NetworkError {
  TimeoutError(String message) : super(message);
}

class NotFoundError extends NetworkError {
  NotFoundError(String message) : super(message);
}

class UnauthorizedError extends NetworkError {
  UnauthorizedError(String message) : super(message);
}

class UnknownError extends NetworkError {
  UnknownError(String message) : super(message);
}

// Utility methods to handle errors
void handleNetworkError(BuildContext context, NetworkError error) {
  String errorMessage;

  if (error is TimeoutError) {
    errorMessage = 'Request timed out. Please try again.';
  } else if (error is NotFoundError) {
    errorMessage = 'The requested resource was not found.';
  } else if (error is UnauthorizedError) {
    errorMessage = 'Unauthorized access. Please log in again.';
  } else if (error is UnknownError) {
    errorMessage = 'An unknown error occurred. Please try again.';
  } else {
    errorMessage = 'A network error occurred. Please check your connection.';
  }

  // Show an error dialog or toast message
  _showErrorDialog(context, errorMessage);
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
//Purpose: Defines and handles network-related errors and connectivity issues.
// Usage: Used to define and manage network errors and connectivity issues.
