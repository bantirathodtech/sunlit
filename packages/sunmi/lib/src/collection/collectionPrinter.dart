// import 'package:common/common_widgets.dart';
// import 'package:sunmi_printer_plus/enums.dart';
// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import 'package:sunmi_printer_plus/sunmi_style.dart';
//
// class CollectionPrinter {
//   /// Prints the collection details including a header, form data, and a QR code.
//   /// This is the main function that orchestrates the entire printing process.
//   static Future<void> printCollectionDetails(
//       CollectionFormModel formData, BuildContext context) async {
//     try {
//       // Initialize the printer and start a transaction
//       await SunmiPrinter.initPrinter();
//       await SunmiPrinter.startTransactionPrint(true);
//
//       // Print the header centered and in large, bold font
//       await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//       await SunmiPrinter.printText('Collection Details',
//           style: SunmiStyle(bold: true, fontSize: SunmiFontSize.LG));
//
//       // Add a line space after the header
//       await SunmiPrinter.lineWrap(1);
//
//       // Print the form data with improved UI
//       await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
//       await _printFormData(formData);
//
//       // Add a line space before the QR code
//       await SunmiPrinter.lineWrap(1);
//
//       // Generate the QR code data
//       String qrData = _generateQRData(formData);
//
//       // Center align for the QR code
//       await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//
//       // Add a line space before the QR code
//       await SunmiPrinter.lineWrap(1);
//
//       // Print the QR code
//       await SunmiPrinter.printQRCode(qrData,
//           size: 8, errorLevel: SunmiQrcodeLevel.LEVEL_H);
//
//       // Add a line space after the QR code
//       await SunmiPrinter.lineWrap(1);
//
//       // Print the timestamp of when the receipt was printed
//       await SunmiPrinter.printText('Printed on: ${DateTime.now().toString()}',
//           style: SunmiStyle(fontSize: SunmiFontSize.SM));
//
//       // Add extra space at the end of the receipt
//       await SunmiPrinter.lineWrap(3);
//
//       // End the transaction print
//       await SunmiPrinter.exitTransactionPrint(true);
//
//       // Cut the paper to finish the receipt
//       await SunmiPrinter.cut();
//     } catch (e) {
//       // Handle any errors that occur during printing
//       if (kDebugMode) {
//         print('Error printing: $e');
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error printing: $e')),
//       );
//     }
//   }
//
//   /// Prints all the fields from the collection form data.
//   /// This function iterates through each field in the form and prints it.
//   static Future<void> _printFormData(CollectionFormModel formData) async {
//     // Print each field of the form data with improved UI
//     await _printField('Reach Name', formData.reachName);
//     // await _printField('Type of Dispatch', formData.typeOfDispatch);
//     await _printField('Transaction Date', formData.transactionDate);
//     await _printField('Vehicle Number', formData.vehicleNumber);
//     await _printField('Driver Name', formData.driverName);
//     await _printField('Driver Number', formData.driverNumber);
//     // await _printField('Vehicle Size', formData.vehicleSize);
//     // await _printField('Buckets', formData.buckets);
//     // await _printField('Bucket Amount', formData.bucketAmount);
//     // await _printField('Loading Charges', formData.loadingCharges);
//     // await _printField('Tonnage Amount', formData.tonnageAmount);
//     // await _printField('Company Amount', formData.companyAmount);
//     // await _printField('Credit', formData.credit);
//     // await _printField('Total Collection Incl Credit', formData.totalCollection);
//     // await _printField('Partner Credit', formData.partnerCredit);
//     // await _printField('Creditor Name', formData.creditorName);
//     // await _printField('Suspense', formData.suspense);
//     // await _printField('Free of Cost', formData.freeOfCost);
//     // await _printField('Payment Method', formData.paymentMethod);
//     // await _printField('Description', formData.description);
//   }
//
//   /// Prints a single field with a different style for the label and the value.
//   /// @param value The value of the field to be printed.
//   static Future<void> _printField(String label, String? value) async {
//     if (value != null && value.isNotEmpty) {
//       await SunmiPrinter.printText(
//         '$label: ',
//         style: SunmiStyle(
//           bold: true,
//           // underline: true,
//         ),
//       );
//       await SunmiPrinter.printText(
//         value,
//         style: SunmiStyle(bold: false),
//       );
//     }
//   }
//
//   /// Generates the data to be encoded in the QR code.
//   /// This function creates a string containing key information from the form data.
//   /// @param formData The collection form data to extract information from.
//   /// @return A string containing the vehicle number, number of buckets, and date.
//   static String _generateQRData(CollectionFormModel formData) {
//     return 'Vehicle: ${formData.vehicleNumber}, '
//         'Buckets: ${formData.buckets}, '
//         'Date: ${formData.transactionDate}';
//   }
// }
//
// //
// // import 'package:common/common_widgets.dart';
// // import 'package:sunmi_printer_plus/enums.dart';
// // import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// // import 'package:sunmi_printer_plus/sunmi_style.dart';
//
// class ExpensePrinter {
//   /// Prints the collection details including a header, form data, and a QR code.
//   /// This is the main function that orchestrates the entire printing process.
//   static Future<void> printExpenseDetails(
//       ExpenseFormModel formData, BuildContext context) async {
//     try {
//       // Initialize the printer and start a transaction
//       await SunmiPrinter.initPrinter();
//       await SunmiPrinter.startTransactionPrint(true);
//
//       // Print the header centered and in large, bold font
//       await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//       await SunmiPrinter.printText('Expense Details',
//           style: SunmiStyle(bold: true, fontSize: SunmiFontSize.LG));
//
//       // Add a line space after the header
//       await SunmiPrinter.lineWrap(1);
//
//       // Print the form data with improved UI
//       await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
//       await _printFormData(formData);
//
//       // Add a line space before the QR code
//       await SunmiPrinter.lineWrap(1);
//
//       // Generate the QR code data
//       String qrData = _generateQRData(formData);
//
//       // Center align for the QR code
//       await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//
//       // Add a line space before the QR code
//       await SunmiPrinter.lineWrap(1);
//
//       // Print the QR code
//       await SunmiPrinter.printQRCode(qrData,
//           size: 8, errorLevel: SunmiQrcodeLevel.LEVEL_H);
//
//       // Add a line space after the QR code
//       await SunmiPrinter.lineWrap(1);
//
//       // Print the timestamp of when the receipt was printed
//       await SunmiPrinter.printText('Printed on: ${DateTime.now().toString()}',
//           style: SunmiStyle(fontSize: SunmiFontSize.SM));
//
//       // Add extra space at the end of the receipt
//       await SunmiPrinter.lineWrap(3);
//
//       // End the transaction print
//       await SunmiPrinter.exitTransactionPrint(true);
//
//       // Cut the paper to finish the receipt
//       await SunmiPrinter.cut();
//     } catch (e) {
//       // Handle any errors that occur during printing
//       if (kDebugMode) {
//         print('Error printing: $e');
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error printing: $e')),
//       );
//     }
//   }
//
//   /// Prints all the fields from the collection form data.
//   /// This function iterates through each field in the form and prints it.
//   static Future<void> _printFormData(ExpenseFormModel formData) async {
//     // Print each field of the form data with improved UI
//     await _printField('location', formData.location);
//     await _printField('date', formData.date);
//     await _printField('name', formData.name);
//     await _printField('transactionType', formData.transactionType);
//     await _printField('payment', formData.payment);
//     await _printField('sourceAccount', formData.sourceAccount);
//     await _printField('destination', formData.destination);
//     await _printField('businessHead', formData.businessHead);
//     await _printField('expenseHead', formData.expenseHead);
//   }
//
//   /// Prints a single field with a different style for the label and the value.
//   /// @param value The value of the field to be printed.
//   static Future<void> _printField(String label, String? value) async {
//     if (value != null && value.isNotEmpty) {
//       await SunmiPrinter.printText(
//         '$label: ',
//         style: SunmiStyle(
//           bold: true,
//           // underline: true,
//         ),
//       );
//       await SunmiPrinter.printText(
//         value,
//         style: SunmiStyle(bold: false),
//       );
//     }
//   }
//
//   /// Generates the data to be encoded in the QR code.
//   /// This function creates a string containing key information from the form data.
//   /// @param formData The collection form data to extract information from.
//   /// @return A string containing the vehicle number, number of buckets, and date.
//   static String _generateQRData(ExpenseFormModel formData) {
//     return 'location: ${formData.location}, '
//         'transactionType: ${formData.transactionType}, '
//         'sourceAccount: ${formData.sourceAccount}';
//   }
// }
