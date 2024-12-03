import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

class ExpenseRepository {
  final ExpenseApiService _expenseApiService;

  // Constructor: initializes the repository with the expense API service
  ExpenseRepository({required ExpenseApiService apiService})
      : _expenseApiService = apiService;

  // Fetches options for dropdown fields from the API
  Future<List<String>> fetchDropdownOptionsFromBackend(String fieldId) async {
    dev.log('Fetching dropdown options for fieldId: $fieldId',
        name: 'ExpenseRepository');
    Logger.info('Fetching dropdown options for fieldId: $fieldId',
        tag: 'ExpenseRepository');

    try {
      return await _expenseApiService.fetchDropdownOptionsFromBackend(fieldId);
    } catch (e) {
      dev.log('Error fetching dropdown options: $e', name: 'ExpenseRepository');
      Logger.error('Error fetching dropdown options',
          tag: 'ExpenseRepository', error: e);
      rethrow;
    }
  }

  // Submits the expense form data to the API
  Future<ExpenseSubmissionResult> upsertExpenseFormData(
    ExpenseFormModel formData,
    Map<String, dynamic> userData,
  ) async {
    dev.log('Submitting expense form', name: 'ExpenseRepository');
    try {
      dev.log('Sending upsert request to API', name: 'ExpenseRepository');

      final apiResponse =
          await _expenseApiService.postExpenseDataToApi(formData, userData);
      return _convertApiResponseToSubmissionResult(apiResponse);
    } catch (e) {
      dev.log('Error sending expense form to backend: $e',
          name: 'ExpenseRepository');
      rethrow;
    }
  }

  // Maps API response to a more generic SubmissionResult
  ExpenseSubmissionResult _convertApiResponseToSubmissionResult(
      ApiResponse apiResponse) {
    return ExpenseSubmissionResult(
      code: apiResponse.data.upsertExpenseVouchers.code,
      message: apiResponse.data.upsertExpenseVouchers.message,
    );
  }
}

// A generic class to represent the result of a form submission
class ExpenseSubmissionResult {
  final String code;
  final String message;

  ExpenseSubmissionResult({required this.code, required this.message});
}
