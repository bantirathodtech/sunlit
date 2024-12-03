// filename: order_number_generator.dart

//TODO: this class is use for generating documentNo in sequence. - Output: AA00AA0001
// class DocumentNumberGenerator {
//   static int _lastCounter = 0;
//
//   static String generateDocumentNumber() {
//     _lastCounter++;
//     String numberPart = _lastCounter.toString().padLeft(6, '0');
//     String alphaPart1 = _generateAlphaPart(_lastCounter ~/ (26 * 26));
//     String alphaPart2 = _generateAlphaPart((_lastCounter ~/ 26) % 26);
//     return 'DOC-$alphaPart1${numberPart.substring(0, 2)}$alphaPart2${numberPart.substring(2)}';
//   }
//
//   static String _generateAlphaPart(int index) {
//     return String.fromCharCode(65 + (index % 26));
//   }
//
//   // static void setLastGeneratedNumber(String lastNumber) {
//   //   if (lastNumber.length == 9) {
//   //     String numericPart = lastNumber.substring(1, 3) + lastNumber.substring(4);
//   //     _lastCounter = int.parse(numericPart);
//   //   }
//   // }
//   static void setLastGeneratedNumber(String lastNumber) {
//     if (lastNumber.length == 13) {
//       // Updated to account for "DOC-" prefix
//       String numericPart = lastNumber.substring(5, 7) + lastNumber.substring(8);
//       _lastCounter = int.parse(numericPart);
//     }
//   }
// }

//TODO: this class is use for generating documentNo randomly.
import 'dart:math';

class DocumentNumberGenerator {
  static String generateDocumentNumber() {
    final random = Random();
    final int documentNo =
        random.nextInt(0xFFFFFF); // Generate a random 24-bit integer
    print(documentNo);
    return 'DOC-${documentNo.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

// filename: order_number_generator.dart
//TODO:  DOC-00AA00
// class DocumentNumberGenerator {
//   static int _lastCounter = 0;
//
//   static String generateDocumentNumber() {
//     _lastCounter++;
//     String numberPart = _lastCounter.toString().padLeft(4, '0');
//     String alphaPart = _generateAlphaPart(_lastCounter ~/ 100);
//     return 'DOC-${numberPart.substring(0, 2)}$alphaPart${numberPart.substring(2)}';
//   }
//
//   static String _generateAlphaPart(int index) {
//     String first = String.fromCharCode(65 + (index ~/ 26) % 26);
//     String second = String.fromCharCode(65 + index % 26);
//     return '$first$second';
//   }
//
//   static void setLastGeneratedNumber(String lastNumber) {
//     if (lastNumber.length == 10) {
//       // "DOC-00AA00" is 10 characters long
//       String numericPart = lastNumber.substring(4, 6) + lastNumber.substring(8);
//       _lastCounter = int.parse(numericPart);
//     }
//   }
// }
//
///
// class DocumentNumberGenerator {
//   static int _lastCounter = 0;
//
//   static String generateDocumentNumber() {
//     _lastCounter++;
//     return 'DOC-$_lastCounter';
//   }
//
//   static void setLastGeneratedNumber(String lastNumber) {
//     if (lastNumber.startsWith('DOC-')) {
//       String numericPart = lastNumber.substring(4);
//       _lastCounter = int.parse(numericPart);
//     }
//   }
// }
