import 'dart:async';
import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../core/util/date_time_utils.dart';
import '../../../core/util/form_fields.dart';

class EntryTab extends StatefulWidget {
  const EntryTab({Key? key}) : super(key: key);

  @override
  _EntryTabState createState() => _EntryTabState();
}

class _EntryTabState extends State<EntryTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reachNameController = TextEditingController();
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _driverNumberController = TextEditingController();
  String? _selectedTypeOfDispatch;
  String? _selectedVehicleSize;

  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";

  String sOrderId = "";

  final List<String> vehicleSizes = ['10 Tyre', '12 Tyre', '16 Tyre'];

  @override
  void initState() {
    super.initState();
    _bindingPrinter();
    _clearForm();
    resetForm();
    // viewModel.resetForm();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFormData();
    });
  }

  void resetForm() {
    final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
    viewModel.resetForm();
  }

  void _initializeFormData() {
    final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
    final formData = viewModel.collectionFormData;
    _reachNameController.text = formData.bunitname ?? '';
    _vehicleNumberController.text = formData.vehicleNumber ?? '';
    _driverNameController.text = formData.driverName ?? '';
    _driverNumberController.text = '';
    setState(() {
      _selectedTypeOfDispatch = formData.saletypename;
      _selectedVehicleSize = formData.vehicleSize;
    });
  }

  Future<void> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    if (result != null) {
      setState(() {
        printBinded = result;
      });
    }
    paperSize = await SunmiPrinter.paperSize() ?? 0;
    printerVersion = await SunmiPrinter.printerVersion() ?? "";
    serialNumber = await SunmiPrinter.serialNumber() ?? "";
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
                FormFields.buildDropdownField(
                  fieldName: 'Type of Dispatch',
                  value: _selectedTypeOfDispatch,
                  options: viewModel.dropdownOptions['typeOfDispatch'] ?? [],
                  onChanged: (value) =>
                      setState(() => _selectedTypeOfDispatch = value),
                ),
                const SizedBox(height: 8.0),
                FormFields.buildTextCollectionField(
                  fieldName: 'Vehicle Number',
                  controller: _vehicleNumberController,

                  // initialValue: _vehicleNumberController.text,
                  // onChanged: (value) => _vehicleNumberController.text = value,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    uppercaseAlphaNumericFormatter,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 8.0),
                FormFields.buildDropdownField(
                  fieldName: 'Vehicle Size',
                  value: _selectedVehicleSize,
                  options: vehicleSizes,
                  onChanged: (value) =>
                      setState(() => _selectedVehicleSize = value),
                ),
                const SizedBox(height: 8.0),
                FormFields.buildTextCollectionField(
                  fieldName: 'Driver Name',
                  controller: _driverNameController,

                  // initialValue: _driverNameController.text,
                  // onChanged: (value) => _driverNameController.text = value,
                  inputFormatters: [
                    customFormatter,
                  ],
                  // No length restriction for driver name
                ),
                const SizedBox(height: 8.0),
                FormFields.buildTextCollectionField(
                  fieldName: 'Driver Number',
                  controller: _driverNumberController,

                  // initialValue: _driverNumberController.text,
                  // onChanged: (value) => _driverNumberController.text = value,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Driver Number';
                    } else if (value.length != 10) {
                      return 'Driver Number must be exactly 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
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

  void _submitForm(CollectionViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      dev.log('Form validated in EntryTab', name: 'EntryTab');

      final now = DateTime.now();
      String formattedDateTime = DateTimeUtils.formatForDisplay(now);
      viewModel.updateTransactionDate(now);
      dev.log('Transaction date updated: $formattedDateTime', name: 'EntryTab');

      // viewModel.collectionFormData.sOrderId = CollectionUtils.generateSOrderId();
      sOrderId = CommonWidgets.generateSOrderId();
      viewModel.collectionFormData.sOrderId = sOrderId;
      print('EntryTab: Generated sOrderId: $sOrderId');

      dev.log('Generated sOrderId: ${viewModel.collectionFormData.sOrderId}',
          name: 'EntryTab');

      viewModel.collectionFormData.documentno =
          // CollectionUtils.generateOrderNumber(); //random
          DocumentNumberGenerator.generateDocumentNumber(); //sequence
      dev.log(
          'Generated documentno: ${viewModel.collectionFormData.documentno}',
          name: 'EntryTab');

      viewModel.collectionFormData.bunitname = viewModel.name;
      viewModel.updateFormField('dateordered', formattedDateTime);
      viewModel.updateFormField('vehicleNumber', _vehicleNumberController.text);
      viewModel.updateFormField('vehicleSize', _selectedVehicleSize ?? '');
      viewModel.updateFormField('driverName', _driverNameController.text);
      // viewModel.updateFormField('driverNumber', _driverNumberController.text);
      viewModel.updateFormField(
          'driverNumber', int.tryParse(_driverNumberController.text));

      viewModel.updateFormField('saletypename', _selectedTypeOfDispatch);

      try {
        // Prepare print data
        Map<String, String> printData = {
          'Reach Name': viewModel.name,
          'Transaction Date': formattedDateTime,
          'Type of Dispatch': _selectedTypeOfDispatch ?? '',
          'Vehicle Number': _vehicleNumberController.text,
          'Vehicle Size': _selectedVehicleSize ?? 'N/A',
          'Driver Name': _driverNameController.text,
          'Driver Number': _driverNumberController.text,
          // 'Order ID': viewModel.collectionFormData.sOrderId ?? '',
        };

        String? validationErrors = viewModel.validateFormData();
        if (validationErrors != null) {
          dev.log('Form validation errors: $validationErrors',
              name: 'EntryTab');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(validationErrors)),
          );
          return;
        }

        dev.log('Upserting collection form data', name: 'EntryTab');
        bool upsertResult = await viewModel.upsertCollectionFormData();
        if (!upsertResult) {
          throw Exception("Failed to upsert data");
        }
        print('EntryTab: Upsert successful for sOrderId: $sOrderId');
        dev.log('Upsert successful', name: 'EntryTab');

        dev.log('Printing form data', name: 'EntryTab');
        await CollectionPrinter.printFormData(
          printData,
          'Entry',
          // viewModel.collectionFormData.sOrderId!,
          sOrderId, // Use sOrderId directly instead of viewModel.collectionFormData.sOrderId!
          context,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Entry data submitted and printed successfully')),
        );
        // Clear the form and reset the ViewModel
        _clearForm();
        viewModel.resetForm();
        dev.log('Form cleared and reset', name: 'EntryTab');
      } catch (e) {
        dev.log('Error in _submitForm: $e', name: 'EntryTab');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form: $e')),
        );
      }
    } else {
      dev.log('Form validation failed', name: 'EntryTab');
    }
  }

  void _clearForm() {
    _reachNameController.clear();
    _vehicleNumberController.clear();
    _driverNameController.clear();
    _driverNumberController.clear();
    setState(() {
      _selectedTypeOfDispatch = null;
      _selectedVehicleSize = null;
    });
  }

  @override
  void dispose() {
    _reachNameController.dispose();
    _vehicleNumberController.dispose();
    _driverNameController.dispose();
    _driverNumberController.dispose();
    super.dispose();
  }

  Widget _buildPhoneField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return null;
        } else if (value.length != 10) {
          return 'Phone number must be exactly 10 digits';
        }
        return null;
      },
    );
  }

  // Widget _buildTextField({
  //   required TextEditingController controller,
  //   required String label,
  //   TextInputType keyboardType = TextInputType.text,
  //   String? Function(String?)? validator,
  // }) {
  //   return TextFormField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //       labelText: label,
  //       border: const OutlineInputBorder(),
  //     ),
  //     keyboardType: keyboardType,
  //     validator: validator ??
  //         (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please enter $label';
  //           }
  //           return null;
  //         },
  //   );
  // }

  // Widget _buildDropdownField({
  //   required String label,
  //   required String? value,
  //   required List<String> items,
  //   required ValueChanged<String?> onChanged,
  // }) {
  //   return DropdownButtonFormField<String>(
  //     value: items.contains(value) ? value : null,
  //     decoration: InputDecoration(
  //       labelText: label,
  //       border: const OutlineInputBorder(),
  //     ),
  //     items: items.map((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //     onChanged: onChanged,
  //   );
  // }
}

// // filename: entry_tab.dart
// import 'dart:async';
// import 'dart:developer' as dev;
//
// import 'package:common/common_widgets.dart';
// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
//
// class EntryTab extends StatefulWidget {
//   const EntryTab({Key? key}) : super(key: key);
//
//   @override
//   _EntryTabState createState() => _EntryTabState();
// }
//
// class _EntryTabState extends State<EntryTab> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers for form fields
//   final TextEditingController _reachNameController = TextEditingController();
//   final TextEditingController _vehicleNumberController =
//       TextEditingController();
//   final TextEditingController _driverNameController = TextEditingController();
//   final TextEditingController _driverNumberController = TextEditingController();
//   final TextEditingController _vehicleSizeController = TextEditingController();
//   String? _selectedTypeOfDispatch;
//   String? _selectedVehicleSize;
//
//   bool printBinded = false;
//   int paperSize = 0;
//   String serialNumber = "";
//   String printerVersion = "";
//
//   String sOrderid = "";
//
//   // Hardcoded list of vehicle sizes
//   final List<String> vehicleSizes = ['10 Tyre', '12 Tyre', '16 Tyre'];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _bindingPrinter().then((bool? isBind) async {
//       SunmiPrinter.paperSize().then((int size) {
//         setState(() {
//           paperSize = size;
//         });
//       });
//
//       SunmiPrinter.printerVersion().then((String version) {
//         setState(() {
//           printerVersion = version;
//         });
//       });
//
//       SunmiPrinter.serialNumber().then((String serial) {
//         setState(() {
//           serialNumber = serial;
//         });
//       });
//
//       setState(() {
//         printBinded = isBind!;
//       });
//     });
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeFormData();
//     });
//   }
//
//   // Initialize form data from ViewModel
//   void _initializeFormData() {
//     final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
//     final formData = viewModel.collectionFormData;
//
//     _reachNameController.text = formData.bunitname ?? '';
//     _vehicleNumberController.text = formData.vehicleNumber ?? '';
//     _driverNameController.text = formData.driverName ?? '';
//     _driverNumberController.text = ''; // driverNumber is not in the new model
//     _vehicleSizeController.text = formData.vehicleSize ?? '';
//
//     setState(() {
//       _selectedTypeOfDispatch = formData.saletypename;
//       _selectedVehicleSize = formData.vehicleSize;
//     });
//   }
//
//   /// must binding ur printer at first init in app
//   Future<bool?> _bindingPrinter() async {
//     final bool? result = await SunmiPrinter.bindingPrinter();
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CollectionViewModel>(
//       builder: (context, viewModel, child) {
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 16.0),
//                 _buildDropdownField(
//                   label: 'Type of Dispatch',
//                   value: _selectedTypeOfDispatch,
//                   items: viewModel.dropdownOptions['typeOfDispatch'] ?? [],
//                   onChanged: (value) =>
//                       setState(() => _selectedTypeOfDispatch = value),
//                 ),
//                 const SizedBox(height: 16.0),
//                 _buildTextField(
//                   controller: _vehicleNumberController,
//                   label: 'Vehicle Number',
//                 ),
//                 const SizedBox(height: 16.0),
//                 // _buildTextField(
//                 //   controller: _vehicleSizeController,
//                 //   label: 'Vehicle Size',
//                 //   keyboardType: TextInputType.number,
//                 // ),
//                 _buildDropdownField(
//                   label: 'Vehicle Size',
//                   value: _selectedVehicleSize,
//                   items: vehicleSizes,
//                   onChanged: (value) =>
//                       setState(() => _selectedVehicleSize = value),
//                 ),
//                 const SizedBox(height: 16.0),
//                 _buildTextField(
//                   controller: _driverNameController,
//                   label: 'Driver Name',
//                 ),
//                 const SizedBox(height: 16.0),
//                 _buildPhoneField(
//                   controller: _driverNumberController,
//                   label: 'Driver Number',
//                 ),
//                 const SizedBox(height: 24.0),
//                 ElevatedButton(
//                   onPressed: () => _submitForm(viewModel),
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildPhoneField({
//     required TextEditingController controller,
//     required String label,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       keyboardType: TextInputType.phone,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(10),
//       ],
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return null; // It's okay if the phone number is not entered
//         } else if (value.length != 10) {
//           return 'Phone number must be exactly 10 digits';
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       keyboardType: keyboardType,
//       validator: validator ??
//           (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter $label';
//             }
//             return null;
//           },
//     );
//   }
//
//   Widget _buildDropdownField({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: items.contains(value) ? value : null,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       items: items.map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: onChanged,
//     );
//   }
//
//   // void _submitForm(CollectionViewModel viewModel) async {
//   //   if (_formKey.currentState!.validate()) {
//   //     // Clear old data first
//   //     viewModel.resetForm();
//   //
//   //     viewModel.collectionFormData.sOrderId = CommonWidgets.generateSOrderId();
//   //     viewModel.collectionFormData.documentno =
//   //         CommonWidgets.generateOrderNumber();
//   //     dev.log('New sOrderId: ${viewModel.collectionFormData.sOrderId}',
//   //         name: 'EntryTab');
//   //     dev.log('New documentno: ${viewModel.collectionFormData.documentno}',
//   //         name: 'EntryTab');
//   //
//   //     if (_selectedTypeOfDispatch != null &&
//   //         viewModel.dropdownOptions['typeOfDispatch']!
//   //             .contains(_selectedTypeOfDispatch)) {
//   //       viewModel.updateFormField('saletypename', _selectedTypeOfDispatch);
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text("Invalid Type of Dispatch selected")),
//   //       );
//   //       return;
//   //     }
//   //
//   //     viewModel.collectionFormData.bunitname = viewModel.userName;
//   //     viewModel.updateFormField(
//   //         'dateordered', viewModel.currentTransactionDate);
//   //     viewModel.updateFormField('vehicleNumber', _vehicleNumberController.text);
//   //     viewModel.updateFormField('vehicleSize', _selectedVehicleSize ?? '');
//   //     viewModel.updateFormField('driverName', _driverNameController.text);
//   //
//   //     try {
//   //       dev.log('Calling upsertCollectionFormData', name: 'EntryTab');
//   //       bool result = await viewModel.upsertCollectionFormData();
//   //       dev.log('upsertCollectionFormData completed', name: 'EntryTab');
//   //
//   //       if (result) {
//   //         dev.log('Upsert completed, preparing to print', name: 'EntryTab');
//   //
//   //         Map<String, String> printData = {
//   //           'Reach Name': viewModel.userName,
//   //           'Transaction Date': viewModel.currentTransactionDate,
//   //           'Type of Dispatch': _selectedTypeOfDispatch ?? '',
//   //           'Vehicle Number': _vehicleNumberController.text,
//   //           'Vehicle Size': _selectedVehicleSize ?? 'N/A',
//   //           'Driver Name': _driverNameController.text,
//   //           'Driver Number': _driverNumberController.text,
//   //         };
//   //
//   //         dev.log('Printing form data', name: 'EntryTab');
//   //         await CollectionPrinter.printFormData(
//   //           printData,
//   //           'Entry',
//   //           viewModel.collectionFormData.sOrderId ?? '',
//   //           context,
//   //         );
//   //
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           const SnackBar(
//   //               content: Text('Entry data submitted and printed successfully')),
//   //         );
//   //         _clearForm();
//   //       } else {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //               content:
//   //                   Text('Error submitting form: ${viewModel.errorMessage}')),
//   //         );
//   //       }
//   //     } catch (e) {
//   //       dev.log('Error in _submitForm: $e', name: 'EntryTab');
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Error submitting form: $e')),
//   //       );
//   //     }
//   //   }
//   // }
//
//   ///Testing
//   // void _submitForm(CollectionViewModel viewModel) async {
//   //   if (_formKey.currentState!.validate()) {
//   //     // Clear old data first
//   //     viewModel.resetForm();
//   //
//   //     // Generate new IDs
//   //     String sOrderId = CommonWidgets.generateSOrderId();
//   //     String documentNo = CommonWidgets.generateOrderNumber();
//   //
//   //     dev.log('New sOrderId: $sOrderId', name: 'EntryTab');
//   //     dev.log('New documentno: $documentNo', name: 'EntryTab');
//   //
//   //     // Validate Type of Dispatch
//   //     if (_selectedTypeOfDispatch == null ||
//   //         !viewModel.dropdownOptions['typeOfDispatch']!
//   //             .contains(_selectedTypeOfDispatch)) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text("Invalid Type of Dispatch selected")),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Prepare print data
//   //     Map<String, String> printData = {
//   //       'Reach Name': viewModel.userName,
//   //       'Transaction Date': viewModel.currentTransactionDate,
//   //       'Type of Dispatch': _selectedTypeOfDispatch!,
//   //       'Vehicle Number': _vehicleNumberController.text,
//   //       'Vehicle Size': _selectedVehicleSize ?? 'N/A',
//   //       'Driver Name': _driverNameController.text,
//   //       'Driver Number': _driverNumberController.text,
//   //       'Order ID': sOrderId,
//   //       'Document No': documentNo,
//   //     };
//   //
//   //     try {
//   //       // Print the data first
//   //       dev.log('Printing form data', name: 'EntryTab');
//   //       await CollectionPrinter.printFormData(
//   //         printData,
//   //         'Entry',
//   //         sOrderId,
//   //         context,
//   //       );
//   //
//   //       // Now prepare and upsert the data
//   //       viewModel.collectionFormData.sOrderId = sOrderId;
//   //       viewModel.collectionFormData.documentno = documentNo;
//   //       viewModel.collectionFormData.bunitname = viewModel.userName;
//   //       viewModel.updateFormField('saletypename', _selectedTypeOfDispatch);
//   //       viewModel.updateFormField(
//   //           'dateordered', viewModel.currentTransactionDate);
//   //       viewModel.updateFormField(
//   //           'vehicleNumber', _vehicleNumberController.text);
//   //       viewModel.updateFormField('vehicleSize', _selectedVehicleSize ?? '');
//   //       viewModel.updateFormField('driverName', _driverNameController.text);
//   //
//   //       dev.log('Calling upsertCollectionFormData', name: 'EntryTab');
//   //       bool result = await viewModel.upsertCollectionFormData();
//   //       dev.log('upsertCollectionFormData completed', name: 'EntryTab');
//   //
//   //       if (result) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           const SnackBar(
//   //               content: Text('Entry data printed and submitted successfully')),
//   //         );
//   //         _clearForm();
//   //       } else {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //               content:
//   //                   Text('Error submitting form: ${viewModel.errorMessage}')),
//   //         );
//   //       }
//   //     } catch (e) {
//   //       dev.log('Error in _submitForm: $e', name: 'EntryTab');
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Error: $e')),
//   //       );
//   //     }
//   //   }
//   // }
//   ///working
//   void _submitForm(CollectionViewModel viewModel) async {
//     if (_formKey.currentState!.validate()) {
//       // Clear old data first
//       // viewModel.resetForm();
//
//       sOrderid = CommonWidgets.generateSOrderId();
//       viewModel.collectionFormData.sOrderId ??= sOrderid;
//       // CommonWidgets.generateSOrderId();
//       viewModel.collectionFormData.documentno ??=
//           CommonWidgets.generateOrderNumber();
//
//       dev.log('New sOrderId: ${viewModel.collectionFormData.sOrderId}',
//           name: 'EntryTab');
//       dev.log('New documentno: ${viewModel.collectionFormData.documentno}',
//           name: 'EntryTab');
//
//       viewModel.collectionFormData.bunitname = viewModel.userName;
//       viewModel.updateFormField(
//           'dateordered', viewModel.currentTransactionDate);
//       viewModel.updateFormField('vehicleNumber', _vehicleNumberController.text);
//       // viewModel.updateFormField('vehicleSize', _vehicleSizeController.text);
//       viewModel.updateFormField('vehicleSize', _selectedVehicleSize ?? '');
//
//       viewModel.updateFormField('driverName', _driverNameController.text);
//       viewModel.updateFormField(
//           'dateordered', viewModel.currentTransactionDate);
//
//       if (_selectedTypeOfDispatch != null &&
//           viewModel.dropdownOptions['typeOfDispatch']!
//               .contains(_selectedTypeOfDispatch)) {
//         viewModel.updateFormField('saletypename', _selectedTypeOfDispatch);
//       } else {
//         print(
//             "Warning: Invalid typeOfDispatch selected: $_selectedTypeOfDispatch");
//         return;
//       }
//       // Note: driverNumber is not in the new model, so we're not updating it
//
//       // Print QR code first (sample code)
//       // dev.log('Printing QR code', name: 'EntryTab');
//       // await SunmiPrinter.initPrinter();
//       // await SunmiPrinter.startTransactionPrint(true);
//       // // await SunmiPrinter.printQRCode(sOrderId, size: 5);
//       // await SunmiPrinter.lineWrap(2);
//       // await SunmiPrinter.exitTransactionPrint(true);
//
//       try {
//         // Prepare print data
//         Map<String, String> printData = {
//           // 'Document No': viewModel.collectionFormData.documentno ?? '',
//           'Reach Name': viewModel.userName ?? '',
//           'Transaction Date': viewModel.currentTransactionDate ?? '',
//           'Type of Dispatch': _selectedTypeOfDispatch ?? '',
//           'Vehicle Number': _vehicleNumberController.text ?? '',
//           // 'Vehicle Size': _vehicleSizeController.text,
//           'Vehicle Size': _selectedVehicleSize ?? 'N/A',
//           'Driver Name': _driverNameController.text ?? '',
//           'Driver Number': _driverNumberController.text ?? '',
//           // testing
//           // 'Order ID': viewModel.collectionFormData.sOrderId ?? '',
//           // 'Document No': viewModel.collectionFormData.documentno ?? '',
//
//           ///sample below
//           // 'Reach Name': "Rahul",
//           // 'Transaction Date': "12-09/1999",
//           // 'Type of Dispatch': "DD",
//           // 'Vehicle Number': "AB28SV1234",
//           // // 'Vehicle Size': _vehicleSizeController.text,
//           // 'Vehicle Size': "12 Tyre",
//           // 'Driver Name': "Shyam",
//           // 'Driver Number': "1234567890",
//           // //testing
//           // 'Order ID': sOrderid ?? "",
//           // // 'Order ID': "12345678",
//           // // 'Document No': "DOC-GH12TYUN"
//           // 'Document No': viewModel.collectionFormData.documentno ?? "",
//         };
//
//         dev.log('Calling upsertCollectionFormData', name: 'EntryTab');
//         // Upsert data first
//         // await viewModel.upsertCollectionFormData();
//         bool upsertResult = await viewModel.upsertCollectionFormData();
//         if (!upsertResult) {
//           throw Exception("Failed to upsert data");
//         }
//         dev.log('upsertCollectionFormData completed', name: 'EntryTab');
//         dev.log('Upsert completed, preparing to print', name: 'EntryTab');
//
//         // Prepare print data
//
//         dev.log('Printing Sample data', name: 'EntryTab');
//         // print(printData); // Print the data
//         printMessage("$printData");
//         printMessageData("$sOrderid", name: 'printing generated data');
//
//         // dev.log('Printing form data', name: 'EntryTab');
//         await CollectionPrinter.printFormData(
//           printData,
//           'Entry',
//           // viewModel.collectionFormData.sOrderId!,
//           sOrderid,
//           // "12345678",
//           context,
//         );
//
//         // await SunmiPrinter.initPrinter();
//         // await SunmiPrinter.startTransactionPrint(true);
//         // await SunmiPrinter.printQRCode(
//         //     'https://github.com/brasizza/sunmi_printer');
//         // await SunmiPrinter.lineWrap(2);
//         // await SunmiPrinter.exitTransactionPrint(true);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Entry data submitted and printed successfully')),
//         );
//         // Clear the form after successful submission and printing
//         _clearForm();
//         // Reset the ViewModel's form data
//         viewModel.resetForm();
//       } catch (e) {
//         dev.log('Error in _submitForm: $e', name: 'EntryTab');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error submitting form: $e')),
//         );
//       }
//     }
//   }
//
//   void _updateUIWithFetchedData(CollectionFormModel fetchedData) {
//     setState(() {
//       _reachNameController.text = fetchedData.bunitname ?? '';
//       _selectedTypeOfDispatch = fetchedData.saletypename;
//       _vehicleNumberController.text = fetchedData.vehicleNumber ?? '';
//       _driverNameController.text = fetchedData.driverName ?? '';
//       _vehicleSizeController.text = fetchedData.vehicleSize ?? '';
//       //TODO: Needed to resolve the driver number issue from model and backend with response
//       // _driverNumberController.text = fetchedData.driverNumber ?? '';
//       // Note: driverNumber is not in the new model
//     });
//   }
//
//   void _clearForm() {
//     _reachNameController.clear();
//     _vehicleNumberController.clear();
//     _driverNameController.clear();
//     _driverNumberController.clear();
//     _vehicleSizeController.clear();
//     setState(() {
//       _selectedTypeOfDispatch = null;
//       _selectedVehicleSize = null;
//     });
//   }
//
//   @override
//   void dispose() {
//     _reachNameController.dispose();
//     _vehicleNumberController.dispose();
//     _driverNameController.dispose();
//     _driverNumberController.dispose();
//     _vehicleSizeController.dispose();
//     super.dispose();
//   }
// }
