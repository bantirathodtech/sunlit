// lib/common/json_utils.dart

import 'dart:convert';

// Utility class for JSON operations
class JsonUtils {
  // Convert a JSON string to a Dart object
  static Map<String, dynamic> parseJson(String jsonString) {
    try {
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // Handle JSON parsing errors
      print('Error parsing JSON: $e');
      return {};
    }
  }

  // Convert a Dart object to a JSON string
  static String toJson(Map<String, dynamic> jsonObject) {
    try {
      return json.encode(jsonObject);
    } catch (e) {
      // Handle JSON encoding errors
      print('Error encoding JSON: $e');
      return '{}';
    }
  }

  // Convert a JSON string to a list of Dart objects
  static List<dynamic> parseJsonList(String jsonString) {
    try {
      return json.decode(jsonString) as List<dynamic>;
    } catch (e) {
      // Handle JSON parsing errors
      print('Error parsing JSON list: $e');
      return [];
    }
  }

  // Convert a list of Dart objects to a JSON string
  static String toJsonList(List<dynamic> jsonList) {
    try {
      return json.encode(jsonList);
    } catch (e) {
      // Handle JSON encoding errors
      print('Error encoding JSON list: $e');
      return '[]';
    }
  }

  // Safely get a value from a JSON map with a default value
  static dynamic getValue(Map<String, dynamic> jsonObject, String key,
      [dynamic defaultValue]) {
    return jsonObject.containsKey(key) ? jsonObject[key] : defaultValue;
  }

  // Convert a Dart object to a pretty-printed JSON string
  static String toPrettyJson(Map<String, dynamic> jsonObject) {
    try {
      return const JsonEncoder.withIndent('  ').convert(jsonObject);
    } catch (e) {
      // Handle JSON encoding errors
      print('Error encoding pretty JSON: $e');
      return '{}';
    }
  }
}
//Purpose: Contains utilities for parsing and handling JSON data.
// Usage: Used to parse and manipulate JSON data.
