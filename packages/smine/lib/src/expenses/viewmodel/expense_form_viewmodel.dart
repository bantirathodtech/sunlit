/// expense_form_viewmodel.dart
/// Manages UI-related data and handles business logic for the view.

import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

import '../../core/util/date_time_utils.dart';

class ExpenseFormViewModel extends ChangeNotifier {
  final ExpenseRepository expenseRepository;
  final LoginViewModel loginViewModel;

  ExpenseFormModel expenseFormData = ExpenseFormModel();
  Map<String, List<String>> dropdownOptions = {};
  bool _isLoading = false;
  String _errorMessage = '';
  String _currentTransactionDate = '';

  // Constructor: initializes the ViewModel with necessary dependencies
  ExpenseFormViewModel({
    required this.expenseRepository,
    required this.loginViewModel,
  }) {
    // _initializeUserData();
  }

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  // String get userName => loginViewModel.userIdData1.username ?? 'UserName';
  //
  // String get name => loginViewModel.userIdData1.name ?? "Name";

  String get userNameUserData =>
      loginViewModel.userIdData1.username ?? 'UserName';

  String get nameUserData => loginViewModel.userIdData1.name ?? "Name";

  String get userRole => loginViewModel.userIdData1.csRole ?? '';

  String get currentTransactionDate => _currentTransactionDate;

  // void updateTransactionDate(String date) {
  //   _currentTransactionDate = date;
  //   expenseFormData.date = date;
  //   notifyListeners();
  // }

  // void _initializeUserData() {
  //   expenseFormData.name = userName;
  //   notifyListeners();
  // }

  // Updates the date
  void updateDate(DateTime date) {
    _currentTransactionDate = DateTimeUtils.formatForDisplay(date);
    expenseFormData.date =
        DateTimeUtils.formatForGraphQL(_currentTransactionDate);
    notifyListeners();
  }

  // Resets the expense form data
  void resetExpenseForm() {
    expenseFormData = ExpenseFormModel(); // Reset to a new instance
    notifyListeners();
  }

  // Fetches dropdown options for the form fields
  Future<void> loadDropdownOptions() async {
    try {
      _setLoading(true);
      for (String fieldName in ExpenseFormFieldIds.expenseFormFieldId.keys) {
        String fieldId = ExpenseFormFieldIds.getExpenseFormFieldId(fieldName);
        List<String> options =
            await expenseRepository.fetchDropdownOptionsFromBackend(fieldId);
        if (options.isNotEmpty) {
          dropdownOptions[fieldName] = options;
        }
      }
      notifyListeners();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  // Submits the expense form data to the repository
  Future<bool> processAndSubmitExpenseForm() async {
    try {
      _setLoading(true);
      final userData = loginViewModel.userIdData1?.toJson() ?? {};
      dev.log('Starting upsert process', name: 'ExpenseFormViewModel');

      // Log the form data and user data before submitting
      dev.log('Form data: ${expenseFormData.toJson()}',
          name: 'ExpenseFormViewModel');
      dev.log('User data: $userData', name: 'ExpenseFormViewModel');

      final result = await expenseRepository.upsertExpenseFormData(
          expenseFormData, userData);

      if (result.code == "200") {
        dev.log('Expense form submitted successfully',
            name: 'ExpenseFormViewModel');
        dev.log('Response code: ${result.code}', name: 'ExpenseFormViewModel');
        dev.log('Response message: ${result.message}',
            name: 'ExpenseFormViewModel');
        dev.log('Submitted form data:', name: 'ExpenseFormViewModel');
        dev.log(expenseFormData.toJson().toString(),
            name: 'ExpenseFormViewModel');

        return true;
      } else {
        throw Exception(result.message);
      }
    } catch (e) {
      _handleError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Updates a specific field in the expense form data
  void updateExpenseFormField(String fieldName, String? newValue) {
    switch (fieldName) {
      case 'name':
        expenseFormData.name = newValue;
        print('Updated name field: $newValue');
        break;
      case 'location':
        expenseFormData.location = newValue;
        break;
      case 'transactionType':
        expenseFormData.transactionType = newValue;
        break;
      case 'payment':
        expenseFormData.payment = newValue;
        break;
      case 'sourceAccount':
        expenseFormData.sourceAccount = newValue;
        break;
      case 'description':
        expenseFormData.description = newValue;
        break;
      case 'businessHead':
        expenseFormData.businessHead = newValue;
        break;
      case 'expenseHead':
        expenseFormData.expenseHead = newValue;
        break;
    }
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _handleError(dynamic error) {
    _errorMessage = error.toString();
    dev.log('Error: $_errorMessage', name: 'ExpenseFormViewModel');
    notifyListeners();
  }
}
