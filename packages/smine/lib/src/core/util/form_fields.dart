// form_fields.dart

import 'dart:async';

import 'package:common/common_widgets.dart';

class FormFields {
  // /// Builds a DropdownButtonFormField widget.
  // static Widget buildDropdownField({
  //   required String fieldName,
  //   required String? value,
  //   required List<String>? options,
  //   required Function(String?) onChanged,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16.0),
  //     child: DropdownButtonFormField<String>(
  //       value: value,
  //       items: options?.map((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //       onChanged: onChanged,
  //       decoration: InputDecoration(
  //         labelText: _capitalizeFieldName(fieldName),
  //         border: const OutlineInputBorder(),
  //         filled: true,
  //         fillColor: Colors.grey[200],
  //       ),
  //     ),
  //   );
  // }

  static Widget buildDropdownField({
    required String fieldName,
    required String? value,
    required List<String>? options,
    // required Function(String?) onChanged,
    required void Function(String?)? onChanged, // Change the type here
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: options?.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16), // Reduced font size
            ),
          );
        }).toList(),
        onChanged: onChanged, // This should now match
        isExpanded: true,
        decoration: InputDecoration(
          labelText: _capitalizeFieldName(fieldName),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 12), // Reduced padding
          isDense: true,
        ),
        dropdownColor: Colors.white,
        style: const TextStyle(
            color: Colors.black, fontSize: 16), // Reduced font size
        icon: const Icon(Icons.arrow_drop_down,
            size: 30), // Slightly smaller icon
      ),
    );
  }

  /// Builds a TextFormField widget with customizable properties.
  static Widget buildTextExpenseField({
    required String fieldName,
    required String? initialValue,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: _capitalizeFieldName(fieldName),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          isDense: true,
        ),
      ),
    );
  }

  ///this is old way
  static Widget buildTextCollectionField({
    required String fieldName,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLines,
    bool? readOnly,
    Function(String)? onChanged,
    Function()? onTap,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        maxLines: maxLines,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        onTap: onTap,
        style: const TextStyle(fontSize: 16), // Reduced font size
        decoration: InputDecoration(
          labelText: _capitalizeFieldName(fieldName),
          hintText: hintText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 14), // Reduced padding
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  // static String _capitalizeFieldName(String fieldName) {
  //   return fieldName.split('_').map((word) => word.capitalize()).join(' ');
  // }
  /// Capitalizes the first letter of the field name for display purposes.
  static String _capitalizeFieldName(String fieldName) {
    if (fieldName.isEmpty) return fieldName;
    return fieldName[0].toUpperCase() + fieldName.substring(1);
  }
}

// capitalize the first letter of a string.
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${substring(1)}";
//   }
// }

/// allows only uppercase alphabets and numbers. [GH05FG1234]
TextInputFormatter uppercaseAlphaNumericFormatter =
    TextInputFormatter.withFunction(
  (oldValue, newValue) {
    final regExp = RegExp(
        r'^[A-Z0-9]*$'); // Regex to allow only uppercase alphabets and numbers
    String newText = newValue.text.toUpperCase(); // Convert to uppercase

    if (regExp.hasMatch(newText)) {
      return newValue.copyWith(
        text: newText,
        selection: newValue.selection,
      );
    }
    return oldValue; // Reject invalid input
  },
);

///capitalize the first letter, restrict to numbers.[Banti Rathod]
TextInputFormatter customFormatter = TextInputFormatter.withFunction(
  (oldValue, newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any numbers from the text
    String newText = newValue.text.replaceAll(RegExp(r'[0-9]'), '');

    // Split the input into words
    List<String> words = newText.split(' ');

    // Process each word
    List<String> processedWords = words.map((word) {
      if (word.isNotEmpty) {
        // Capitalize the first letter and lowercase the rest
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return '';
    }).toList();

    // Join the words back together
    newText = processedWords.join(' ');

    // Preserve multiple spaces
    newText = newText.replaceAll(RegExp(r'\s+'), ' ');

    // If the new text is different from the input, update the selection
    TextSelection newSelection = newValue.selection;
    if (newText.length != newValue.text.length) {
      int offset = newText.length -
          (newValue.text.length - newValue.selection.baseOffset);
      newSelection =
          TextSelection.collapsed(offset: offset.clamp(0, newText.length));
    }

    return TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  },
);

/// TextInputFormatter for number and decimal input (e.g., 100 or 100.0)
TextInputFormatter numberDecimalInputFormatter =
    TextInputFormatter.withFunction(
  (oldValue, newValue) {
    // Allow empty field
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Use a regular expression to match valid number formats
    // This allows whole numbers and numbers with up to one decimal point
    final RegExp regex = RegExp(r'^\d*\.?\d{0,1}$');

    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }

    // If the new value doesn't match the regex, return the old value
    return oldValue;
  },
);

/// TextInputFormatter for double values with editable decimal part
/// TextInputFormatter for flexible double values input
TextEditingController _controller = TextEditingController();
Timer? _debounce;

TextInputFormatter doubleInputFormatter = TextInputFormatter.withFunction(
  (oldValue, newValue) {
    // Allow all numeric input
    String filteredText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Ensure only one decimal point
    int decimalIndex = filteredText.indexOf('.');
    if (decimalIndex != -1) {
      filteredText = filteredText.substring(0, decimalIndex + 1) +
          filteredText.substring(decimalIndex + 1).replaceAll('.', '');
    }

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  },
);
