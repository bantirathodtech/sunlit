import 'package:flutter/services.dart';

class RfidPlugin {
  static const MethodChannel _channel = MethodChannel('rfid_plugin');

  static Future<String?> getPlatformVersion() async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> readRfidTag() async {
    final String? rfidData = await _channel.invokeMethod('readRfidTag');
    return rfidData;
  }
}
