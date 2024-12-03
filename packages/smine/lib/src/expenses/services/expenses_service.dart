import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

class ExpenseApiService {
  final ApiService _coreApiService;

  // Constructor: initializes the service with the API service
  ExpenseApiService({required ApiService apiService})
      : _coreApiService = apiService;

  // Fetches options for dropdown fields from the API
  Future<List<String>> fetchDropdownOptionsFromBackend(String fieldId) async {
    dev.log('Fetching options for fieldId: $fieldId', name: 'ExpenseService');
    try {
      final data = {
        'query': generateExpenseFieldOptionsQuery(
          fieldId,
          "7288",
          "270EED9D0E7F4C43B227FEDC44C5858F",
          json.encode({"date": null}),
        )
      };
      final queryData = json.encode(data);

      final response = await _coreApiService.commonEntTaskData(
        plgCoreGraphQlUrl,
        queryData,
        accessToken,
      );

      if (response['data']?['searchField'] != null) {
        final jsonData = json.decode(response["data"]["searchField"]);
        if (jsonData['searchData'] != null) {
          return (jsonData['searchData'] as List)
              .map((data) => data['Name']?.toString() ?? '')
              .where((option) => option.isNotEmpty)
              .toList();
        }
      }

      return [];
    } catch (e) {
      dev.log('Error fetching options: $e', name: 'ExpenseService');
      rethrow;
    }
  }

  // Submits the expense form data to the API
  Future<ApiResponse> postExpenseDataToApi(
    ExpenseFormModel formData,
    Map<String, dynamic> userData,
  ) async {
    dev.log('Upserting expense form', name: 'ExpenseService');
    try {
      final mutationData = generateUpsertExpenseMutation(formData, userData);

      // Combine the mutation and variables into a single object
      final requestBody = {
        'query': mutationData['query'],
        'variables': mutationData['variables'],
      };

      final response = await _coreApiService.commonEntTaskData(
        plgGraphQlUrl,
        requestBody,
        accessToken,
      );

      if (response.containsKey('errors')) {
        throw Exception('GraphQL Error: ${response['errors'][0]['message']}');
      }

      return ApiResponse.fromJson(response);
    } catch (e) {
      dev.log('Error upserting expense voucher: $e', name: 'ExpenseService');
      rethrow;
    }
  }
}
