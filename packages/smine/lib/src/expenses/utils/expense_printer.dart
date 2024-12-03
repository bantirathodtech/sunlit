// filename: expense_printer.dart

import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class ExpensePrinter {
  static Future<void> printFormData(
    Map<String, String> data,
    String expenseType,
    String documentNo,
    BuildContext context,
  ) async {
    try {
      // Initialize the printer and start a transaction
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);

      // Print the header centered and in large, bold font
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('Expense $expenseType \n Details',
          style: SunmiStyle(bold: true, fontSize: SunmiFontSize.LG));

      // Add a line space after the header
      await SunmiPrinter.lineWrap(1);

      // Print the form data, left-aligned for readability
      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await _printData(data);

      // Add a line space before the QR code
      await SunmiPrinter.lineWrap(1);

      // Center align for the QR code
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

      // Print the QR code (containing the documentNo)
      await SunmiPrinter.printQRCode(
        documentNo,
        errorLevel: SunmiQrcodeLevel.LEVEL_H,
      );

      // Add a line space after the QR code
      await SunmiPrinter.lineWrap(1);

      // Print the timestamp of when the receipt was printed
      await SunmiPrinter.printText('Printed on: ${DateTime.now().toString()}',
          style: SunmiStyle(fontSize: SunmiFontSize.SM));

      // Add extra space at the end of the receipt
      await SunmiPrinter.lineWrap(3);

      // Finish printing
      await SunmiPrinter.exitTransactionPrint(true);

      // Cut the paper to finish the receipt
      await SunmiPrinter.cut();
      dev.log('Finished printing expense form data', name: 'ExpensePrinter');
    } catch (e) {
      dev.log('Error printing: $e', name: 'ExpensePrinter');

      // Handle any errors that occur during printing
      if (kDebugMode) {
        print('Error printing: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error printing: $e')),
      );
    }
  }

  static Future<void> _printData(Map<String, String> data) async {
    for (var entry in data.entries) {
      await _printField(entry.key, entry.value);
    }
  }

  static Future<void> _printField(String label, String value) async {
    await SunmiPrinter.printText(
      '$label: ',
      style: SunmiStyle(bold: true),
    );
    await SunmiPrinter.printText(
      value,
      style: SunmiStyle(bold: false),
    );
  }
}
