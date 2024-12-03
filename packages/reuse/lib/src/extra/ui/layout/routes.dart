import 'package:flutter/material.dart';
// import 'package:your_app/screens/home_screen.dart';
// import 'package:your_app/screens/details_screen.dart';
// import 'package:your_app/screens/settings_screen.dart';

class AppRoutes {
  // Named routes
  static const String home = '/';
  static const String details = '/details';
  static const String settings = '/settings';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case home:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      // case details:
      //   return MaterialPageRoute(builder: (_) => DetailsScreen());
      // case settings:
      //   return MaterialPageRoute(builder: (_) => SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

// Usage in the main app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
//Purpose: Manages navigation and routing logic for different screens in the app.
// Usage: Used to define and manage routes for navigation between different screens.
