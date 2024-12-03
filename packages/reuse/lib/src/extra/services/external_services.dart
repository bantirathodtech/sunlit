// lib/common/external_services.dart

import 'package:http/http.dart' as http;

// Example 1: Payment Gateway Service

class PaymentService {
  final String apiKey;
  final String apiEndpoint;

  PaymentService({required this.apiKey, required this.apiEndpoint});

  Future<void> processPayment(
      String amount, String currency, String paymentMethod) async {
    // Example API request to process a payment
    final response = await http.post(
      Uri.parse('$apiEndpoint/processPayment'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: {
        'amount': amount,
        'currency': currency,
        'paymentMethod': paymentMethod,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful payment processing
      print('Payment processed successfully');
    } else {
      // Handle errors
      throw Exception('Failed to process payment');
    }
  }
}

// Example 2: Third-Party API Service

class ThirdPartyApiService {
  final String apiKey;
  final String apiEndpoint;

  ThirdPartyApiService({required this.apiKey, required this.apiEndpoint});

  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await http.get(
      Uri.parse('$apiEndpoint/$endpoint'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      // Parse and return data
      return Future.value(Map<String, dynamic>.from(response.body as Map));
    } else {
      // Handle errors
      throw Exception('Failed to fetch data');
    }
  }
}

// Example usage

void main() async {
  final paymentService = PaymentService(
    apiKey: 'your_payment_gateway_api_key',
    apiEndpoint: 'https://api.paymentgateway.com',
  );

  final thirdPartyApiService = ThirdPartyApiService(
    apiKey: 'your_third_party_api_key',
    apiEndpoint: 'https://api.thirdparty.com',
  );

  try {
    // Process payment
    await paymentService.processPayment('100', 'USD', 'card_123');

    // Fetch data from third-party API
    final data = await thirdPartyApiService.fetchData('some-endpoint');
    print('Fetched data: $data');
  } catch (e) {
    print('Error: $e');
  }
}
//Purpose: Integrates with external services like payment gateways or third-party APIs.
// Usage: Used to manage and integrate external services and APIs.
