import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkInterceptor {
  final String _baseUrl;
  final Map<String, String> _defaultHeaders;

  NetworkInterceptor(this._baseUrl, this._defaultHeaders);

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    return await _sendRequest('GET', endpoint, headers: headers);
  }

  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    return await _sendRequest('POST', endpoint, headers: headers, body: body);
  }

  Future<http.Response> put(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    return await _sendRequest('PUT', endpoint, headers: headers, body: body);
  }

  Future<http.Response> delete(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    return await _sendRequest('DELETE', endpoint, headers: headers, body: body);
  }

  Future<http.Response> _sendRequest(String method, String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final requestHeaders = {
      ..._defaultHeaders,
      if (headers != null) ...headers
    };

    try {
      final response = await http.Request(method, url)
        ..headers.addAll(requestHeaders)
        ..body = (body != null ? json.encode(body) : null)!;

      final streamedResponse = await response.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (error) {
      // Handle errors, you can add custom logic to handle specific error codes
      print('Network error: $error');
      rethrow;
    }
  }
}

void main() {
  final networkInterceptor = NetworkInterceptor(
    'https://api.example.com/',
    {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token_here'
    },
  );

  // Example usage:
  networkInterceptor.get('/endpoint').then((response) {
    print('GET response: ${response.body}');
  });

  networkInterceptor.post('/endpoint', body: {'key': 'value'}).then((response) {
    print('POST response: ${response.body}');
  });
}
//Purpose: Manages network requests and responses, including adding headers and handling authentication.
// Usage: Used to intercept and modify network requests, e.g., adding authentication tokens to headers.
