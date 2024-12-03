// filename: collection_payment_model.dart

import 'dart:convert';

class CollectionPaymentModel {
  final String? paymentMethod;
  final String? type;
  final String? amount;
  final String? remarks;

  CollectionPaymentModel({
    this.paymentMethod,
    this.type,
    this.amount,
    this.remarks,
  });

  factory CollectionPaymentModel.fromJson(Map<String, dynamic> json) {
    return CollectionPaymentModel(
      paymentMethod: json['paymentMethod']?.toString(),
      type: json['type']?.toString(),
      amount: json['amount']?.toString(),
      remarks: json['remarks']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentMethod': paymentMethod?.isEmpty == true ? null : paymentMethod,
      'type': type?.isEmpty == true ? null : type,
      'amount': amount?.isEmpty == true ? null : amount,
      'remarks': remarks?.isEmpty == true ? null : remarks,
    };
  }

  CollectionPaymentModel copyWith({
    String? paymentMethod,
    String? type,
    String? amount,
    String? remarks,
  }) {
    return CollectionPaymentModel(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
    );
  }

  // Converts a JSON string to a single CollectionPaymentModel object
  // Use: When receiving a single payment data from an API
  static CollectionPaymentModel collectionPaymentModelFromJson(String str) =>
      CollectionPaymentModel.fromJson(json.decode(str));

  // Converts a single CollectionPaymentModel object to a JSON string
  // Use: When sending a single payment data to an API or storing it
  static String collectionPaymentModelToJson(
          CollectionPaymentModel collectionPaymentModel) =>
      json.encode(collectionPaymentModel.toJson());

  // Converts a JSON string containing a list of payments to a List of CollectionPaymentModel objects
  // Use: When receiving multiple payment data from an API
  static List<CollectionPaymentModel> getCollectionPaymentModelsFromJson(
          String str) =>
      List<CollectionPaymentModel>.from(
          json.decode(str).map((x) => CollectionPaymentModel.fromJson(x)));

  // Converts a List of CollectionPaymentModel objects to a JSON string
  // Use: When sending multiple payment data to an API or storing them
  static String getCollectionPaymentModelsToJson(
          List<CollectionPaymentModel> dataList) =>
      json.encode(List<dynamic>.from(dataList.map((x) => x.toJson())));
}

// // filename: collection_payment_model.dart
//
// import 'dart:convert';
//
// class CollectionPaymentModel {
//   final String? paymentMethod;
//   final String? type;
//   final String? amount;
//   final String? remarks;
//
//   CollectionPaymentModel({
//     this.paymentMethod,
//     this.type,
//     this.amount,
//     this.remarks,
//   });
//
//   factory CollectionPaymentModel.fromJson(Map<String, dynamic> json) {
//     return CollectionPaymentModel(
//       paymentMethod: json['paymentMethod']?.toString(),
//       type: json['type']?.toString(),
//       amount: json['amount']?.toString(),
//       remarks: json['remarks']?.toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'paymentMethod': paymentMethod?.isEmpty == true ? null : paymentMethod,
//       'type': type?.isEmpty == true ? null : type,
//       'amount': amount?.isEmpty == true ? null : amount,
//       'remarks': remarks?.isEmpty == true ? null : remarks,
//     };
//   }
//
//   static List<CollectionPaymentModel> fromJsonString(String jsonString) {
//     try {
//       final List<dynamic> jsonList = json.decode(jsonString);
//       return jsonList
//           .map((json) => CollectionPaymentModel.fromJson(json))
//           .toList();
//     } catch (e) {
//       print('Error parsing payment JSON: $e');
//       return [];
//     }
//   }
//
//   CollectionPaymentModel copyWith({
//     String? paymentMethod,
//     String? type,
//     String? amount,
//     String? remarks,
//   }) {
//     return CollectionPaymentModel(
//       paymentMethod: paymentMethod ?? this.paymentMethod,
//       type: type ?? this.type,
//       amount: amount ?? this.amount,
//       remarks: remarks ?? this.remarks,
//     );
//   }
// }

// ////////////////////////////////////////////////////////////////////////////////////////////////
///Following model Using JSON Encoding:
//
// import 'dart:convert';
//
// class CollectionPaymentModel {
//   final String? paymentMethod;
//   final String? type;
//   final double? amount;
//   final String? remarks;
//
//   CollectionPaymentModel({
//     this.paymentMethod,
//     this.type,
//     this.amount,
//     this.remarks,
//   });
//
//   factory CollectionPaymentModel.fromJson(Map<String, dynamic> json) {
//     return CollectionPaymentModel(
//       paymentMethod: json['paymentMethod']?.toString(),
//       type: json['type']?.toString(),
//       amount: json['amount'] != null
//           ? double.tryParse(json['amount'].toString())
//           : null,
//       remarks: json['remarks']?.toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'paymentMethod': paymentMethod?.isEmpty == true ? null : paymentMethod,
//       'type': type?.isEmpty == true ? null : type,
//       'amount': amount,
//       'remarks': remarks?.isEmpty == true ? null : remarks,
//     };
//   }
//
//   CollectionPaymentModel copyWith({
//     String? paymentMethod,
//     String? type,
//     double? amount,
//     String? remarks,
//   }) {
//     return CollectionPaymentModel(
//       paymentMethod: paymentMethod ?? this.paymentMethod,
//       type: type ?? this.type,
//       amount: amount ?? this.amount,
//       remarks: remarks ?? this.remarks,
//     );
//   }
//
//   // Converts a JSON string to a single CollectionPaymentModel object
//   // Use: When receiving a single payment data from an API
//   static CollectionPaymentModel collectionPaymentModelFromJson(String str) =>
//       CollectionPaymentModel.fromJson(json.decode(str));
//
//   // Converts a single CollectionPaymentModel object to a JSON string
//   // Use: When sending a single payment data to an API or storing it
//   static String collectionPaymentModelToJson(
//           CollectionPaymentModel collectionPaymentModel) =>
//       json.encode(collectionPaymentModel.toJson());
//
//   // Converts a JSON string containing a list of payments to a List of CollectionPaymentModel objects
//   // Use: When receiving multiple payment data from an API
//   static List<CollectionPaymentModel> getCollectionPaymentModelsFromJson(
//           String str) =>
//       List<CollectionPaymentModel>.from(
//           json.decode(str).map((x) => CollectionPaymentModel.fromJson(x)));
//
//   // Converts a List of CollectionPaymentModel objects to a JSON string
//   // Use: When sending multiple payment data to an API or storing them
//   static String getCollectionPaymentModelsToJson(
//           List<CollectionPaymentModel> dataList) =>
//       json.encode(List<dynamic>.from(dataList.map((x) => x.toJson())));
// }
///Following model Using JSON Encoding:
