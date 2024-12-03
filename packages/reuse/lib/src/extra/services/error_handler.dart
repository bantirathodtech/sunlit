import 'dart:async';

import 'package:flutter/material.dart';

class ErrorHandler {
  static void handleError(Object error, StackTrace stackTrace) {
    // Log the error and stack trace
    // Logger.error('An error occurred', error: error, stackTrace: stackTrace);

    // Perform additional error handling if necessary
    _showErrorDialog(error);
  }

  static void _showErrorDialog(Object error) {
    // Customize the error message display here
    String errorMessage = _formatErrorMessage(error);

    // Assuming you have access to the current BuildContext
    final BuildContext? context = _getCurrentContext();
    if (context != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
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
  }

  static String _formatErrorMessage(Object error) {
    // Customize the error message formatting here
    if (error is Exception) {
      return error.toString();
    } else if (error is String) {
      return error;
    } else {
      return 'An unknown error occurred';
    }
  }

  static BuildContext? _getCurrentContext() {
    // This method should be implemented to return the current BuildContext
    // One way to achieve this is by using a global key or a navigator key
    return null;
  }
}

class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  CustomErrorWidget({required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    // Log the error using the error handler
    ErrorHandler.handleError(errorDetails.exception, errorDetails.stack!);

    // Customize the error widget display here
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(child: Text('An error occurred, please try again later.')),
    );
  }
}

void setupErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    // Call the error handler when a Flutter error occurs
    ErrorHandler.handleError(details.exception, details.stack!);
  };

  // Catch and handle any errors from the runZonedGuarded function
  runZonedGuarded(() {
    // Your app's main function or entry point
  }, (Object error, StackTrace stackTrace) {
    ErrorHandler.handleError(error, stackTrace);
  });
}
//Purpose: Manages error handling and formats error messages for better user feedback.
// Usage: Used to catch, handle, and display errors in a user-friendly way.
