import 'dart:async';

import 'package:common/common_widgets.dart';

import '../../../core/util/date_time_utils.dart';
import '../../../core/util/form_fields.dart';
// import '../../../viewmodel/collection_viewmodel.dart';

class ExitTab extends StatefulWidget {
  const ExitTab({Key? key}) : super(key: key);

  @override
  _ExitTabState createState() => _ExitTabState();
}

class _ExitTabState extends State<ExitTab> {
  final _formKey = GlobalKey<FormState>();
  late CollectionViewModel _viewModel;

  // final TextEditingController _exitTimeController = TextEditingController();
  final TextEditingController _exitRemarksController = TextEditingController();

  bool _isQRScanned = false;
  late Timer _timer;
  String _currentFormattedTime = '';
  bool _isLoadingDone = false;

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
      final viewModel =
          Provider.of<CollectionViewModel>(context, listen: false);
      viewModel.addListener(_updateQRScanState);
    });
  }

  void _updateQRScanState() {
    final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
    setState(() {
      _isQRScanned = viewModel.isQRScanned;
    });
  }

  // void _updateUIWithFetchedData(CollectionFormModel fetchedData) {
  //   setState(() {
  //     if (fetchedData.exitTime != null) {
  //       // Parse the GraphQL format to DateTime, then format for display
  //       DateTime exitDateTime = DateTimeUtils.parseDateTime(
  //           fetchedData.exitTime!,
  //           format: DateTimeUtils.graphQLFormat);
  //       _exitTimeController.text = DateTimeUtils.formatForDisplay(exitDateTime);
  //     }
  //     _exitRemarksController.text = fetchedData.exitRemarks ?? '';
  //   });
  // }

  void _updateUIWithFetchedData(CollectionFormModel fetchedData) {
    setState(() {
      _exitRemarksController.text = fetchedData.exitRemarks ?? '';
      if (fetchedData.exitTime != null) {
        // Parse the GraphQL format to DateTime, then format for display
        DateTime exitDateTime = DateTimeUtils.parseDateTime(
            fetchedData.exitTime!,
            format: DateTimeUtils.graphQLFormat);
        _currentFormattedTime = DateTimeUtils.formatForDisplay(exitDateTime);
      } else {
        _updateFormattedTime(); //Set to current time if no data
      }
      // Check if loading data exists
      _isLoadingDone = fetchedData.loadingTime != null &&
          fetchedData.loadingRemarks != null &&
          fetchedData.loadingBy!.isNotEmpty;
      // fetchedData.payments!.isNotEmpty;
    });
  }

  void _updateFormattedTime() {
    setState(() {
      _currentFormattedTime = DateTimeUtils.formatForDisplay(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildQRScanner(viewModel),
                const SizedBox(height: 16.0),
                // _buildExitTimeField(viewModel),
                FormFields.buildTextCollectionField(
                  fieldName: 'Exit Time',
                  controller:
                      TextEditingController(text: _currentFormattedTime),
                  keyboardType: TextInputType.text,
                  readOnly: true,
                ),
                const SizedBox(height: 16.0),

                // _buildTextField(
                //   controller: _exitRemarksController,
                //   label: 'Exit Remarks',
                //   maxLines: 3,
                // ),
                FormFields.buildTextCollectionField(
                  fieldName: 'Exit Remarks',
                  controller: _exitRemarksController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),

                _buildLoadingStatusInfo(), // Display the "Loaded" status if applicable

                const SizedBox(height: 24.0),
                // ElevatedButton(
                //   onPressed: () => _submitForm(viewModel),
                //   child: const Text('Submit'),
                // ),
                CustomButtons.primaryButton(
                  label: 'Submit',
                  onPressed: () => _submitForm(viewModel),
                  color: Colors.green,
                  width: 150, // Specify a custom width
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

  Widget _buildLoadingStatusInfo() {
    if (!_isQRScanned || !_isLoadingDone) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green.shade700,
            size: 24,
          ),
          const SizedBox(width: 10),
          Text(
            "Loaded Successfully",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green.shade700,
            ),
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
            scanType: 'Exit',
            currentTab: 'Exit',
            onScan: (String sOrderId) async {
              await viewModel.fetchDataFromQR(sOrderId);
              _updateUIWithFetchedData(viewModel.collectionFormData);
            },
          ),
        ),
      ],
    );
  }

  // Widget _buildExitTimeField(CollectionViewModel viewModel) {
  //   return TextFormField(
  //     controller: _exitTimeController,
  //     decoration: const InputDecoration(
  //       labelText: 'Exit Time',
  //       border: OutlineInputBorder(),
  //     ),
  //     readOnly: true,
  //     onTap: () {
  //       // Display in UI format (yyyy:MM:dd hh:mm a)
  //       _exitTimeController.text =
  //           DateTimeUtils.formatForDisplay(DateTime.now());
  //     },
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please select Exit Time';
  //       }
  //       return null;
  //     },
  //   );
  // }
  // Widget _buildExitTimeField(CollectionViewModel viewModel) {
  //   return TextFormField(
  //     decoration: const InputDecoration(
  //       labelText: 'Exit Time',
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

      // Convert UI format to GraphQL format before updating
      String graphQLFormattedTime =
          // DateTimeUtils.formatForGraphQL(_exitTimeController.text);
          DateTimeUtils.formatForGraphQL(_currentFormattedTime);
      viewModel.updateExitTime(graphQLFormattedTime);

      viewModel.collectionFormData.exitRemarks = _exitRemarksController.text;

      // final loginViewModel =
      //     Provider.of<LoginViewModel>(context, listen: false);
      // final userId = loginViewModel.userIdData1.csUserId;

      try {
        bool result = await viewModel.upsertCollectionFormData(
          isExitScreen: true,
        );
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Exit data submitted successfully')),
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
    // _exitTimeController.clear();
    _exitRemarksController.clear();
    setState(() {
      _isQRScanned = false;
      _updateFormattedTime(); // Reset to current time if no data
    });
  }

  // @override
  // void dispose() {
  //   final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
  //   viewModel.removeListener(_updateQRScanState);
  //   _exitTimeController.dispose();
  //   _exitRemarksController.dispose();
  //   super.dispose();

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when disposing the widget

    // final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
    _viewModel.removeListener(_updateQRScanState);
    // _exitTimeController.dispose();
    _exitRemarksController.dispose();
    super.dispose();
  }
}
