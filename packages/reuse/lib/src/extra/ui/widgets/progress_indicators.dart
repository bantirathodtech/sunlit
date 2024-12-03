import 'package:flutter/material.dart';

// Custom circular progress indicator
class CustomCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final Color color;

  CustomCircularProgressIndicator({
    this.strokeWidth = 4.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color,
        ),
      ),
    );
  }
}

// Custom linear progress indicator
class CustomLinearProgressIndicator extends StatelessWidget {
  final Color color;

  CustomLinearProgressIndicator({
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.0,
      child: LinearProgressIndicator(
        color: color,
      ),
    );
  }
}

// Custom progress dialog
class ProgressDialog extends StatelessWidget {
  final String message;

  ProgressDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomCircularProgressIndicator(),
            SizedBox(width: 16),
            Expanded(
              child: Text(message, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

// Utility function to show a progress dialog
void showProgressDialog({
  required BuildContext context,
  required String message,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ProgressDialog(message: message);
    },
  );
}

// Utility function to hide the progress dialog
void hideProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}
//Purpose: Contains custom progress indicators and loaders for various states.
// Usage: Used to provide consistent progress indicators and loaders.
