// filename: collection_utils.dart

import 'package:common/common_widgets.dart';
import 'package:intl/intl.dart';

class CollectionUtils {
  static String generateSOrderId() {
    return CommonWidgets.generateSOrderId();
  }

  static String generateOrderNumber() {
    return CommonWidgets.generateOrderNumber();
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }

  // static String? safeParseString(dynamic value) {
  //   return value?.toString();
  // }

  // static int? safeParseInt(dynamic value) {
  //   if (value == null) return null;
  //   if (value is int) return value;
  //   if (value is String) return int.tryParse(value);
  //   return null;
  // }

  // static double? safeParseDouble(dynamic value) {
  //   if (value == null) return null;
  //   if (value is double) return value;
  //   if (value is int) return value.toDouble();
  //   if (value is String) return double.tryParse(value);
  //   return null;
  // }
}
