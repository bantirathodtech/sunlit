// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:sunmi_printer_plus/column_maker.dart';
// import 'package:sunmi_printer_plus/enums.dart';
// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import 'package:sunmi_printer_plus/sunmi_style.dart';
//
// class SunmiViewModel extends GetxController {
//   RxBool printBinded = false.obs;
//   RxInt paperSize = 0.obs;
//   RxString serialNumber = "".obs;
//   RxString printerVersion = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _bindingPrinter().then((bool? isBind) async {
//       SunmiPrinter.paperSize().then((int size) {
//         paperSize.value = size;
//       });
//
//       SunmiPrinter.printerVersion().then((String version) {
//         printerVersion.value = version;
//       });
//
//       SunmiPrinter.serialNumber().then((String serial) {
//         serialNumber.value = serial;
//       });
//
//       printBinded.value = isBind!;
//     });
//   }
//
//   Future<bool?> _bindingPrinter() async {
//     final bool? result = await SunmiPrinter.bindingPrinter();
//     return result;
//   }
//
//   Future<void> printQRCode() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printQRCode('https://github.com/brasizza/sunmi_printer');
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printBarCode() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printBarCode('1234567890',
//         barcodeType: SunmiBarcodeType.CODE128,
//         textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
//         height: 20);
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printLine() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.line();
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> lineWrap(int lines) async {
//     await SunmiPrinter.lineWrap(lines);
//   }
//
//   Future<void> printBoldText() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText('Hello I\'m bold',
//         style: SunmiStyle(bold: true));
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printVerySmallFont() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText('Very small!',
//         style: SunmiStyle(fontSize: SunmiFontSize.XS));
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printSmallFont() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText('Very small!',
//         style: SunmiStyle(fontSize: SunmiFontSize.SM));
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printNormalFont() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText('Normal font',
//         style: SunmiStyle(fontSize: SunmiFontSize.MD));
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printLargeFont() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText('Large font',
//         style: SunmiStyle(fontSize: SunmiFontSize.LG));
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printVeryLargeFont() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.setFontSize(SunmiFontSize.XL);
//     await SunmiPrinter.printText('Very Large font!');
//     await SunmiPrinter.resetFontSize();
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printCustomSizeFont() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.setCustomFontSize(13);
//     await SunmiPrinter.printText('Very Large font!');
//     await SunmiPrinter.resetFontSize();
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> alignRight() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText('Align right',
//         style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> alignLeft() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText('Align left',
//         style: SunmiStyle(align: SunmiPrintAlign.LEFT));
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> alignCenter() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printText(
//       'Align center/ LARGE TEXT AND BOLD',
//       style: SunmiStyle(
//           align: SunmiPrintAlign.CENTER,
//           bold: true,
//           fontSize: SunmiFontSize.LG),
//     );
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printImageFromAssets() async {
//     await SunmiPrinter.initPrinter();
//     //packages/common/assets/receipt.jpg
//     Uint8List byte = await _getImageFromAsset('receipt.jpg');
//     await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printImage(byte);
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printImageFromWeb() async {
//     await SunmiPrinter.initPrinter();
//     String url = 'https://avatars.githubusercontent.com/u/14101776?s=100';
//     Uint8List byte = (await NetworkAssetBundle(Uri.parse(url)).load(url))
//         .buffer
//         .asUint8List();
//     await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printImage(byte);
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> cutPaper() async {
//     await SunmiPrinter.cut();
//   }
//
//   Future<void> printTicketExample() async {
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//     await SunmiPrinter.line();
//     await SunmiPrinter.printText('Payment receipt');
//     await SunmiPrinter.printText('Using the old way to bold!');
//     await SunmiPrinter.line();
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'Name', width: 12, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: 'Qty', width: 6, align: SunmiPrintAlign.CENTER),
//       ColumnMaker(text: 'UN', width: 6, align: SunmiPrintAlign.RIGHT),
//       ColumnMaker(text: 'TOT', width: 6, align: SunmiPrintAlign.RIGHT),
//     ]);
//
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'Fries', width: 12, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: '4x', width: 6, align: SunmiPrintAlign.CENTER),
//       ColumnMaker(text: '3.00', width: 6, align: SunmiPrintAlign.RIGHT),
//       ColumnMaker(text: '12.00', width: 6, align: SunmiPrintAlign.RIGHT),
//     ]);
//
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'Strawberry', width: 12, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: '1x', width: 6, align: SunmiPrintAlign.CENTER),
//       ColumnMaker(text: '24.44', width: 6, align: SunmiPrintAlign.RIGHT),
//       ColumnMaker(text: '24.44', width: 6, align: SunmiPrintAlign.RIGHT),
//     ]);
//
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'Soda', width: 12, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: '1x', width: 6, align: SunmiPrintAlign.CENTER),
//       ColumnMaker(text: '1.99', width: 6, align: SunmiPrintAlign.RIGHT),
//       ColumnMaker(text: '1.99', width: 6, align: SunmiPrintAlign.RIGHT),
//     ]);
//
//     await SunmiPrinter.line();
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'TOTAL', width: 25, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: '38.43', width: 5, align: SunmiPrintAlign.RIGHT),
//     ]);
//
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'ARABIC TEXT', width: 15, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: 'اسم المشترك', width: 15, align: SunmiPrintAlign.LEFT),
//     ]);
//
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'اسم المشترك', width: 15, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: 'اسم المشترك', width: 15, align: SunmiPrintAlign.LEFT),
//     ]);
//
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'RUSSIAN TEXT', width: 15, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(
//           text: 'Санкт-Петербу́рг', width: 15, align: SunmiPrintAlign.LEFT),
//     ]);
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(
//           text: 'Санкт-Петербу́рг', width: 15, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(
//           text: 'Санкт-Петербу́рг', width: 15, align: SunmiPrintAlign.LEFT),
//     ]);
//
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: 'CHINESE TEXT', width: 15, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: '風俗通義', width: 15, align: SunmiPrintAlign.LEFT),
//     ]);
//     await SunmiPrinter.printRow(cols: [
//       ColumnMaker(text: '風俗通義', width: 15, align: SunmiPrintAlign.LEFT),
//       ColumnMaker(text: '風俗通義', width: 15, align: SunmiPrintAlign.LEFT),
//     ]);
//
//     await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//     await SunmiPrinter.line();
//     await SunmiPrinter.bold();
//     await SunmiPrinter.printText('Transaction\'s Qrcode');
//     await SunmiPrinter.resetBold();
//     await SunmiPrinter.printQRCode('https://github.com/brasizza/sunmi_printer');
//     await SunmiPrinter.lineWrap(2);
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<void> printCustomESC() async {
//     final List<int> _escPos = await _customEscPos();
//     await SunmiPrinter.initPrinter();
//     await SunmiPrinter.startTransactionPrint(true);
//     await SunmiPrinter.printRawData(Uint8List.fromList(_escPos));
//     await SunmiPrinter.exitTransactionPrint(true);
//   }
//
//   Future<Uint8List> _getImageFromAsset(String iconPath) async {
//     return await readFileBytes(iconPath);
//   }
//
//   Future<List<int>> _customEscPos() async {
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm58, profile);
//     List<int> bytes = [];
//     bytes += generator.text(
//         'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//     bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//         styles: const PosStyles(codeTable: 'CP1252'));
//     bytes += generator.text('Special 2: blåbærgrød',
//         styles: const PosStyles(codeTable: 'CP1252'));
//
//     bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
//     bytes +=
//         generator.text('Reverse text', styles: const PosStyles(reverse: true));
//     bytes += generator.text('Underlined text',
//         styles: const PosStyles(underline: true), linesAfter: 1);
//     bytes += generator.text('Align left',
//         styles: const PosStyles(align: PosAlign.left));
//     bytes += generator.text('Align center',
//         styles: const PosStyles(align: PosAlign.center));
//     bytes += generator.text('Align right',
//         styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
//     bytes += generator.qrcode('Barcode by escpos',
//         size: QRSize.Size4, cor: QRCorrection.H);
//     bytes += generator.feed(2);
//
//     bytes += generator.row([
//       PosColumn(
//         text: 'col3',
//         width: 3,
//         styles: const PosStyles(align: PosAlign.center, underline: true),
//       ),
//       PosColumn(
//         text: 'col6',
//         width: 6,
//         styles: const PosStyles(align: PosAlign.center, underline: true),
//       ),
//       PosColumn(
//         text: 'col3',
//         width: 3,
//         styles: const PosStyles(align: PosAlign.center, underline: true),
//       ),
//     ]);
//
//     bytes += generator.text('Text size 200%',
//         styles: const PosStyles(
//           height: PosTextSize.size2,
//           width: PosTextSize.size2,
//         ));
//
//     bytes += generator.reset();
//     bytes += generator.cut();
//
//     return bytes;
//   }
// }
//
// Future<Uint8List> readFileBytes(String path) async {
//   ByteData fileData = await rootBundle.load(path);
//   Uint8List fileUnit8List = fileData.buffer
//       .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
//   return fileUnit8List;
// }
