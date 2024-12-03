// lib/common/lifecycle_manager.dart

import 'package:flutter/material.dart';

// Define a callback type for lifecycle events
typedef LifecycleCallback = void Function(AppLifecycleState state);

class LifecycleManager extends WidgetsBindingObserver {
  // Singleton instance for LifecycleManager
  static final LifecycleManager _instance = LifecycleManager._internal();

  // Private constructor
  LifecycleManager._internal();

  // Factory constructor to return the singleton instance
  factory LifecycleManager() {
    return _instance;
  }

  // Callback to handle lifecycle events
  LifecycleCallback? onLifecycleEvent;

  // Initialize the lifecycle manager
  void init() {
    WidgetsBinding.instance!.addObserver(this);
  }

  // Dispose of the lifecycle manager
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Invoke the callback if it's set
    if (onLifecycleEvent != null) {
      onLifecycleEvent!(state);
    }
  }
}

// Usage Example
void main() {
  final lifecycleManager = LifecycleManager();

  lifecycleManager.onLifecycleEvent = (AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('App is resumed');
        // Handle app resumed
        break;
      case AppLifecycleState.inactive:
        print('App is inactive');
        // Handle app inactive
        break;
      case AppLifecycleState.paused:
        print('App is paused');
        // Handle app paused
        break;
      case AppLifecycleState.detached:
        print('App is detached');
        // Handle app detached
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  };

  // Initialize the lifecycle manager
  lifecycleManager.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lifecycle Manager Example')),
        body: Center(child: Text('Check console for lifecycle events')),
      ),
    );
  }
}
//Purpose: Handles app lifecycle events such as when the app is paused, resumed, or detached.
// Usage: Used to manage and respond to app lifecycle events.
