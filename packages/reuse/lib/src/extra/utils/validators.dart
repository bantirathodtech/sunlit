/// Provides validation logic for user inputs and form fields.
class Validators {
  //TODO: Validates if the input is a non-empty string.
  /// Validates if the input is a non-empty string.
  static String? validateNonEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  //TODO: Validates if the input is a valid email address.
  /// Validates if the input is a valid email address.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  //TODO: Validates if the input is a valid phone number.
  /// Validates if the input is a valid phone number.
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final RegExp phoneRegExp = RegExp(r'^\+?1?\d{9,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  //TODO: Validates if the input meets the minimum length requirement.
  /// Validates if the input meets the minimum length requirement.
  static String? validateMinLength(String? value, int minLength) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < minLength) {
      return 'Minimum length is $minLength characters';
    }
    return null;
  }

  //TODO: Validates if the input is a valid password.
  /// Validates if the input is a valid password.
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
    );
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters, include an uppercase letter, a lowercase letter, and a number';
    }
    return null;
  }

  /// Validates if the input is a number.
  //TODO: Validates if the input is a number.
  static String? validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    final RegExp numberRegExp = RegExp(r'^\d+$');
    if (!numberRegExp.hasMatch(value)) {
      return 'Must be a number';
    }
    return null;
  }
}
//Purpose: Provides validation logic for user inputs and form fields.
// Usage: Used to validate user input in forms and other data entry points.
