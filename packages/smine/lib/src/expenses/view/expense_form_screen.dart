// filename: expense_form_screen.dart for UI
import 'dart:async';
import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

import '../../collection/sharedWidgets/shared_widgets.dart';
import '../../core/util/date_time_utils.dart';
import '../../core/util/form_fields.dart';
import '../utils/expense_printer.dart';

class ExpenseFormScreen extends StatefulWidget {
  const ExpenseFormScreen({super.key, required UserRole userRole});

  @override
  _ExpenseFormScreenState createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for the form.
  late ExpenseFormModel expenseFormModel; // Model to store form data.

  Timer? _timer; // Timer to periodically update time.

  @override
  void initState() {
    super.initState();
    expenseFormModel = ExpenseFormModel(); // Initialize the form model.
    _startTimeUpdates(); // Start the timer for time updates.

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch dropdown options after the first frame is rendered.
      Provider.of<ExpenseFormViewModel>(context, listen: false)
          .loadDropdownOptions();
    });
  }

  // Starts a timer that updates the time every second.
  void _startTimeUpdates() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  // Updates the form model with the current date and time.
  void _updateTime() {
    if (mounted) {
      setState(() {
        final now = DateTime.now();
        expenseFormModel.date = DateTimeUtils.formatForDisplay(now);
        Provider.of<ExpenseFormViewModel>(context, listen: false)
            .updateDate(now);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseFormViewModel, LoginViewModel>(
      builder: (context, expenseFormViewModel, loginViewModel, _) {
        // final userName = expenseFormViewModel.userName;
        // final name = expenseFormViewModel.name;
        final userNameUserData = expenseFormViewModel.userNameUserData;
        final nameUserData = expenseFormViewModel.nameUserData;

        return Scaffold(
          appBar: SharedWidgetsExpense.buildAppBar(
            nameUserData,
            expenseFormModel.date,
          ),
          drawer:
              SharedWidgetsCollection.buildDrawer(context, userNameUserData),
          body: _buildBody(expenseFormViewModel),
        );
      },
    );
  }

  // Builds the main body of the form.
  Widget _buildBody(ExpenseFormViewModel viewModel) {
    return viewModel.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormFields.buildTextExpenseField(
                              fieldName: 'Expense Name',
                              initialValue: viewModel.expenseFormData.name,
                              onChanged: (newValue) => viewModel
                                  .updateExpenseFormField('name', newValue),
                            ),
                            // Text(
                            //   'Expense Details',
                            //   style: Theme.of(context).textTheme.titleLarge,
                            // ),
                            // const SizedBox(height: 16),
                            // _buildDropdownField('location', viewModel),
                            // _buildTextField('name', viewModel),
                            FormFields.buildDropdownField(
                              fieldName: 'transactionType',
                              value: viewModel.expenseFormData.transactionType,
                              options:
                                  viewModel.dropdownOptions['transactionType'],
                              onChanged: (newValue) =>
                                  viewModel.updateExpenseFormField(
                                      'transactionType', newValue),
                            ),
                            FormFields.buildTextExpenseField(
                              fieldName: 'payment',
                              initialValue: viewModel.expenseFormData.payment,
                              onChanged: (newValue) => viewModel
                                  .updateExpenseFormField('payment', newValue),
                            ),
                            FormFields.buildDropdownField(
                              fieldName: 'sourceAccount',
                              value: viewModel.expenseFormData.sourceAccount,
                              options:
                                  viewModel.dropdownOptions['sourceAccount'],
                              onChanged: (newValue) =>
                                  viewModel.updateExpenseFormField(
                                      'sourceAccount', newValue),
                            ),
                            FormFields.buildTextExpenseField(
                              fieldName: 'description',
                              initialValue:
                                  viewModel.expenseFormData.description,
                              onChanged: (newValue) =>
                                  viewModel.updateExpenseFormField(
                                      'description', newValue),
                            ),
                            FormFields.buildDropdownField(
                              fieldName: 'businessHead',
                              value: viewModel.expenseFormData.businessHead,
                              options:
                                  viewModel.dropdownOptions['businessHead'],
                              onChanged: (newValue) =>
                                  viewModel.updateExpenseFormField(
                                      'businessHead', newValue),
                            ),
                            FormFields.buildDropdownField(
                              fieldName: 'expenseHead',
                              value: viewModel.expenseFormData.expenseHead,
                              options: viewModel.dropdownOptions['expenseHead'],
                              onChanged: (newValue) =>
                                  viewModel.updateExpenseFormField(
                                      'expenseHead', newValue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 16),
                    // Card(
                    //   elevation: 4,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'Additional Information',
                    //           style: Theme.of(context).textTheme.titleLarge,
                    //         ),
                    //         const SizedBox(height: 16),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => onSubmitPressed(viewModel),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Submit Expense',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  // // Builds a dropdown field for the form.
  // Widget _buildDropdownField(String fieldName, ExpenseFormViewModel viewModel) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16.0),
  //     child: DropdownButtonFormField<String>(
  //       value: viewModel.expenseFormData.toJson()[fieldName] as String?,
  //       items: viewModel.dropdownOptions[fieldName]?.map((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //       onChanged: (newValue) =>
  //           viewModel.updateExpenseFormField(fieldName, newValue),
  //       decoration: InputDecoration(
  //         labelText: _capitalizeFieldName(fieldName),
  //         border: OutlineInputBorder(),
  //         filled: true,
  //         fillColor: Colors.grey[200],
  //       ),
  //     ),
  //   );
  // }
  //
  // // Builds a text field for the form.
  // Widget _buildTextField(String fieldName, ExpenseFormViewModel viewModel) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16.0),
  //     child: TextFormField(
  //       initialValue: viewModel.expenseFormData.toJson()[fieldName] as String?,
  //       onChanged: (newValue) =>
  //           viewModel.updateExpenseFormField(fieldName, newValue),
  //       decoration: InputDecoration(
  //         labelText: _capitalizeFieldName(fieldName),
  //         border: OutlineInputBorder(),
  //         filled: true,
  //         fillColor: Colors.grey[200],
  //       ),
  //     ),
  //   );
  // }

  // Capitalizes the first letter of each word in the field name.
  // String _capitalizeFieldName(String fieldName) {
  //   return fieldName.split('_').map((word) => word.capitalize()).join(' ');
  // }

  // Triggers form submission when user presses submit
  void onSubmitPressed(ExpenseFormViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      dev.log('Form validated in Expense Screen', name: 'ExpenseScreen');
      dev.log('Starting form submission process', name: 'ExpenseScreen');

      // Generate document number
      viewModel.expenseFormData.documentNo =
          DocumentNumberGenerator.generateDocumentNumber();
      dev.log('Generated documentNo: ${viewModel.expenseFormData.documentNo}',
          name: 'ExpenseScreen');

      try {
        dev.log('Upserting Expense form data', name: 'ExpenseScreen');
        bool success = await viewModel.processAndSubmitExpenseForm();

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Expense form submitted successfully')),
          );
          dev.log(
              'Upsert successful for documentNo: ${viewModel.expenseFormData.documentNo}',
              name: 'ExpenseScreen');

          // Optionally print the form data
          // await _printFormData(viewModel);

          resetForm(viewModel);

          dev.log(
              'Upsert successful for documentNo: ${viewModel.expenseFormData.documentNo}',
              name: 'ExpenseScreen');
          dev.log('Printing form data', name: 'ExpenseScreen');

          // Here you would add your printing logic
          // For example: await ExpensePrinter.printFormData(printData, 'Expense', viewModel.expenseFormData.documentNo, context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Error submitting form: ${viewModel.errorMessage}')),
          );
        }
      } catch (e) {
        dev.log('Error in onSubmitPressed: $e', name: 'ExpenseScreen');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form: $e')),
        );
      }
    }
  }

  Future<void> _printFormData(ExpenseFormViewModel viewModel) async {
    try {
      Map<String, String> printData = {
        'Document No': viewModel.expenseFormData.documentNo ?? '',
        'Date': viewModel.expenseFormData.date ?? '',
        'Name': viewModel.expenseFormData.name ?? '',
        'Transaction Type': viewModel.expenseFormData.transactionType ?? '',
        'Payment': viewModel.expenseFormData.payment ?? '',
        'Source Account': viewModel.expenseFormData.sourceAccount ?? '',
        'Description': viewModel.expenseFormData.description ?? '',
        'Business Head': viewModel.expenseFormData.businessHead ?? '',
        'Expense Head': viewModel.expenseFormData.expenseHead ?? '',
      };

      dev.log('Printing form data', name: 'ExpenseScreen');
      await ExpensePrinter.printFormData(
        printData,
        'Entry',
        viewModel.expenseFormData.documentNo ?? '',
        context,
      );
    } catch (e) {
      dev.log('Error printing form data: $e', name: 'ExpenseScreen');
      // Handle printing error (e.g., show a snackbar)
    }
  }

  // Clears the form after submission.
  void resetForm(ExpenseFormViewModel viewModel) {
    setState(() {
      expenseFormModel = ExpenseFormModel();
      viewModel.resetExpenseForm();
    });
    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed.
    super.dispose();
  }
}

extension StringExtension on String {
  // Capitalizes the first letter of the string.
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
