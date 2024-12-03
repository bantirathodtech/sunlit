// import 'dart:ui' as ui;
//
// import 'package:common/common_widgets.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:sunmi_printer_plus/enums.dart';
// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import 'package:sunmi_printer_plus/sunmi_style.dart';
//
// class ExpensesPrinter {
//   static Future<void> printCollectionDetails(
//       CollectionFormModel formData, BuildContext context) async {
//     try {
//       await SunmiPrinter.initPrinter();
//       await SunmiPrinter.startTransactionPrint(true);
//
//       // Print header
//       await SunmiPrinter.printText('QR Code Collection Details',
//           style: SunmiStyle(bold: true, align: SunmiPrintAlign.CENTER));
//       await SunmiPrinter.lineWrap(1);
//
//       // Print details
//       await SunmiPrinter.printText(
//           'Vehicle Number: ${formData.vehicleNumber ?? ''}');
//       await SunmiPrinter.printText('Vehicle: ${formData.vehicleSize ?? ''}');
//       await SunmiPrinter.printText('Buckets: ${formData.buckets ?? ''}');
//       await SunmiPrinter.printText('Time: ${DateTime.now().toString()}');
//       await SunmiPrinter.printText(
//           'Dispatch Type: ${formData.typeOfDispatch ?? ''}');
//       await SunmiPrinter.lineWrap(1);
//
//       // Generate and print QR code
//       String qrData =
//           'Vehicle: ${formData.vehicleNumber}, Buckets: ${formData.buckets}, Time: ${DateTime.now().toString()}';
//       final qrImage = await generateQrImage(qrData);
//       if (qrImage != null) {
//         // await SunmiPrinter.printImage(qrImage);
//         await SunmiPrinter.printQRCode(qrData);
//
//         // await SunmiPrinter.printQRCode('https://github.com/brasizza/sunmi_printer');
//       }
//       await SunmiPrinter.lineWrap(2);
//
//       await SunmiPrinter.exitTransactionPrint(true);
//     } catch (e) {
//       print('Error printing: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error printing: $e')),
//       );
//     }
//   }
//
//   static Future<Uint8List?> generateQrImage(String data) async {
//     try {
//       final qrPainter = QrPainter(
//         data: data,
//         version: QrVersions.auto,
//         errorCorrectionLevel: QrErrorCorrectLevel.L,
//       );
//       final qrImage = await qrPainter.toImage(200);
//       final byteData = await qrImage.toByteData(format: ui.ImageByteFormat.png);
//       return byteData?.buffer.asUint8List();
//     } catch (e) {
//       print('Error generating QR image: $e');
//       return null;
//     }
//   }
// }
