import 'package:flutter/material.dart';

class DialogUtils {
  // Shows a simple alert dialog
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (negativeButtonText != null)
              TextButton(
                child: Text(negativeButtonText),
                onPressed: () {
                  if (onNegativePressed != null) {
                    onNegativePressed();
                  }
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text(positiveButtonText ?? 'OK'),
              onPressed: () {
                if (onPositivePressed != null) {
                  onPositivePressed();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Shows an input dialog to get text input from the user
  static Future<String?> showInputDialog({
    required BuildContext context,
    required String title,
    required String hintText,
    String? initialValue,
    String? positiveButtonText,
    String? negativeButtonText,
    required ValueChanged<String?> onSubmitted,
  }) async {
    final TextEditingController controller =
        TextEditingController(text: initialValue);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
            autofocus: true,
          ),
          actions: <Widget>[
            if (negativeButtonText != null)
              TextButton(
                child: Text(negativeButtonText),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text(positiveButtonText ?? 'Submit'),
              onPressed: () {
                final input = controller.text;
                onSubmitted(input);
                Navigator.of(context).pop(input);
              },
            ),
          ],
        );
      },
    );
  }

  // Shows a custom dialog with a custom widget
  static Future<void> showCustomDialog({
    required BuildContext context,
    required Widget child,
    String? title,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: child,
          actions: <Widget>[
            if (negativeButtonText != null)
              TextButton(
                child: Text(negativeButtonText),
                onPressed: () {
                  if (onNegativePressed != null) {
                    onNegativePressed();
                  }
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text(positiveButtonText ?? 'OK'),
              onPressed: () {
                if (onPositivePressed != null) {
                  onPositivePressed();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
//Purpose: Provides methods for showing dialogs and handling user input through dialogs.
// Usage: Used to manage and show dialogs consistently across the app.
