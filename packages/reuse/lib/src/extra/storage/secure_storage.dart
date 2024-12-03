import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create storage
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Write value
  Future<void> writeValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      // Handle errors here
      print('Error writing to secure storage: $e');
    }
  }

  // Read value
  Future<String?> readValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      // Handle errors here
      print('Error reading from secure storage: $e');
      return null;
    }
  }

  // Delete value
  Future<void> deleteValue(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      // Handle errors here
      print('Error deleting from secure storage: $e');
    }
  }

  // Check if a key exists
  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      // Handle errors here
      print('Error checking key in secure storage: $e');
      return false;
    }
  }

  // Delete all values
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      // Handle errors here
      print('Error deleting all values from secure storage: $e');
    }
  }

  // Read all values
  Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      // Handle errors here
      print('Error reading all values from secure storage: $e');
      return {};
    }
  }
}
//Purpose: Handles secure storage operations for sensitive data using Flutter Secure Storage.
// Usage: Used to store sensitive data like tokens and passwords securely.
