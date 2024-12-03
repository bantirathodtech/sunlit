// filename: collection_viewmodel.dart
import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

import '../../core/util/date_time_utils.dart';
import '../widgets/bucket_calculator.dart';

class CollectionViewModel extends ChangeNotifier {
  // final ValueNotifier<CollectionFormModel> collectionFormDataNotifier =
  //     ValueNotifier(CollectionFormModel());

  /// Dependencies
  final CollectionRepository collectionRepository;
  final LoginViewModel loginViewModel;

  /// Model data
  CollectionFormModel collectionFormData = CollectionFormModel();
  Map<String, List<String>> dropdownOptions = {};
  List<Payment>? _payments;
  BucketCalculator? _bucketCalculator;

  /// State variables
  bool _isActive = true;
  bool _isLoading = false;
  bool _isQRScanned = false;
  bool _isUpsertingFromPaymentScreen = false;
  String _errorMessage = '';
  String _name = 'Unknown';
  String _userName = 'Unknown';
  String _userRole = '';
  String _currentTransactionDate = '';
  String? _temporarySOrderId;
  double? _bucketAmount;
  int? _buckets;

  /// Getters
  bool get isLoading => _isLoading;

  bool get isQRScanned => _isQRScanned;

  String get errorMessage => _errorMessage;

  String get name => _name;

  String get userName => _userName;

  String get userRole => _userRole;

  String get currentTransactionDate => _currentTransactionDate;

  List<Payment>? get payments => _payments;

  double? get bucketAmount => _bucketAmount;

  int? get buckets => _buckets;

  // Constructor
  CollectionViewModel({
    required this.collectionRepository,
    required this.loginViewModel,
  }) {
    _initializeUserData();
    loginViewModel.addListener(_updateUserData);
  }

  /// Initialization methods
  // These methods are called when the ViewModel is created

  // Initialize user data from loginViewModel
  void _initializeUserData() {
    _name = loginViewModel.userIdData1.name ?? 'Unknown';
    _userName = loginViewModel.userIdData1.username ?? 'Unknown';
    _userRole = loginViewModel.userIdData1.csRole ?? '';
    notifyListeners();
  }

// Update user data when loginViewModel changes
  void _updateUserData() {
    final newName = loginViewModel.userIdData1.name ?? 'Unknown';
    final newUserName = loginViewModel.userIdData1.username ?? 'Unknown';
    if (_name != newName || _userName != newUserName) {
      _name = newName;
      _userName = newUserName;
      notifyListeners();
    }
  }

  /// Fetching methods
  // These methods are typically called when the user interacts with the UI

  // Fetch bucket rate from the repository
  Future<void> fetchBucketRate(String csBunitId) async {
    dev.log('Fetching bucket rate for csBunitId: $csBunitId',
        name: 'CollectionViewModel');
    try {
      final data = await collectionRepository.getBucketRate(csBunitId);
      dev.log('Received bucket rate data: $data', name: 'CollectionViewModel');
      double rate = (data['rate'] as num).toDouble();
      int qty = data['qty'] as int;
      _bucketCalculator = BucketCalculator(ratePerBucket: rate, bucketQty: qty);
      dev.log('BucketCalculator created with rate: $rate, qty: $qty',
          name: 'CollectionViewModel');
      notifyListeners();
    } catch (e) {
      dev.log('Error fetching bucket rate: $e', name: 'CollectionViewModel');
      _bucketCalculator = BucketCalculator(ratePerBucket: 0.0, bucketQty: 0);
    }
  }

  // Fetch data from QR code
  Future<void> fetchDataFromQR(String sOrderId) async {
    try {
      _setLoading(true);
      dev.log('Fetching data for sOrderId: $sOrderId',
          name: 'CollectionViewModel');
      _temporarySOrderId = sOrderId;
      final fetchedData =
          await collectionRepository.getCollectionOrders(sOrderId);
      if (fetchedData != null) {
        collectionFormData = fetchedData;
        _isQRScanned = true;
        dev.log('Data fetched successfully for sOrderId: $sOrderId',
            name: 'CollectionViewModel');
        dev.log('Updated sOrderId: ${collectionFormData.sOrderId}',
            name: 'CollectionViewModel');
        collectionFormData.sOrderId = _temporarySOrderId;
        _temporarySOrderId = null;
        notifyListeners();
      } else {
        _errorMessage = 'No data found for the scanned QR code';
        dev.log('No data found for sOrderId: $sOrderId',
            name: 'CollectionViewModel');
      }
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
      dev.log('Error fetching data for sOrderId: $sOrderId. Error: $e',
          name: 'CollectionViewModel');
    } finally {
      _setLoading(false);
    }
  }

// Fetch dropdown options
  Future<void> fetchDropdownOptions() async {
    try {
      _setLoading(true);
      dropdownOptions = await collectionRepository.fetchDropdownOptions();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      dev.log('Error fetching dropdown options: $_errorMessage',
          name: 'CollectionViewModel');
    } finally {
      _setLoading(false);
    }
  }

  /// Update methods
  // These methods are called when the user interacts with the UI to update data

  // Update bucket amount based on selected buckets
  void updateBucketAmount(String selectedBuckets) {
    dev.log('Updating bucket amount for selectedBuckets: $selectedBuckets',
        name: 'CollectionViewModel');
    if (_bucketCalculator != null) {
      int buckets = int.tryParse(selectedBuckets) ?? 0;
      if (buckets > 0) {
        double bucketAmount = _bucketCalculator!.calculateBucketAmount(buckets);
        dev.log('Calculated bucket amount: $bucketAmount',
            name: 'CollectionViewModel');
        collectionFormData.bucketAmount = bucketAmount;
        collectionFormData.buckets = buckets;
        // Add this line to update the gross total
        _updateGrossTotal();
      } else {
        dev.log('Invalid bucket count, setting to null',
            name: 'CollectionViewModel');
        collectionFormData.bucketAmount = null;
        collectionFormData.buckets = null;
        // Also update gross total when setting to null
        _updateGrossTotal();
      }
      notifyListeners();
    } else {
      dev.log('Unable to update bucket amount. BucketCalculator is null',
          name: 'CollectionViewModel');
    }
  }

// Calculate total collection amount
//   void calculateTotalCollection() {
//     dev.log('Calculating total collection', name: 'CollectionViewModel');
//     double bucketAmount = collectionFormData.bucketAmount ?? 0.0;
//     double loadingCharges = collectionFormData.loadingCharges ?? 0.0;
//     double tonnageAmount = collectionFormData.tonnageAmount ?? 0.0;
//     double total = bucketAmount + loadingCharges + tonnageAmount;
//     dev.log('Bucket Amount: $bucketAmount', name: 'CollectionViewModel');
//     dev.log('Loading Charges: $loadingCharges', name: 'CollectionViewModel');
//     dev.log('Tonnage Amount: $tonnageAmount', name: 'CollectionViewModel');
//     dev.log('Calculated Total: $total', name: 'CollectionViewModel');
//     collectionFormData.grosstotal = total;
//     notifyListeners();
//   }
  ///
//   void calculateTotalCollection() {
//     dev.log('Calculating total collection', name: 'CollectionViewModel');
//
//     double total = 0.0;
//
//     // Add each amount to the total, treating null values as 0
//     total += collectionFormData.bucketAmount ?? 0.0;
//     total += collectionFormData.loadingCharges ?? 0.0;
//     total += collectionFormData.tonnageAmount ?? 0.0;
//
//     // Log individual amounts for debugging
//     dev.log('Bucket Amount: ${collectionFormData.bucketAmount}',
//         name: 'CollectionViewModel');
//     dev.log('Loading Charges: ${collectionFormData.loadingCharges}',
//         name: 'CollectionViewModel');
//     dev.log('Tonnage Amount: ${collectionFormData.tonnageAmount}',
//         name: 'CollectionViewModel');
//
//     // Update grosstotal even if only one field has a value
//     collectionFormData.grosstotal = total;
//     dev.log('Calculated Total: $total', name: 'CollectionViewModel');
//
//     notifyListeners();
//   }
  ///
  void calculateTotalCollection() {
    dev.log('Calculating total collection', name: 'CollectionViewModel');

    double total = (collectionFormData.bucketAmount ?? 0) +
        (collectionFormData.loadingCharges ?? 0) +
        (collectionFormData.tonnageAmount ?? 0);

    // Log individual amounts for debugging
    dev.log('Bucket Amount: ${collectionFormData.bucketAmount}',
        name: 'CollectionViewModel');
    dev.log('Loading Charges: ${collectionFormData.loadingCharges}',
        name: 'CollectionViewModel');
    dev.log('Tonnage Amount: ${collectionFormData.tonnageAmount}',
        name: 'CollectionViewModel');

    // Update grosstotal
    collectionFormData.grosstotal = total;
    dev.log('Calculated Total: $total', name: 'CollectionViewModel');

    notifyListeners();
  }

  /// Validation and submission
  // These methods are called when the form is being submitted

  // Validate form data
  String? validateFormData() {
    List<String> errors = [];

    if (collectionFormData.sOrderId == null ||
        collectionFormData.sOrderId!.isEmpty) {
      errors.add("Order ID is required");
    }
    if (collectionFormData.documentno == null ||
        collectionFormData.documentno!.isEmpty) {
      errors.add("Document number is required");
    }
    if (collectionFormData.dateordered != null &&
        !DateTimeUtils.isValidDateFormat(collectionFormData.dateordered!,
            format: DateTimeUtils.graphQLFormat)) {
      errors.add("Invalid Transaction Date format");
    }
    if (collectionFormData.saletypename == null ||
        collectionFormData.saletypename!.isEmpty) {
      errors.add("Type of Dispatch is required");
    }
    if (collectionFormData.vehicleNumber == null ||
        collectionFormData.vehicleNumber!.isEmpty) {
      errors.add("Vehicle Number is required");
    }
    if (collectionFormData.vehicleSize == null ||
        collectionFormData.vehicleSize!.isEmpty) {
      errors.add("Vehicle Size is required");
    }
    if (collectionFormData.driverName == null ||
        collectionFormData.driverName!.isEmpty) {
      errors.add("Driver Name is required");
    }

    if (collectionFormData.vehicleNumber != null &&
        collectionFormData.vehicleNumber!.length > 10) {
      errors.add("Vehicle Number must not exceed 10 characters");
    }
    if (collectionFormData.vehicleSize != null &&
        collectionFormData.vehicleSize!.length > 10) {
      errors.add("Vehicle Size must not exceed 10 characters");
    }
    if (collectionFormData.driverName != null &&
        collectionFormData.driverName!.isEmpty) {
      errors.add("Driver Name is required");
    }
    // Add this check for driver number (phone number)
    if (collectionFormData.driverNumber != null) {
      String driverNumberString = collectionFormData.driverNumber.toString();
      if (driverNumberString.length != 10) {
        errors.add("Driver Number must be exactly 10 digits");
      }
    }
    // if (collectionFormData.documentno != null &&
    //     collectionFormData.documentno!.length > 10) {
    //   errors.add("Document Number must not exceed 10 characters");
    // }

    if (collectionFormData.buckets != null && collectionFormData.buckets! < 0) {
      errors.add("Buckets must be a non-negative number");
    }
    if (collectionFormData.bucketAmount != null &&
        collectionFormData.bucketAmount! < 0) {
      errors.add("Bucket Amount must be a non-negative number");
    }
    if (collectionFormData.loadingCharges != null &&
        collectionFormData.loadingCharges! < 0) {
      errors.add("Loading Charges must be a non-negative number");
    }
    if (collectionFormData.tonnageAmount != null &&
        collectionFormData.tonnageAmount! < 0) {
      errors.add("Tonnage Amount must be a non-negative number");
    }
    if (collectionFormData.companyAmount != null &&
        collectionFormData.companyAmount! < 0) {
      errors.add("Company Amount must be a non-negative number");
    }
    if (collectionFormData.grosstotal != null &&
        collectionFormData.grosstotal! < 0) {
      errors.add("Gross Total must be a non-negative number");
    }
    if (collectionFormData.suspense != null &&
        collectionFormData.suspense! < 0) {
      errors.add("Suspense Amount must be a non-negative number");
    }

    if (collectionFormData.loadingTime != null &&
        !DateTimeUtils.isValidDateFormat(collectionFormData.loadingTime!,
            format: DateTimeUtils.graphQLFormat)) {
      errors.add("Invalid Loading Time format");
    }
    if (collectionFormData.exitTime != null &&
        !DateTimeUtils.isValidDateFormat(collectionFormData.exitTime!,
            format: DateTimeUtils.graphQLFormat)) {
      errors.add("Invalid Exit Time format");
    }

    return errors.isEmpty ? null : errors.join("\n");
  }

  // Check if a date string is in a valid format
  bool isValidDateFormat(String date,
      {String format = DateTimeUtils.graphQLFormat}) {
    try {
      DateTimeUtils.parseDateTime(date, format: format);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Upsert collection form data
  Future<bool> upsertCollectionFormData({
    bool isLoadingScreen = false,
    bool isExitScreen = false,
  }) async {
    print('CollectionViewModel: Starting upsertCollectionFormData');
    dev.log('Step 1: Starting upsertCollectionFormData',
        name: 'CollectionViewModel');
    print('Current payments: ${collectionFormData.payments}');

    String? validationErrors = validateFormData();
    if (validationErrors != null) {
      _errorMessage = validationErrors;
      notifyListeners();
      print('CollectionViewModel: Validation errors: $validationErrors');
      dev.log('Step 2: Validation errors: $validationErrors',
          name: 'CollectionViewModel');

      return false;
    }

    try {
      _setLoading(true);
      print(
          'ViewModel: Upserting data for sOrderId: ${collectionFormData.sOrderId}');
      dev.log(
          'Step 3: Upserting data for sOrderId: ${collectionFormData.sOrderId}',
          name: 'CollectionViewModel');

      _prepareFormData();
      print('Payments after preparation: ${collectionFormData.payments}');
      dev.log(
          'Step 4: Payments after preparation: ${collectionFormData.payments}',
          name: 'CollectionViewModel');

      if (isExitScreen) {
        _prepareExitScreenData();
      }
      if (isLoadingScreen) {
        _prepareLoadingScreenData();
      }

      // Filter out empty payment entries
      print(
          'CollectionViewModel: Payments before filtering: ${collectionFormData.payments}');
      dev.log(
          'Step 5: Payments before filtering: ${collectionFormData.payments}',
          name: 'CollectionViewModel');
      collectionFormData.payments = collectionFormData.payments
          ?.where((payment) =>
              payment.paymentMethod != null &&
              payment.paymentMethod!.isNotEmpty &&
              payment.amount != null &&
              payment.amount! > 0)
          .toList();
      print(
          'CollectionViewModel: Filtered payments: ${collectionFormData.payments}');
      dev.log('Step 6: Filtered payments: ${collectionFormData.payments}',
          name: 'CollectionViewModel');

      // Only include payments if upserting from payment screen
      if (_isUpsertingFromPaymentScreen) {
        print(
            'CollectionViewModel: Upserting from payment screen, using latest payments data');
        dev.log(
            'Step 7: Upserting from payment screen, using latest payments data',
            name: 'CollectionViewModel');
        if (_payments != null) {
          collectionFormData.payments = _payments;
          dev.log(
              'Step 8: Updated payments from _payments: ${collectionFormData.payments}',
              name: 'CollectionViewModel');
          print(
              'CollectionViewModel: Updated payments from _payments: ${collectionFormData.payments}');
        }
      } else {
        print(
            'CollectionViewModel: Not upserting from payment screen, payments will be null');
        dev.log(
            'Step 7: Not upserting from payment screen, payments will remain as is',
            name: 'CollectionViewModel');
        collectionFormData.payments = null;
      }

      final userData = loginViewModel.userIdData1.toJson() ?? {};
      dev.log('Step 9: User data for upsert: $userData',
          name: 'CollectionViewModel');
      print('CollectionViewModel: User data for upsert: $userData');
      // final result = await collectionService.upsertCollectionForm(
      //     collectionFormData, userData, getUserBunitId(), getUserId());

      print(
          'CollectionViewModel: Final form data being sent: ${collectionFormData.toJson()}');
      dev.log(
          'Step 10: Final form data being sent: ${collectionFormData.toJson()}',
          name: 'CollectionViewModel');
      final result = await collectionRepository.upsertCollectionForm(
          collectionFormData, userData, getUserBunitId(), getUserId());

      print(
          'CollectionViewModel: Upsert result: ${result.data.upsertCollectionOrders}');
      dev.log('Step 11: Upsert result: ${result.data.upsertCollectionOrders}',
          name: 'CollectionViewModel');
      if (result.data.upsertCollectionOrders.code == "200" ||
          result.data.upsertCollectionOrders.code == "201") {
        print(
            'ViewModel: Upsert successful for sOrderId: ${collectionFormData.sOrderId}');
        dev.log(
            'Step 12: Upsert successful for sOrderId: ${collectionFormData.sOrderId}',
            name: 'CollectionViewModel');
        resetForm(); // Reset the form after successful upsert
        return true;
      } else {
        _errorMessage = result.data.upsertCollectionOrders.message;
        print(
            'ViewModel: Upsert failed for sOrderId: ${collectionFormData.sOrderId}. Error: $_errorMessage');
        dev.log(
            'Step 12: Upsert failed for sOrderId: ${collectionFormData.sOrderId}. Error: $_errorMessage',
            name: 'CollectionViewModel');
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      dev.log('Step 12: Exception in upsertCollectionFormData: $e',
          name: 'CollectionViewModel');
      print('ViewModel: Exception in upsertCollectionFormData: $e');
      return false;
    } finally {
      _setLoading(false);
      // Reset the flag after upserting
      _isUpsertingFromPaymentScreen = false;
    }
  }

  /// Helper methods
  // These are utility methods used internally by the ViewModel

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // void updateTransactionDate(DateTime date) {
  //   if (!hasListeners) return; // Add this check
  //   _currentTransactionDate = DateTimeUtils.formatForDisplay(date);
  //   collectionFormData.dateordered =
  //       DateTimeUtils.formatForGraphQL(_currentTransactionDate);
  //   notifyListeners();
  // }

  // Update transaction date
  void updateTransactionDate(DateTime date) {
    if (!_isActive) return;
    _currentTransactionDate = DateTimeUtils.formatForDisplay(date);
    collectionFormData.dateordered =
        DateTimeUtils.formatForGraphQL(_currentTransactionDate);
    notifyListeners();
  }

// Update loading time
  void updateLoadingTime(String formattedTime) {
    try {
      collectionFormData.loadingTime = formattedTime;
      notifyListeners();
    } catch (e, stackTrace) {
      dev.log('Error updating loading time: $e', name: 'CollectionViewModel');
      dev.log('Stack trace: $stackTrace', name: 'CollectionViewModel');
    }
  }

// Update exit time
  void updateExitTime(String formattedTime) {
    try {
      collectionFormData.exitTime = formattedTime;
      notifyListeners();
    } catch (e, stackTrace) {
      dev.log('Error updating exit time: $e', name: 'CollectionViewModel');
      dev.log('Stack trace: $stackTrace', name: 'CollectionViewModel');
    }
  }

  // Prepare form data for submission
  void _prepareFormData() {
    dev.log('Preparing form data', name: 'CollectionViewModel');

    // collectionFormData.exitBy = getUserId(); // Set exitBy to current user ID
    // collectionFormData.isExit = "Y";

    collectionFormData.bunitname = name;

    if (_currentTransactionDate.isNotEmpty) {
      collectionFormData.dateordered =
          DateTimeUtils.formatForGraphQL(_currentTransactionDate);
    }
    if (collectionFormData.loadingTime != null) {
      collectionFormData.loadingTime =
          collectionFormData.loadingTime!; // It's already in GraphQL format
    }
    if (collectionFormData.exitTime != null) {
      collectionFormData.exitTime =
          collectionFormData.exitTime!; // It's already in GraphQL format
    }
    if (_payments != null && _payments!.isNotEmpty) {
      collectionFormData.payments = _payments;
      print('Prepared payments: ${collectionFormData.payments}');
    } else {
      collectionFormData.payments = null;
      print('No payments to prepare');
    }
    dev.log('Prepared form data: ${collectionFormData.toJson()}',
        name: 'CollectionViewModel');
  }

  // Update a specific form field
  // void updateFormField(String field, dynamic value) {
  //   switch (field) {
  //     case 'sOrderId':
  //       collectionFormData.sOrderId = value ?? null;
  //       break;
  //     case 'documentno':
  //       collectionFormData.documentno = value ?? null;
  //       break;
  //     case 'dateordered':
  //       if (value is DateTime) {
  //         collectionFormData.dateordered = DateTimeUtils.formatForGraphQL(
  //             DateTimeUtils.formatForDisplay(value));
  //       } else if (value is String) {
  //         collectionFormData.dateordered =
  //             DateTimeUtils.formatForGraphQL(value);
  //       }
  //       break;
  //     case 'saletypename':
  //       collectionFormData.saletypename = value ?? null;
  //       break;
  //     case 'vehicleNumber':
  //       collectionFormData.vehicleNumber = value ?? null;
  //       break;
  //     case 'vehicleSize':
  //       collectionFormData.vehicleSize = value ?? null;
  //       break;
  //     case 'driverName':
  //       collectionFormData.driverName = value ?? null;
  //       break;
  //     // case 'driverNumber':
  //     //   collectionFormData.driverNumber = value ?? null;
  //     //   break;
  //     case 'driverNumber':
  //       collectionFormData.driverNumber =
  //           value is String ? int.tryParse(value) : value as int?;
  //       break;
  //     // case 'buckets':
  //     //   collectionFormData.buckets =
  //     //       value != null ? int.tryParse(value.toString()) : null;
  //     //   break;
  //     case 'buckets':
  //       collectionFormData.buckets = value as int?;
  //       break;
  //     // case 'bucket_amount':
  //     //   collectionFormData.bucketAmount =
  //     //       value != null ? double.tryParse(value.toString()) : null;
  //     //   break;
  //     case 'bucketAmount':
  //       // collectionFormData.bucketAmount = value as double?;
  //       collectionFormData.bucketAmount =
  //           value is int ? value.toDouble() : value as double?;
  //       print(
  //           'CollectionViewModel: Updated bucketAmount to ${collectionFormData.bucketAmount}');
  //       calculateTotalCollection();
  //       break;
  //     // case 'loading_charges':
  //     //   collectionFormData.loadingCharges =
  //     //       value != null ? double.tryParse(value.toString()) : null;
  //     //   break;
  //     case 'loadingCharges':
  //       // collectionFormData.loadingCharges = value as double?;
  //       collectionFormData.loadingCharges =
  //           value is int ? value.toDouble() : value as double?;
  //
  //       print(
  //           'CollectionViewModel: Updated loadingCharges to ${collectionFormData.loadingCharges}');
  //       calculateTotalCollection();
  //       break;
  //     // case 'tonnage_amount':
  //     //   collectionFormData.tonnageAmount =
  //     //       value != null ? double.tryParse(value.toString()) : null;
  //     //   break;
  //     case 'tonnageAmount':
  //       // collectionFormData.tonnageAmount = value as double?;
  //       collectionFormData.tonnageAmount =
  //           value is int ? value.toDouble() : value as double?;
  //
  //       print(
  //           'CollectionViewModel: Updated tonnageAmount to ${collectionFormData.tonnageAmount}');
  //       calculateTotalCollection();
  //       break;
  //     // case 'company_amount':
  //     //   collectionFormData.companyAmount =
  //     //       value != null ? double.tryParse(value.toString()) : null;
  //     //   break;
  //     case 'companyAmount':
  //       collectionFormData.companyAmount = value as double?;
  //       break;
  //     // case 'grosstotal':
  //     //   collectionFormData.grosstotal =
  //     //       value != null ? double.tryParse(value.toString()) : null;
  //     //   break;
  //     case 'grosstotal':
  //       collectionFormData.grosstotal = value as double?;
  //       break;
  //     case 'b2ccustomername':
  //       collectionFormData.b2ccustomername = value ?? null;
  //       break;
  //     // case 'suspense':
  //     //   collectionFormData.suspense =
  //     //       value != null ? double.tryParse(value.toString()) : null;
  //     //   break;
  //     // case 'suspense':
  //     //   collectionFormData.suspense = value as double?;
  //     //   break;
  //     case 'suspense':
  //       collectionFormData.suspense =
  //           value is String ? double.tryParse(value) : value as double?;
  //       break;
  //     case 'description':
  //       collectionFormData.description = value ?? null;
  //       break;
  //     case 'payments':
  //       collectionFormData.payments = value ?? null;
  //       break;
  //     case 'loading_time':
  //       if (value is DateTime) {
  //         collectionFormData.loadingTime = DateTimeUtils.formatForGraphQL(
  //             DateTimeUtils.formatForDisplay(value));
  //       } else if (value is String) {
  //         collectionFormData.loadingTime =
  //             DateTimeUtils.formatForGraphQL(value);
  //       }
  //       break;
  //     case 'loading_remarks':
  //       collectionFormData.loadingRemarks = value ?? null;
  //       break;
  //     case 'exit_time':
  //       if (value is DateTime) {
  //         collectionFormData.exitTime = DateTimeUtils.formatForGraphQL(
  //             DateTimeUtils.formatForDisplay(value));
  //       } else if (value is String) {
  //         collectionFormData.exitTime = DateTimeUtils.formatForGraphQL(value);
  //       }
  //       break;
  //     case 'exit_remarks':
  //       collectionFormData.exitRemarks = value ?? null;
  //       break;
  //     case 'is_exit':
  //       collectionFormData.isExit = value ?? null;
  //       break;
  //     case 'is_suspense':
  //       collectionFormData.isSuspense = value ?? null;
  //       break;
  //     case 'is_shipment':
  //       collectionFormData.isShipment = value ?? null;
  //       break;
  //     case 'exit_by':
  //       collectionFormData.exitBy = value ?? null;
  //       break;
  //     case 'loading_by':
  //       collectionFormData.loadingBy = value ?? null;
  //       break;
  //     default:
  //       print('Unknown field: $field');
  //   }
  //   notifyListeners();
  // }
  void updateFormField(String field, dynamic value) {
    switch (field) {
      case 'sOrderId':
      case 'documentno':
      case 'saletypename':
      case 'vehicleNumber':
      case 'vehicleSize':
      case 'driverName':
      case 'b2ccustomername':
      case 'description':
      case 'loadingRemarks':
      case 'exitRemarks':
      case 'isExit':
      case 'isSuspense':
      case 'isShipment':
      case 'exitBy':
      case 'loadingBy':
        _updateStringField(field, value);
        break;

      case 'dateordered':
      case 'loadingTime':
      case 'exitTime':
        _updateDateTimeField(field, value);
        break;

      case 'driverNumber':
      case 'buckets':
        _updateIntField(field, value);
        break;

      case 'bucketAmount':
      case 'loadingCharges':
      case 'tonnageAmount':
      case 'companyAmount':
      case 'grosstotal':
      case 'suspense':
        _updateDoubleField(field, value);
        break;

      case 'payments':
        collectionFormData.payments = value as List<Payment>?;
        break;

      default:
        print('Unknown field: $field');
    }
    notifyListeners();
  }

  void _updateStringField(String field, dynamic value) {
    final stringValue = value?.toString();
    switch (field) {
      case 'sOrderId':
        collectionFormData.sOrderId = stringValue;
        break;
      case 'documentno':
        collectionFormData.documentno = stringValue;
        break;
      case 'saletypename':
        collectionFormData.saletypename = stringValue;
        break;
      case 'vehicleNumber':
        collectionFormData.vehicleNumber = stringValue;
        break;
      case 'vehicleSize':
        collectionFormData.vehicleSize = stringValue;
        break;
      case 'driverName':
        collectionFormData.driverName = stringValue;
        break;
      case 'b2ccustomername':
        collectionFormData.b2ccustomername = stringValue;
        break;
      case 'description':
        collectionFormData.description = stringValue;
        break;
      case 'loadingRemarks':
        collectionFormData.loadingRemarks = stringValue;
        break;
      case 'exitRemarks':
        collectionFormData.exitRemarks = stringValue;
        break;
      case 'isExit':
        collectionFormData.isExit = stringValue;
        break;
      case 'isSuspense':
        collectionFormData.isSuspense = stringValue;
        break;
      case 'isShipment':
        collectionFormData.isShipment = stringValue;
        break;
      case 'exitBy':
        collectionFormData.exitBy = stringValue;
        break;
      case 'loadingBy':
        collectionFormData.loadingBy = stringValue;
        break;
    }
  }

  void _updateDateTimeField(String field, dynamic value) {
    String? formattedDate;
    if (value is DateTime) {
      formattedDate =
          DateTimeUtils.formatForGraphQL(DateTimeUtils.formatForDisplay(value));
    } else if (value is String) {
      formattedDate = DateTimeUtils.formatForGraphQL(value);
    }

    switch (field) {
      case 'dateordered':
        collectionFormData.dateordered = formattedDate;
        break;
      case 'loadingTime':
        collectionFormData.loadingTime = formattedDate;
        break;
      case 'exitTime':
        collectionFormData.exitTime = formattedDate;
        break;
    }
  }

  void _updateIntField(String field, dynamic value) {
    int? intValue = value is String ? int.tryParse(value) : value as int?;
    switch (field) {
      case 'driverNumber':
        collectionFormData.driverNumber = intValue;
        break;
      case 'buckets':
        collectionFormData.buckets = intValue;
        break;
    }
  }

  void _updateDoubleField(String field, dynamic value) {
    double? doubleValue = parseDoubleValue(value);
    bool valueChanged = false;

    switch (field) {
      case 'bucketAmount':
        if (collectionFormData.bucketAmount != doubleValue) {
          collectionFormData.bucketAmount = doubleValue;
          valueChanged = true;
        }
        break;
      case 'loadingCharges':
        if (collectionFormData.loadingCharges != doubleValue) {
          collectionFormData.loadingCharges = doubleValue;
          valueChanged = true;
        }
        break;
      case 'tonnageAmount':
        if (collectionFormData.tonnageAmount != doubleValue) {
          collectionFormData.tonnageAmount = doubleValue;
          valueChanged = true;
        }
        break;
      case 'companyAmount':
        if (collectionFormData.companyAmount != doubleValue) {
          collectionFormData.companyAmount = doubleValue;
          valueChanged = true;
        }
        break;
      case 'grosstotal':
        if (collectionFormData.grosstotal != doubleValue) {
          collectionFormData.grosstotal = doubleValue;
          valueChanged = true;
        }
        break;
      case 'suspense':
        if (collectionFormData.suspense != doubleValue) {
          collectionFormData.suspense = doubleValue;
          valueChanged = true;
        }
        break;
    }

    if (valueChanged) {
      _updateGrossTotal();
    }

    print('CollectionViewModel: Updated $field to $doubleValue');
  }

  void _updateGrossTotal() {
    double total = (collectionFormData.bucketAmount ?? 0) +
        (collectionFormData.loadingCharges ?? 0) +
        (collectionFormData.tonnageAmount ?? 0);
    if (collectionFormData.grosstotal != total) {
      collectionFormData.grosstotal = total;
      print('CollectionViewModel: Updated grosstotal to $total');
      notifyListeners();
    }
  }

  double? parseDoubleValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        print('Error parsing string to double: $e');
        return null;
      }
    }
    return null;
  }

  // Prepare data specific to loading screen
  void _prepareLoadingScreenData() {
    collectionFormData.isShipment = "Y";
    collectionFormData.loadingBy = getUserId();
  }

  // Prepare data specific to exit screen
  void _prepareExitScreenData() {
    collectionFormData.isExit = "Y";
    collectionFormData.exitBy = getUserId();
  }

  /// Utility methods
  // These methods provide utility functions used throughout the ViewModel

  // Get user's business unit ID
  String getUserBunitId() => loginViewModel.userIdData1.defaultCsBunitId ?? '';

  // Get user ID
  String getUserId() => loginViewModel.userIdData1.csUserId ?? '';

  /// State management
  // These methods manage the overall state of the ViewModel

  // Deactivate the ViewModel
  void deactivate() {
    _isActive = false;
  }

  // Reset the form to its initial state
  void resetForm() {
    collectionFormData = CollectionFormModel();
    _isQRScanned = false;
    _payments = [
      Payment(
          paymentMethod: '',
          type: '',
          amount: null,
          remarks: '',
          cs_bunit_id: getUserBunitId())
    ];
    notifyListeners();
  }

  // Set flag for upserting from payment screen
  void setUpsertingFromPaymentScreen(bool value) {
    _isUpsertingFromPaymentScreen = value;
  }

  /// Setters
  // These setters allow controlled modification of specific properties

  set payments(List<Payment>? value) {
    print('CollectionViewModel: Setting payments: $value');
    _payments = value;
    notifyListeners();
  }

  set bucketAmount(double? value) {
    _bucketAmount = value;
    notifyListeners();
  }

  set buckets(int? value) {
    _buckets = value;
    notifyListeners();
  }

  /// Lifecycle
  // This method is called when the ViewModel is no longer needed

  @override
  void dispose() {
    loginViewModel.removeListener(_updateUserData);
    super.dispose();
  }
}
