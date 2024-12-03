import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';
import 'package:intl/intl.dart';

class CollectionUtils {
  static String generateSOrderId() {
    return CommonWidgets.generateSOrderId();
  }
//TODO: this function was use for random documentNo before.
  // static String generateOrderNumber() {
  //   return CommonWidgets.generateOrderNumber();
  // }

  static String generatedDocumentNoSequence() {
    return DocumentNumberGenerator.generateDocumentNumber();
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // static String formatTime(DateTime time) {
  //   return DateFormat('HH:mm:ss').format(time);
  // }

  static String formatTime(DateTime dateTime) {
    dev.log('Formatting time: $dateTime', name: 'CollectionUtils');
    try {
      String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
      dev.log('Formatted time: $formattedTime', name: 'CollectionUtils');
      return formattedTime;
    } catch (e) {
      dev.log('Error formatting time: $e', name: 'CollectionUtils');
      return dateTime.toIso8601String();
    }
  }

  static String currentDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }
}
