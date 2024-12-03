// lib/common/offline_storage.dart

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

// Define a class to handle shared preferences and SQLite database
class OfflineStorage {
  // Shared Preferences instance
  static late SharedPreferences _prefs;

  // SQLite database instance
  static late Database _database;

  // Initialize shared preferences and SQLite database
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _database = await _initDatabase();
  }

  // Initialize SQLite database
  static Future<Database> _initDatabase() async {
    final databasePath = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }

  // Shared Preferences operations
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // SQLite database operations
  static Future<void> insertItem(String name) async {
    final db = _database;
    await db.insert(
      'items',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = _database;
    return await db.query('items');
  }

  static Future<void> deleteItem(int id) async {
    final db = _database;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Example usage of OfflineStorage in a Flutter widget
class OfflineStorageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Storage Example'),
      ),
      body: FutureBuilder<void>(
        future: OfflineStorage.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await OfflineStorage.setString('username', 'JohnDoe');
                      final username = OfflineStorage.getString('username');
                      print('Stored Username: $username');
                    },
                    child: Text('Store Username'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await OfflineStorage.insertItem('Sample Item');
                      final items = await OfflineStorage.getItems();
                      print('Stored Items: $items');
                    },
                    child: Text('Store Item'),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
//Purpose: Manages offline storage solutions for persisting data when the app is offline.
// Usage: Used to store and manage data offline to ensure functionality without network connectivity.
