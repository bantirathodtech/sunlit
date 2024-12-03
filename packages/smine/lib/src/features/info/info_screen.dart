// filename: info_screen.dart

import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final userIdData = loginViewModel.userIdData1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildInfoField('cs_bunit_id', userIdData.defaultCsBunitId), //don't know
            // _buildInfoField('Password', userIdData.password), //don't know
            // _buildInfoField('Role', userIdData.csRole), //To giving the access for screens base on role
            _buildInfoField(
                'Name', userIdData.name), //To knowing the name for screens
            // _buildInfoField('User ID', userIdData.csUserId), //To passing to the loadingBy, exitBy
            _buildInfoField('Username',
                userIdData.username), //To display the username in drawer
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
                  _printQRCode(context, userIdData.csUserId ?? 'Unknown'),
              child: const Text('Print QR Code'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          // const SizedBox(height: 4),
          Text(
            value ?? 'Not available',
            style: const TextStyle(fontSize: 14),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Future<void> _printQRCode(BuildContext context, String userId) async {
    try {
      dev.log('Printing QR code', name: 'InfoScreen');
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);
      await SunmiPrinter.printQRCode(userId, size: 10);
      await SunmiPrinter.lineWrap(5);
      await SunmiPrinter.exitTransactionPrint(true);
      dev.log('QR code printed successfully', name: 'InfoScreen');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code printed successfully')),
      );
    } catch (e) {
      dev.log('Error printing QR code: $e', name: 'InfoScreen');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error printing QR Code: $e')),
      );
    }
  }
}
