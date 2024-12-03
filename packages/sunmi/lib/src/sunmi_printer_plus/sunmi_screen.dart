// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'sunmi_viewmodel.dart';
//
// class SunmiScreen extends StatelessWidget {
//   final SunmiViewModel _viewModel = Get.put(SunmiViewModel());
//
//   SunmiScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         children: [
//           // Section 1: Printer Information
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Obx(
//                   () => Text("Print binded: ${_viewModel.printBinded.value}"),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Obx(
//                   () => Text("Paper size: ${_viewModel.paperSize.value}"),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Obx(
//                   () => Text("Serial number: ${_viewModel.serialNumber.value}"),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Obx(
//                   () => Text(
//                       "Printer version: ${_viewModel.printerVersion.value}"),
//                 ),
//               ),
//               const Divider(),
//             ],
//           ),
//
//           // Section 2: Printing Actions Grid (2 columns)
//           GridView.count(
//             shrinkWrap: true,
//             crossAxisCount: 2,
//             mainAxisSpacing: 10.0,
//             crossAxisSpacing: 10.0,
//             childAspectRatio: 2.5,
//             physics: const NeverScrollableScrollPhysics(),
//             children: [
//               ElevatedButton(
//                 onPressed: () => _viewModel.printQRCode(),
//                 child: const Text('Print QR Code'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printBarCode(),
//                 child: const Text('Print Bar Code'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printLine(),
//                 child: const Text('Print Line'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.lineWrap(2),
//                 child: const Text('Wrap Line'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printBoldText(),
//                 child: const Text('Bold Text'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printVerySmallFont(),
//                 child: const Text('Very small font'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printSmallFont(),
//                 child: const Text('Small font'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printNormalFont(),
//                 child: const Text('Normal font'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printLargeFont(),
//                 child: const Text('Large font'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printVeryLargeFont(),
//                 child: const Text('Very large font'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _viewModel.printCustomSizeFont(),
//                 child: const Text('Custom size font'),
//               ),
//             ],
//           ),
//
//           // Section 3: Alignment Buttons
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _viewModel.alignRight(),
//                     child: const Text('Align right'),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _viewModel.alignLeft(),
//                     child: const Text('Align left'),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _viewModel.alignCenter(),
//                     child: const Text('Align center'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Section 4: Image Printing Options
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => _viewModel.printImageFromAssets(),
//                     child: Column(
//                       children: [
//                         LayoutBuilder(
//                           builder: (context, constraints) {
//                             double imageSize = constraints.maxWidth *
//                                 0.4; // Adjust fraction as needed
//                             return FractionallySizedBox(
//                               widthFactor: 0.5, // Adjust width factor as needed
//                               child: Image.asset(
//                                 'assets/images/dash.png',
//                                 width: imageSize,
//                                 height: imageSize,
//                                 fit: BoxFit.cover,
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 8),
//                         const Text('Print this image from asset!')
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => _viewModel.printImageFromWeb(),
//                     child: Column(
//                       children: [
//                         LayoutBuilder(
//                           builder: (context, constraints) {
//                             double imageSize = constraints.maxWidth *
//                                 0.4; // Adjust fraction as needed
//                             return FractionallySizedBox(
//                               widthFactor: 0.5, // Adjust width factor as needed
//                               child: Image.network(
//                                 'https://avatars.githubusercontent.com/u/14101776?s=100',
//                                 width: imageSize,
//                                 height: imageSize,
//                                 fit: BoxFit.cover,
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 8),
//                         const Text('Print this image from WEB!')
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Section 5: Other Actions
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _viewModel.cutPaper(),
//                     child: const Text('CUT PAPER'),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _viewModel.printTicketExample(),
//                     child: const Text('TICKET EXAMPLE'),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _viewModel.printCustomESC(),
//                     child: const Text('Custom ESC/POS to print'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
