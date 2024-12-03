import 'package:dio/dio.dart';

class NetworkConfig {
  // Base URL for the API
  static const String _baseUrl = 'https://api.example.com/';

  // Timeout settings
  static const Duration _connectTimeout = Duration(seconds: 5);
  static const Duration _receiveTimeout = Duration(seconds: 3);

  // Default headers
  static const Map<String, dynamic> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Configure Dio with network settings
  static Dio configureDio() {
    final Dio dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      headers: _defaultHeaders,
    ));

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Add authorization token or other request configurations
        // options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
        handler.next(options); // Continue with the request
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Handle response modifications
        handler.next(response); // Continue with the response
      },
      onError: (DioError e, ErrorInterceptorHandler handler) {
        // Handle errors
        handler.next(e); // Continue with the error
      },
    ));

    return dio;
  }
}
//Purpose: Configures network settings such as base URLs, timeouts, and headers.
// Usage: Used to manage and configure network-related settings.
