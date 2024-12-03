// filename: qr_scanner_widget.dart

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerWidget extends StatefulWidget {
  final String scanType;
  final String currentTab;
  final Function(String) onScan;

  const QRScannerWidget({
    Key? key,
    required this.scanType,
    required this.currentTab,
    required this.onScan,
  }) : super(key: key);

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    dev.log(
        'QRScannerWidget initialized for ${widget.scanType} in ${widget.currentTab} tab',
        name: 'QRScannerWidget');
  }

  @override
  void dispose() {
    controller?.dispose();
    dev.log('QRScannerWidget disposed', name: 'QRScannerWidget');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   'Scan ${widget.scanType} QR code for ${widget.currentTab}',
        //   style: const TextStyle(fontSize: 12),
        // ),
        _isProcessing
            ? const CircularProgressIndicator()
            : IconButton(
                icon: const Icon(
                  Icons.qr_code_scanner,
                  size: 48,
                ),
                onPressed: _showQRScanner,
                tooltip: 'Scan ${widget.scanType} QR Code',
              ),
      ],
    );
  }

  void _showQRScanner() {
    dev.log('Showing QR Scanner dialog', name: 'QRScannerWidget');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Scan ${widget.scanType} QR Code'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                this.controller = controller;
                _onQRViewCreated(controller, dialogContext);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                dev.log('QR Scanner dialog closed manually',
                    name: 'QRScannerWidget');
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Close'),
            )
          ],
        );
      },
    ).then((_) {
      controller?.dispose();
      dev.log('QR Scanner controller disposed', name: 'QRScannerWidget');
    });
  }

  void _onQRViewCreated(
      QRViewController controller, BuildContext dialogContext) {
    dev.log('QR View created', name: 'QRScannerWidget');
    controller.scannedDataStream.listen((scanData) async {
      if (!mounted || _isProcessing) return;
      if (scanData.code != null) {
        dev.log('QR code scanned: ${scanData.code}', name: 'QRScannerWidget');
        setState(() => _isProcessing = true);
        controller.pauseCamera();
        dev.log('Camera paused for processing', name: 'QRScannerWidget');
        try {
          dev.log('Calling onScan with scanned data', name: 'QRScannerWidget');
          await widget.onScan(scanData.code!);
          dev.log('onScan completed successfully', name: 'QRScannerWidget');
          Navigator.of(dialogContext).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('QR code scanned successfully')),
          );
        } catch (e) {
          dev.log('Error in onScan: $e', name: 'QRScannerWidget');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching data: $e')),
          );
          controller.resumeCamera();
          dev.log('Camera resumed after error', name: 'QRScannerWidget');
        } finally {
          if (mounted) {
            setState(() => _isProcessing = false);
          }
          dev.log('Processing completed', name: 'QRScannerWidget');
        }
      }
    });
  }
}
