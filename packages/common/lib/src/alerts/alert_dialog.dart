
import 'package:flutter/material.dart';

hideAlertDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

hideBottomDialog(BuildContext context) {
  Navigator.pop(context, true);
}