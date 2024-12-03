// lib/common/file_utils.dart

import 'dart:io';

import 'package:path_provider/path_provider.dart';

// Utility class for file operations
class FileUtils {
  // Get the path to the application's documents directory
  static Future<Directory> _getAppDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  // Write content to a file
  static Future<File> writeFile(String fileName, String content) async {
    final dir = await _getAppDirectory();
    final file = File('${dir.path}/$fileName');
    return file.writeAsString(content);
  }

  // Read content from a file
  static Future<String> readFile(String fileName) async {
    try {
      final dir = await _getAppDirectory();
      final file = File('${dir.path}/$fileName');
      return await file.readAsString();
    } catch (e) {
      // Handle any errors that occur during file reading
      print('Error reading file: $e');
      return '';
    }
  }

  // Check if a file exists
  static Future<bool> fileExists(String fileName) async {
    final dir = await _getAppDirectory();
    final file = File('${dir.path}/$fileName');
    return file.exists();
  }

  // Delete a file
  static Future<void> deleteFile(String fileName) async {
    try {
      final dir = await _getAppDirectory();
      final file = File('${dir.path}/$fileName');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Handle any errors that occur during file deletion
      print('Error deleting file: $e');
    }
  }

  // Create a directory if it doesn't exist
  static Future<void> createDirectory(String dirName) async {
    try {
      final appDir = await _getAppDirectory();
      final dir = Directory('${appDir.path}/$dirName');
      if (!(await dir.exists())) {
        await dir.create(recursive: true);
      }
    } catch (e) {
      // Handle any errors that occur during directory creation
      print('Error creating directory: $e');
    }
  }
}
//Purpose: Provides utilities for file handling operations, such as reading and writing files.
// Usage: Used to handle file operations like reading, writing, and deleting files
