// filename: s_order_id_generator.dart

import 'dart:math';

class SOrderIdGenerator {
  static String generate() {
    final random = Random();
    final int maxHexLength = 8;
    final hexChars = '0123456789ABCDEF';
    StringBuffer buffer = StringBuffer();

    // Generate a 32-character hexadecimal string
    for (int i = 0; i < maxHexLength; i++) {
      final int hexCharIndex = random.nextInt(hexChars.length);
      buffer.write(hexChars[hexCharIndex]);
    }

    // Repeat the process to reach a 32-character string
    String orderId = buffer.toString();
    while (orderId.length < 32) {
      buffer.clear();
      for (int i = 0; i < maxHexLength; i++) {
        final int hexCharIndex = random.nextInt(hexChars.length);
        buffer.write(hexChars[hexCharIndex]);
      }
      orderId += buffer.toString();
    }

    // Trim the string to ensure it is exactly 32 characters long
    orderId = orderId.substring(0, 32);

    return orderId.toUpperCase();
  }
}
