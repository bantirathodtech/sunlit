// filename: common_fields.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonWidgets {
  // static Widget buildDropdown({
  //   required List<String> items,
  //   String? selectedValue,
  //   required String hint,
  //   required ValueChanged<String?> onChanged,
  //   required String fieldName,
  //   String? Function(String?)? validator,
  // }) {
  //   return DropdownButtonFormField<String>(
  //     value: items.contains(selectedValue) ? selectedValue : null,
  //     decoration: InputDecoration(
  //       labelText: hint,
  //       border: const OutlineInputBorder(),
  //       contentPadding:
  //           const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //     ),
  //     items: items.map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value, overflow: TextOverflow.ellipsis),
  //       );
  //     }).toList(),
  //     onChanged: onChanged,
  //     validator: validator ??
  //         (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please select $hint';
  //           }
  //           return null;
  //         },
  //     isExpanded: true,
  //   );
  // }

  static Widget buildDropdown({
    required List<String> items,
    String? selectedValue,
    required String hint,
    required ValueChanged<String?> onChanged,
    required String fieldName,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: items.contains(selectedValue) ? selectedValue : null,
      decoration: InputDecoration(
        labelText: hint,
        hintText: "Select $hint ",
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      items: [
        DropdownMenuItem<String>(
          value: null,
          child:
              Text("Select $hint ", style: const TextStyle(color: Colors.grey)),
        ),
        ...items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, overflow: TextOverflow.ellipsis),
          );
        })
      ],
      onChanged: onChanged,
      isExpanded: true,
    );
  }

  static Widget buildBucketDropdown({
    required List<String> items,
    String? selectedValue,
    required String hint,
    required ValueChanged<String?> onChanged,
    required String fieldName,
    String? Function(String?)? validator,
  }) {
    // Remove duplicates and ensure all items are unique
    final uniqueItems = items.toSet().toList();

    // Check if the selectedValue is in the uniqueItems list
    final validSelectedValue =
        uniqueItems.contains(selectedValue) ? selectedValue : null;

    return DropdownButtonFormField<String>(
      value: validSelectedValue,
      decoration: InputDecoration(
        labelText: hint,
        hintText: "Select $hint",
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      items: [
        DropdownMenuItem<String>(
          value: null,
          child:
              Text("Select $hint", style: const TextStyle(color: Colors.grey)),
        ),
        ...uniqueItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, overflow: TextOverflow.ellipsis),
          );
        })
      ],
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
    );
  }

  static Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      // validator: validator ??
      //     (value) {
      //       if (value == null || value.isEmpty) {
      //         return 'Please enter $labelText';
      //       }
      //       return null;
      //     },
    );
  }

  static Widget buildButton({
    required VoidCallback onPressed,
    required String text,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(10)),
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Text(text),
    );
  }

  static Widget buildScannerIcon({
    required VoidCallback onPressed,
    Color color = Colors.blue,
    double size = 24.0,
  }) {
    return IconButton(
      icon: Icon(Icons.qr_code_scanner, color: color, size: size),
      onPressed: onPressed,
    );
  }

  static Widget buildRemoveButton({required VoidCallback onPressed}) {
    return IconButton(
      icon: const Icon(Icons.remove_circle_outline),
      onPressed: onPressed,
    );
  }

  String _generateSOrderId() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = random.nextInt(0xFFFFFFFF);
    return '${timestamp.toRadixString(16).padLeft(16, '0')}${randomPart.toRadixString(16).padLeft(8, '0')}';
  }

  String _generateDocumentNo() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'DOC-${timestamp.toString().padLeft(32, '0')}';
  }

  String _getCurrentFormattedTime() {
    return DateFormat('hh:mm:ss a').format(DateTime.now());
  }

  static String generateSOrderId() {
    final random = Random();
    const int maxHexLength = 8;
    const hexChars = '0123456789ABCDEF';
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < maxHexLength; i++) {
      final int hexCharIndex = random.nextInt(hexChars.length);
      buffer.write(hexChars[hexCharIndex]);
    }

    String orderId = buffer.toString();
    while (orderId.length < 32) {
      buffer.clear();
      for (int i = 0; i < maxHexLength; i++) {
        final int hexCharIndex = random.nextInt(hexChars.length);
        buffer.write(hexChars[hexCharIndex]);
      }
      orderId += buffer.toString();
    }

    orderId = orderId.substring(0, 32);
    return orderId.toUpperCase();
  }

  //TODO: this function was use for random documentNo before.
  static String generateOrderNumber() {
    final random = Random();
    final int documentNo = random.nextInt(0xFFFFFF);
    return 'DOC-${documentNo.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
