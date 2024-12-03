//filename: constants.dart
//
import 'dart:developer';

import 'package:common/common_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final WidgetController widgetController = Get.put(WidgetController());
final navigatorKey = GlobalKey<NavigatorState>();

String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
var imageUploadUrl = "";
var coordinates = "17.436793:78.443906";

Color themeColor() {
  return HexColor(navyBlue);
}

///mycw
// String currentDateTime() {
//   return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
// }

String currentDateTime() {
  return DateTime.now().toIso8601String();
}

void printMessage(String message) {
  if (kDebugMode) {
    print("MyCW.........$message");
    log('', name: 'Space');
  }
}

void printMessageData(String message, {required String name}) {
  if (kDebugMode) {
    print("MyCW.........$message");
    log('', name: 'Space');
  }
}

String getWeekDay() {
  DateTime now = DateTime.now();
  int currentDay = now.weekday;
  DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay));
  String weekDay = firstDayOfWeek.toString();
  if (weekDay.contains(" ")) {
    weekDay = weekDay.split(" ")[0];
  }
  return weekDay;
}

String getMonthDate() {
  if (currentDate.contains("-")) {
    return "${currentDate.split("-")[0]}-${currentDate.split("-")[1]}-01";
  }
  return currentDate;
}

String getYearDate() {
  if (currentDate.contains("-")) {
    return "${currentDate.split("-")[0]}-01-01";
  }
  return currentDate;
}

showSnackBar(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

String checkString(String value) {
  if (!checkStatus(value)) {
    value = "";
  }
  return value;
}

String checkStringDash(String value) {
  if (!checkStatus(value)) {
    value = "-";
  }
  return value;
}

String checkValue(String value) {
  if (!checkStatus(value)) {
    return "Select Field";
  }
  return value;
}

String checkDouble(String value) {
  if (!checkStatus(value)) {
    value = "0";
  }
  value = splitValue(value);
  return value;
}

double checkDoubleValue(String value) {
  if (!checkStatus(value)) {
    return 0.0;
  }
  value = splitDoubleValue(value);
  return double.parse(value);
}

String splitValue(String value) {
  if (value.contains(".")) {
    List<String> w1 = value.split(".");
    value = w1[0];
  }
  if (value.contains("Infinity")) {
    value = "0";
  }
  return value;
}

String removeZeros(String value) {
  if (!checkStatus(value)) {
    value = "0";
  }
  if (value.contains(".")) {
    List<String> w1 = value.split(".");
    if (w1[0] == "00" || w1[0] == "0") {
      if (value.contains(".00")) {
        value = value.replaceAll(".00", "");
      }
      if (value.contains(".0")) {
        value = value.replaceAll(".0", "");
      }
    }
  }
  if (value.contains("Infinity")) {
    value = "0";
  }
  return value;
}

String splitDoubleValue(String value) {
  if (!checkStatus(value)) {
    value = "0";
  }
  if (value.contains(".")) {
    List<String> w1 = value.split(".");
    if (w1[1].length >= 4) {
      String w2 = w1[1].substring(0, 3);
      value = "${w1[0]}.$w2";
    }
  }
  return value;
}

String splitSingleDoubleValue(String value) {
  if (!checkStatus(value)) {
    value = "0";
  }
  if (value.contains(".")) {
    List<String> w1 = value.split(".");
    if (w1[1].length >= 2) {
      String w2 = w1[1].substring(0, 1);
      value = "${w1[0]}.$w2";
    }
  }
  return value;
}

String splitSpace(String value) {
  if (checkStatus(value) && value.contains(" ")) {
    value = value.split(" ")[0];
  }
  if (value.trim().contains("-")) {
    List<String> date = value.trim().split("-");
    if (date[0].length == 4) {
      return "${date[2]}-${date[1]}-${date[0]}";
    }
  }
  return value;
}

bool checkStatus(String id) {
  if (id.trim().isEmpty || id == "null") {
    return false;
  }
  return true;
}

String setNull(String s1) {
  String s = "null";
  if (checkStatus(s1)) {
    s = setString(s1);
  }
  return s;
}

String getUUID() {
  return const Uuid().v4().replaceAll("-", "").toUpperCase();
}

String setString(String value) {
  return "\"$value\"";
}

dynamic checkJsonString(String value) {
  if (!checkStatus(value) || checkString(value).contains("null")) {
    return null;
  }
  return value;
}

dynamic checkJsonValue(String value) {
  if (!checkStatus(value) || checkString(value).contains("null")) {
    return 0;
  }
  value = removeZeros(value);
  if (value.contains(".")) {
    return checkDoubleValue(value);
  }
  return int.parse(value);
}

String checkQtyWithUom(String qty, String uomName) {
  if (uomName.toLowerCase().contains("unit") ||
      uomName.toLowerCase().contains("pieces")) {
    return checkDouble(qty);
  }
  return splitDoubleValue(qty);
}

String checkConfirmQty(String qty) {
  if (!checkStatus(qty)) {
    return "-";
  }
  return qty;
}

String clubQty(String qty) {
  if (!checkStatus(qty)) {
    qty = "0";
  }
  if (qty.contains(".")) {
    qty = "${double.parse(qty) + 1}";
  } else {
    qty = "${int.parse(qty) + 1}";
  }
  return splitDoubleValue(qty);
}

String disClubQty(String qty) {
  if (!checkStatus(qty)) {
    qty = "0";
  }
  if (checkDoubleValue("0") < checkDoubleValue(qty)) {
    if (qty.contains(".")) {
      qty = "${double.parse(qty) - 1}";
    } else {
      qty = "${int.parse(qty) - 1}";
    }
  } else {
    showSnackBar("Confirmed Quantity must be >=0");
  }
  return splitDoubleValue(qty);
}

String clubProductQty(String qty, String productQty) {
  if (!checkStatus(qty)) {
    qty = "0";
  }
  if (checkDoubleValue(productQty) > checkDoubleValue(qty)) {
    if (qty.contains(".")) {
      qty = "${double.parse(qty) + 1}";
    } else {
      qty = "${int.parse(qty) + 1}";
    }
  } else {
    showSnackBar("Over Quantity is not allowed");
  }
  return splitDoubleValue(qty);
}
