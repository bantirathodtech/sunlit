import 'dart:async';

import 'package:common/common_widgets.dart';

import '../../../core/util/date_time_utils.dart';
import '../../../core/util/form_fields.dart';
// import '../../../viewmodel/collection_viewmodel.dart';

class LoadingTab extends StatefulWidget {
  const LoadingTab({super.key});

  @override
  _LoadingTabState createState() => _LoadingTabState();
}

class _LoadingTabState extends State<LoadingTab> {
  final _formKey = GlobalKey<FormState>();
  late CollectionViewModel _viewModel;
  CollectionFormModel? _entryData;
  CollectionFormModel? _paymentData;
  bool _isPaymentDone = false;

  // final TextEditingController _loadingTimeController = TextEditingController();
  final TextEditingController _loadingRemarksController =
      TextEditingController();

  bool _isQRScanned = false;

  // DateTime _currentTime = DateTime.now();
  late Timer _timer;
  String _currentFormattedTime = '';

  @override
  void initState() {
    super.initState();
    _isQRScanned = false;

    // Initialize the formatted time
    _updateFormattedTime();

    // Start a timer to update the formatted time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _updateFormattedTime();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = Provider.of<CollectionViewModel>(context, listen: false);
      _viewModel.addListener(_updateQRScanState);
    });
  }

  void _updateQRScanState() {
    if (mounted) {
      setState(() {
        _isQRScanned = _viewModel.isQRScanned;
      });
    }
  }

  // void _updateUIWithFetchedData(CollectionFormModel fetchedData) {
  //   setState(() {
  //     _loadingRemarksController.text = fetchedData.loadingRemarks ?? '';
  //     if (fetchedData.loadingTime != null) {
  //       // Parse the GraphQL format to DateTime, then format for display
  //       DateTime loadingDateTime = DateTimeUtils.parseDateTime(
  //           fetchedData.loadingTime!,
  //           format: DateTimeUtils.graphQLFormat);
  //       _loadingTimeController.text =
  //           DateTimeUtils.formatForDisplay(loadingDateTime);
  //     }
  //   });
  // }

  void _updateFormattedTime() {
    setState(() {
      _currentFormattedTime = DateTimeUtils.formatForDisplay(DateTime.now());
    });
  }

  void _updateUIWithFetchedData(CollectionFormModel fetchedData) {
    setState(() {
      _loadingRemarksController.text = fetchedData.loadingRemarks ?? '';
      if (fetchedData.loadingTime != null) {
        // Parse the GraphQL format to DateTime, then format for display
        DateTime loadingDateTime = DateTimeUtils.parseDateTime(
            fetchedData.loadingTime!,
            format: DateTimeUtils.graphQLFormat);
        _currentFormattedTime = DateTimeUtils.formatForDisplay(loadingDateTime);
      } else {
        _updateFormattedTime(); // Set to current time if no data
      }
      // Store the fetched entry data
      _entryData = fetchedData;
      // Store the fetched payment data
      _paymentData = fetchedData;

      // Check if payment data exists
      _isPaymentDone = fetchedData.grosstotal != null &&
          fetchedData.payments != null &&
          fetchedData.payments!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.mediumPadding),
          // padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildQRScanner(viewModel),
                // const SizedBox(height: 16.0),
                const SizedBox(height: AppDimensions.smallPadding),
                // _buildLoadingTimeField(viewModel),
                FormFields.buildTextCollectionField(
                  fieldName: 'Loading Time',
                  controller:
                      TextEditingController(text: _currentFormattedTime),
                  keyboardType: TextInputType.text,
                  readOnly: true,
                ),
                // const SizedBox(height: 16.0),
                const SizedBox(height: AppDimensions.smallPadding),

                // _buildTextField(
                //   controller: _loadingRemarksController,
                //   label: 'Loading Remarks',
                //   maxLines: 3,
                // ),
                FormFields.buildTextCollectionField(
                  fieldName: 'Loading Remarks',
                  controller: _loadingRemarksController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                ),
                if (_isQRScanned && _entryData != null)
                  _buildEntryDetailsCard(),
                // const SizedBox(height: 8.0),
                const SizedBox(height: AppDimensions.smallPadding),

                _buildPaymentDetailsCard(),
                const SizedBox(height: AppDimensions.smallPadding),

                // const SizedBox(height: 24.0),
                // ElevatedButton(
                //   onPressed: () => _submitForm(viewModel),
                //   child: const Text('Submit'),
                // ),
                CustomButtons.primaryButton(
                  label: 'Submit',
                  onPressed: () => _submitForm(viewModel),
                  color: Colors.green,
                  width: 150,
                  // Specify a custom width
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEntryDetailsCard() {
    if (_entryData == null) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.smallPadding),

      // margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        // padding: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(AppDimensions.mediumPadding),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Entry Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 16),
            const SizedBox(height: AppDimensions.mediumPadding),

            _buildDetailRow('Reach Name', _entryData!.bunitname),
            _buildDetailRow('Type of Dispatch', _entryData!.saletypename),
            _buildDetailRow('Vehicle Number', _entryData!.vehicleNumber),
            _buildDetailRow('Vehicle Size', _entryData!.vehicleSize),
            _buildDetailRow('Driver Name', _entryData!.driverName),
            _buildDetailRow(
                'Driver Number', _entryData!.driverNumber?.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    if (_paymentData == null) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
          vertical: AppDimensions.smallPadding,
          horizontal: AppDimensions.smallPadding),
      // margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        // padding: const EdgeInsets.all(8),
        padding: AppDimensions.smallPaddingAll,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Payment Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildPaymentStatusInfo(),
              ],
            ),
            // const Divider(height: 16, thickness: 1.2),
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildDetailRow(
            //           'Total Collection', _paymentData!.grosstotal?.toString()),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // Additional details can be added here.
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStatusInfo() {
    if (!_isQRScanned) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: _isPaymentDone ? Colors.green.shade100 : Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isPaymentDone ? Icons.check_circle : Icons.warning,
            color:
                _isPaymentDone ? Colors.green.shade700 : Colors.orange.shade700,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            _isPaymentDone ? "Payment Paid" : "Payment Pending",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isPaymentDone
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }

  Widget _buildQRScanner(CollectionViewModel viewModel) {
    return Row(
      children: [
        if (_isQRScanned)
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.check_circle, color: Colors.green, size: 24),
          ),
        Expanded(
          child: QRScannerWidget(
            scanType: 'Loading',
            currentTab: 'Loading',
            onScan: (String sOrderId) async {
              await _viewModel.fetchDataFromQR(sOrderId);
              _updateUIWithFetchedData(_viewModel.collectionFormData);
            },
          ),
        ),
      ],
    );
  }

  // Widget _buildLoadingTimeField(CollectionViewModel viewModel) {
  //   return TextFormField(
  //     controller: _loadingTimeController,
  //     decoration: const InputDecoration(
  //       labelText: 'Loading Time',
  //       border: OutlineInputBorder(),
  //     ),
  //     readOnly: true,
  //     onTap: () {
  //       // Display in UI format (yyyy:MM:dd hh:mm a)
  //       _loadingTimeController.text =
  //           DateTimeUtils.formatForDisplay(DateTime.now());
  //     },
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please select Loading Time';
  //       }
  //       return null;
  //     },
  //   );
  // }

  // Widget _buildLoadingTimeField(CollectionViewModel viewModel) {
  //   return TextFormField(
  //     decoration: const InputDecoration(
  //       labelText: 'Loading Time',
  //       border: OutlineInputBorder(),
  //     ),
  //     readOnly: true,
  //     controller: TextEditingController(text: _currentFormattedTime),
  //   );
  // }
  //
  // Widget _buildTextField({
  //   required TextEditingController controller,
  //   required String label,
  //   int maxLines = 1,
  // }) {
  //   return TextFormField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //       labelText: label,
  //       border: const OutlineInputBorder(),
  //     ),
  //     maxLines: maxLines,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter $label';
  //       }
  //       return null;
  //     },
  //   );
  // }

  void _submitForm(CollectionViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      if (viewModel.collectionFormData.sOrderId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please scan a valid QR code first')),
        );
        return;
      }

      // // Convert UI format to GraphQL format before updating
      // String graphQLFormattedTime =
      //     DateTimeUtils.formatForGraphQL(_loadingTimeController.text);
      // viewModel.updateLoadingTime(graphQLFormattedTime);

      // Convert UI format to GraphQL format before updating
      // Use the current time when submitting
      // Use formatForGraphQL with the current formatted time
      String graphQLFormattedTime =
          DateTimeUtils.formatForGraphQL(_currentFormattedTime);
      viewModel.updateLoadingTime(graphQLFormattedTime);

      viewModel.collectionFormData.loadingRemarks =
          _loadingRemarksController.text;

      // final loginViewModel =
      //     Provider.of<LoginViewModel>(context, listen: false);
      // final userId = loginViewModel.userIdData1.csUserId;

      try {
        bool result = await viewModel.upsertCollectionFormData(
          isLoadingScreen: true,
        );
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Loading data submitted successfully')),
          );
          _clearForm();
          viewModel.resetForm();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Error submitting form: ${viewModel.errorMessage}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form: $e')),
        );
      }
    }
  }

  void _clearForm() {
    // _loadingTimeController.clear();
    _loadingRemarksController.clear();
    setState(() {
      _isQRScanned = false;
      _updateFormattedTime(); // Reset to current time
      _entryData = null;
      _paymentData = null;
      _isPaymentDone = false; // Reset payment status
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when disposing the widget

    _viewModel.removeListener(_updateQRScanState);
    // _loadingTimeController.dispose();
    _loadingRemarksController.dispose();
    super.dispose();
  }
}
