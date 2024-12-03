import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkStatus with ChangeNotifier {
  List<ConnectivityResult> _connectivityResult = [ConnectivityResult.none];

  bool get isConnected =>
      _connectivityResult.isNotEmpty &&
      _connectivityResult.first != ConnectivityResult.none;

  NetworkStatus() {
    _initConnectivity();
    Connectivity().onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  Future<void> _initConnectivity() async {
    try {
      final List<ConnectivityResult> results =
          await Connectivity().checkConnectivity();
      _updateConnectivityStatus(results);
    } catch (e) {
      // Handle any errors that occur during connectivity check
      print('Error checking connectivity: $e');
    }
  }

  void _updateConnectivityStatus(List<ConnectivityResult> results) {
    if (_connectivityResult != results) {
      _connectivityResult = results;
      notifyListeners();
    }
  }
}
//Purpose: Monitors and manages network connectivity status and offline capabilities.
// Usage: Used to check and manage network status and offline mode.
