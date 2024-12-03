// lib/common/error_pages.dart

import 'package:flutter/material.dart';

// Base Error Page
class ErrorPage extends StatelessWidget {
  final String title;
  final String message;
  final String imagePath;

  ErrorPage({
    required this.title,
    required this.message,
    this.imagePath = 'assets/images/error.png', // Default image path
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 200, width: 200),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// 400 Bad Request Page
class BadRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      title: '400 Bad Request',
      message:
          'The server could not understand the request due to invalid syntax.',
      imagePath: 'assets/images/400.png', // Custom image for 400
    );
  }
}

// 402 Payment Required Page
class PaymentRequiredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      title: '402 Payment Required',
      message: 'Payment is required to access this resource.',
      imagePath: 'assets/images/402.png', // Custom image for 402
    );
  }
}

// 409 Conflict Page
class ConflictPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      title: '409 Conflict',
      message:
          'The request could not be completed due to a conflict with the current state of the resource.',
      imagePath: 'assets/images/409.png', // Custom image for 409
    );
  }
}

// 422 Unprocessable Entity Page
class UnprocessableEntityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      title: '422 Unprocessable Entity',
      message:
          'The server understands the content type of the request entity, but was unable to process the contained instructions.',
      imagePath: 'assets/images/422.png', // Custom image for 422
    );
  }
}

// 429 Too Many Requests Page
class TooManyRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      title: '429 Too Many Requests',
      message: 'You have sent too many requests in a given amount of time.',
      imagePath: 'assets/images/429.png', // Custom image for 429
    );
  }
}

// Example Usage
// Navigator.of(context).push(MaterialPageRoute(
//   builder: (context) => BadRequestPage(),
// ));
//
//Purpose: Provides custom error pages for displaying when errors occur (e.g., 404, 500).
// Usage: Used to show user-friendly error pages when errors occur.
