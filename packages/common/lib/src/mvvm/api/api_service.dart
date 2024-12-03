import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

class ApiService {
  final Dio _dio;

  // final LocalDB _localDB;

  // Constructor: initializes the API service with a Dio instance
  ApiService({
    required Dio dio,
  }) : _dio = dio;

  /// Sends a login request
  Future<dynamic> sendLoginRequest(
      String url, Map<String, dynamic> data) async {
    dev.log('Sending login request', name: 'ApiService');

    try {
      // Send POST request to login URL with provided data
      var response = await _dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: generateLoginHeaders(),
          sendTimeout: const Duration(seconds: 30),
          // 30 seconds timeout  to handle cases where the server is unreachable
          receiveTimeout: const Duration(
              seconds:
                  30), // 30 seconds timeout  to handle cases where the server is unreachable
        ),
        data: data,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        dev.log('Login request successful', name: 'ApiService');
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Login failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      dev.log('Login request failed: $e', name: 'ApiService');
      rethrow;
    }
  }

  /// Inserts a new user
  Future<dynamic> createNewUser(String endPoint) async {
    try {
      final response = await _dio.post(endPoint);
      return response.data;
    } catch (e) {
      throw Exception('Failed to insert user: ${e.toString()}');
    }
  }

  /// Sends a GraphQL request to fetch the scanned data for multiple screen to get the dynamic data
  Future<dynamic> sendGraphQLRequest(String url, dynamic body,
      {Map<String, dynamic>? variables}) async {
    dev.log('Sending GraphQL request', name: 'ApiService');

    try {
      // print('ApiService: Sending request to $url');
      // print('ApiService: Request body: $body');
      //
      // print('ApiService: Full request data:');
      // print(json.encode({
      //   'query': body['mutation'],
      //   'variables': variables,
      // }));
      final headers = await generateAuthHeaders(accessToken);
      // final headers = await generateAuthHeaders(accessToken); //25-07
      // print(accessToken.accessToken.toString());
      // print('ApiService: Headers:');
      // print(headers);

      var requestData = {
        'query': body['mutation'],
        'variables': variables,
      };

      dev.log('Request URL: $url', name: 'ApiService');
      dev.log('Request Headers: $headers', name: 'ApiService');
      dev.log('Request Data: $requestData', name: 'ApiService');

      var response = await _dio.post(
        url,
        options: Options(
          method: 'POST',
          headers: await generateAuthHeaders(accessToken), //25-07
          // headers: headers,
        ),
        // data: body,
        data: requestData,

        // data: {
        //   'query': body['mutation'],
        //   'variables': variables,
        // },
      );

      print('ApiService: Response status code: ${response.statusCode}');
      print('ApiService: Response body: ${response.data}');

      if (response.statusCode == 200) {
        dev.log('GraphQL request successful', name: 'ApiService');
        // Print the data after the successful request log
        print('ApiService: Successful response data:');
        print(
            json.encode(response.data)); // Use json.encode for pretty printing
        return response.data; // Ensure this is the parsed JSON, not a string
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error:
              'GraphQL request failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        dev.log('Token expired, attempting to refresh', name: 'ApiService');
        // Token might be expired, try to refresh it
        String refreshResult = await refreshAccessToken();
        if (refreshResult == "Success") {
          // If token refresh was successful, retry the request
          // return fetchGraphQLData(url, body, variables: {});
          return sendGraphQLRequest(url, body, variables: variables);
        } else {
          // If token refresh failed, throw an exception
          dev.log('Token refresh failed', name: 'ApiService');
          throw Exception('Authentication failed. Please log in again.');
        }
      } else if (e.response?.statusCode == 400) {
        // Handle bad request error
      }
      // print('ApiService: DioError type: ${e.type}');
      // print('ApiService: DioError message: ${e.message}');
      // print('ApiService: DioError response status: ${e.response?.statusCode}');
      // print('ApiService: DioError response data: ${e.response?.data}');
      // print('ApiService: DioError response headers: ${e.response?.headers}');
      dev.log('GraphQL request failed: $e', name: 'ApiService');
      rethrow;
    }
  }

  //This is a more general-purpose method for making GraphQL requests.
  // It's designed to handle both queries and mutations.
  // It takes a URL, a body (which includes the GraphQL query or mutation), and optional variables.
  // It's more flexible and can be used for various types of GraphQL operations

  /// Sends a common entity task data request
  Future<dynamic> commonEntTaskData(
      String url, var data, AccessToken accessToken) async {
    try {
      dev.log('Sending request to $url', name: 'ApiService');
      dev.log('Request data: ${json.encode(data)}', name: 'ApiService');
      dev.log('Headers: ${generateAuthHeaders(accessToken)}',
          name: 'ApiService');

      var response = await _dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: generateAuthHeaders(accessToken),
        ),
        data: data,
      );
      dev.log('Response status code: ${response.statusCode}',
          name: 'ApiService');
      dev.log('Response data: ${json.encode(response.data)}',
          name: 'ApiService');

      var jsonValue = json.encode(response.data);
      //log("jsonValue.....$jsonValue");
      //printMessage(jsonValue);
      if (response.statusCode == 200) {
        if (jsonValue.contains("error")) {
          showSnackBar(jsonValue.toString());
          throw Exception(jsonValue.toString());
        } else {
          return response.data;
        }
      } else {
        throw Exception('${response.statusMessage}');
      }
    } catch (e) {
      printMessage("api....error....$e");
      dev.log('Error in commonEntTaskData: $e', name: 'ApiService');

      if (e is DioException) {
        dev.log('DioException details: ${e.response?.data}',
            name: 'ApiService');

        if (e.response?.statusCode == 401 || e.response?.statusCode == 500) {
          String status = await refreshAccessToken();
          printMessage("status.....$status");
          if (status == "Success") {
            return commonEntTaskData(url, data, accessToken);
          }
        }
      }
      throw Exception(e.toString());
    }
  }

//This method seems to be more specific to certain types of tasks or entities in your application.
// It's designed for POST requests, specifically for entity-related tasks.
// It includes some specific error handling and processing, like checking for "error" in the response.
// It might be tailored for a particular API endpoint or set of endpoints in your application.

  ///to check the query ot mutation
  // Future<dynamic> commonEntTaskData(
  //     String url, Map<String, dynamic> data, AccessToken accessToken) async {
  //   try {
  //     dev.log('Sending request to $url', name: 'ApiService');
  //     dev.log('Request data: ${json.encode(data)}', name: 'ApiService');
  //     dev.log('Headers: ${generateAuthHeaders(accessToken)}', name: 'ApiService');
  //
  //     // Determine if it's a query or mutation based on the data
  //     String operationType = data.containsKey('query') ? 'query' : 'mutation';
  //
  //     var response = await _dio.request(
  //       url,
  //       options: Options(
  //         method: 'POST',
  //         headers: generateAuthHeaders(accessToken),
  //       ),
  //       data: {operationType: data[operationType]},
  //     );
  //
  //     dev.log('Response status code: ${response.statusCode}',
  //         name: 'ApiService');
  //     dev.log('Response data: ${json.encode(response.data)}',
  //         name: 'ApiService');
  //
  //     if (response.statusCode == 200) {
  //       if (response.data.toString().contains("error")) {
  //         throw Exception(response.data.toString());
  //       } else {
  //         return response.data;
  //       }
  //     } else {
  //       throw DioException(
  //         requestOptions: response.requestOptions,
  //         response: response,
  //         error: 'Request failed with status code: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     dev.log('Error in commonEntTaskData: $e', name: 'ApiService');
  //     if (e is DioException) {
  //       dev.log('DioException details: ${e.response?.data}',
  //           name: 'ApiService');
  //       if (e.response?.statusCode == 401 || e.response?.statusCode == 500) {
  //         String status = await refreshAccessToken();
  //         if (status == "Success") {
  //           return commonEntTaskData(url, data, accessToken);
  //         }
  //       }
  //     }
  //     rethrow;
  //   }
  // }
  ///to check the query ot mutation

  /// Refreshes the access token
  Future<String> refreshAccessToken() async {
    try {
      var data = {
        'username': accessToken.userName,
        'password': accessToken.password,
      };

      var response = await _dio.request(
        plgAuthUrl,
        options: Options(
          method: 'POST',
          headers: generateLoginHeaders(),
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        var jsonValue = json.encode(response.data);
        printMessage(jsonValue);
        accessToken.accessToken = response.data["accessToken"];
        // saveUserToken(accessToken);
        saveUserToken(accessToken);
        return "Success";
      } else {
        return "Failure";
      }
    } catch (e) {
      return "Failure";
    }
  }

  /// Gets the login headers
  Map<String, String> generateLoginHeaders() {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers':
          'authorization, Content-Type, Accept, X-Requested-With, remember-me',
      'Access-Control-Allow-Methods': 'POST, GET, PUT, OPTIONS, DELETE',
      'Authorization': 'Basic dGFsazJhbWFyZXN3YXJhbjpteS1zZWNyZXQ='
    };
  }

  /// Gets the auth headers
  // Map<String, String> generateAuthHeaders() {
  ///    // Use generateAuthHeaders to get the headers
  Map<String, String> generateAuthHeaders(AccessToken accessToken) {
    //25-07
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      // 'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers':
          'authorization, Content-Type, Accept, X-Requested-With, remember-me',
      'Access-Control-Allow-Methods': 'POST, GET, PUT, OPTIONS, DELETE',
      'Authorization': 'Bearer ${accessToken.accessToken.toString().trim()}'
    };
  }
}
