// lib/common/navigation_service.dart

import 'package:flutter/material.dart';

class NavigationService {
  // Create a GlobalKey for the Navigator
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Push a route
  Future<void> navigateTo(String routeName, {Object? arguments}) async {
    await _navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  // Push a route and replace the current one
  Future<void> replaceWith(String routeName, {Object? arguments}) async {
    await _navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  // Pop the current route
  void goBack() {
    _navigatorKey.currentState?.pop();
  }

  // Pop to a specific route
  void popUntil(String routeName) {
    _navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  // Clear all routes and push a new one
  Future<void> resetTo(String routeName, {Object? arguments}) async {
    await _navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}

// Initialize NavigationService and provide it via the app's widget tree
void main() {
  final navigationService = NavigationService();

  runApp(MyApp(navigationService: navigationService));
}

class MyApp extends StatelessWidget {
  final NavigationService navigationService;

  MyApp({required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: _onGenerateRoute,
      initialRoute: '/',
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/details':
        return MaterialPageRoute(
            builder: (context) => DetailsPage(arguments: settings.arguments));
      default:
        return MaterialPageRoute(builder: (context) => ErrorPage());
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NavigationService()
                .navigateTo('/details', arguments: 'Hello from Home');
          },
          child: Text('Go to Details'),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Object? arguments;

  DetailsPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Page')),
      body: Center(
        child: Text('Arguments: $arguments'),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(
        child: Text('Page not found'),
      ),
    );
  }
}
//Purpose: Provides a centralized way to manage app navigation and routing.
// Usage: Used to handle and manage navigation across the app.
