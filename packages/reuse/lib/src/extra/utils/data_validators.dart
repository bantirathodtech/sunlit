// lib/common/validators/data_validators.dart

import 'package:intl/intl.dart';

// Validator for email addresses
class EmailValidator {
  static bool isValid(String email) {
    // Basic email validation regex pattern
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }
}

// Validator for phone numbers
class PhoneNumberValidator {
  static bool isValid(String phoneNumber) {
    // Basic phone number validation regex pattern (adjust as needed)
    final RegExp phoneRegExp = RegExp(
      r'^\+?[1-9]\d{1,14}$',
    );
    return phoneRegExp.hasMatch(phoneNumber);
  }
}

// Validator for dates
class DateValidator {
  static bool isValid(String date) {
    try {
      final DateFormat format = DateFormat('yyyy-MM-dd');
      format.parseStrict(date); // Throws FormatException if invalid
      return true;
    } catch (e) {
      return false;
    }
  }
}

// Validator for URLs
class UrlValidator {
  static bool isValid(String url) {
    final RegExp urlRegExp = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
    );
    return urlRegExp.hasMatch(url);
  }
}

// Validator for passwords
class PasswordValidator {
  static bool isValid(String password) {
    // Example criteria: at least 8 characters, including one uppercase letter, one lowercase letter, one digit
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
    );
    return passwordRegExp.hasMatch(password);
  }
}

// Validator for custom data ranges
class RangeValidator {
  static bool isInRange(int value, int min, int max) {
    return value >= min && value <= max;
  }
}
//Purpose: Provides validation logic for various data types beyond form fields.
// Usage: Used to validate complex data types and business logic.
