import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Observer for the navigation events
  static FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  // Log a custom event
  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  // Set user ID
  static Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  // Set user properties
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  // Log predefined events
  static Future<void> logLogin({String method = 'default'}) async {
    await _analytics.logLogin(loginMethod: method);
  }

  static Future<void> logSignUp({String method = 'default'}) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  static Future<void> logPurchase({
    required String itemName,
    required double price,
    String currency = 'USD',
  }) async {
    await _analytics.logEvent(
      name: 'purchase',
      parameters: {
        'item_name': itemName,
        'price': price,
        'currency': currency,
      },
    );
  }

// More predefined events can be added here
}
//Purpose: Integrates with analytics tools to track user interactions, events, and application usage.
// Usage: Used to log events and user interactions for analytics purposes.
