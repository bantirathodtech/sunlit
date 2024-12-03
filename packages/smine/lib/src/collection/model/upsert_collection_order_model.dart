// // filename: upsert_collection_order_model.dart
// class UpsertCollectionOrderModel {
//   final String code;
//   final String message;
//
//   UpsertCollectionOrderModel({
//     required this.code,
//     required this.message,
//   });
//
//   factory UpsertCollectionOrderModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionOrderModel(
//       code: json['code'],
//       message: json['message'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'code': code,
//       'message': message,
//     };
//   }
// }
//
// class UpsertCollectionResponseModel {
//   final UpsertCollectionOrderModel upsertCollectionOrders;
//
//   UpsertCollectionResponseModel({
//     required this.upsertCollectionOrders,
//   });
//
//   factory UpsertCollectionResponseModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionResponseModel(
//       upsertCollectionOrders:
//           UpsertCollectionOrderModel.fromJson(json['upsertCollectionOrders']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'upsertCollectionOrders': upsertCollectionOrders.toJson(),
//     };
//   }
// }
//
// class UpsertCollectionModel {
//   final UpsertCollectionResponseModel data;
//
//   UpsertCollectionModel({
//     required this.data,
//   });
//
//   factory UpsertCollectionModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionModel(
//       data: UpsertCollectionResponseModel.fromJson(json['data']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'data': data.toJson(),
//     };
//   }
// }
////////////////////////////////////////////////////////////////
///
// class UpsertCollectionModel {
//   final UpsertCollectionResponseModel data;
//
//   UpsertCollectionModel({required this.data});
//
//   factory UpsertCollectionModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionModel(
//       data: UpsertCollectionResponseModel.fromJson(json['data'] ?? {}),
//     );
//   }
// }
//
// class UpsertCollectionResponseModel {
//   final UpsertCollectionOrderModel upsertCollectionOrders;
//
//   UpsertCollectionResponseModel({required this.upsertCollectionOrders});
//
//   factory UpsertCollectionResponseModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionResponseModel(
//       upsertCollectionOrders: UpsertCollectionOrderModel.fromJson(
//           json['upsertCollectionOrders'] ?? {}),
//     );
//   }
// }
//
// class UpsertCollectionOrderModel {
//   final String code;
//   final String message;
//
//   UpsertCollectionOrderModel({required this.code, required this.message});
//
//   factory UpsertCollectionOrderModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionOrderModel(
//       code: json['code']?.toString() ?? '',
//       message: json['message']?.toString() ?? '',
//     );
//   }
// }
//////////////////////////////////////////////////////////////
/// new with auto convert
// import 'dart:convert';
//
// class UpsertCollectionModel {
//   final UpsertCollectionResponseModel data;
//
//   UpsertCollectionModel({required this.data});
//
//   factory UpsertCollectionModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionModel(
//       data: UpsertCollectionResponseModel.fromJson(json['data'] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'data': data.toJson(),
//     };
//   }
//
//   static UpsertCollectionModel fromRawJson(String str) =>
//       UpsertCollectionModel.fromJson(json.decode(str));
//   String toRawJson() => json.encode(toJson());
// }
//
// class UpsertCollectionResponseModel {
//   final UpsertCollectionOrderModel upsertCollectionOrders;
//
//   UpsertCollectionResponseModel({required this.upsertCollectionOrders});
//
//   factory UpsertCollectionResponseModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionResponseModel(
//       upsertCollectionOrders: UpsertCollectionOrderModel.fromJson(
//           json['upsertCollectionOrders'] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'upsertCollectionOrders': upsertCollectionOrders.toJson(),
//     };
//   }
//
//   static UpsertCollectionResponseModel fromRawJson(String str) =>
//       UpsertCollectionResponseModel.fromJson(json.decode(str));
//   String toRawJson() => json.encode(toJson());
// }
//
// class UpsertCollectionOrderModel {
//   final String code;
//   final String message;
//
//   UpsertCollectionOrderModel({required this.code, required this.message});
//
//   factory UpsertCollectionOrderModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionOrderModel(
//       code: json['code']?.toString() ?? '',
//       message: json['message']?.toString() ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'code': code,
//       'message': message,
//     };
//   }
//
//   static UpsertCollectionOrderModel fromRawJson(String str) =>
//       UpsertCollectionOrderModel.fromJson(json.decode(str));
//   String toRawJson() => json.encode(toJson());
// }
//
// // Helper functions for list conversion if needed
//
// List<UpsertCollectionModel> upsertCollectionModelListFromJson(String str) =>
//     List<UpsertCollectionModel>.from(
//         json.decode(str).map((x) => UpsertCollectionModel.fromJson(x)));
//
// String upsertCollectionModelListToJson(List<UpsertCollectionModel> dataList) =>
//     json.encode(List<dynamic>.from(dataList.map((x) => x.toJson())));

///
// class UpsertCollectionModel {
//   final UpsertCollectionResponseModel data;
//
//   UpsertCollectionModel({required this.data});
//
//   factory UpsertCollectionModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionModel(
//       data: UpsertCollectionResponseModel.fromJson(json['data'] ?? {}),
//     );
//   }
// }
//
// class UpsertCollectionResponseModel {
//   final UpsertCollectionOrderModel upsertCollectionOrders;
//
//   UpsertCollectionResponseModel({required this.upsertCollectionOrders});
//
//   factory UpsertCollectionResponseModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionResponseModel(
//       upsertCollectionOrders: UpsertCollectionOrderModel.fromJson(
//           json['upsertCollectionOrders'] ?? {}),
//     );
//   }
// }
//
// class UpsertCollectionOrderModel {
//   final String code;
//   final String message;
//
//   UpsertCollectionOrderModel({required this.code, required this.message});
//
//   factory UpsertCollectionOrderModel.fromJson(Map<String, dynamic> json) {
//     return UpsertCollectionOrderModel(
//       code: json['code']?.toString() ?? '',
//       message: json['message']?.toString() ?? '',
//     );
//   }
// }

///
class UpsertCollectionModel {
  final UpsertCollectionResponseModel data;

  UpsertCollectionModel({required this.data});

  factory UpsertCollectionModel.fromJson(Map<String, dynamic> json) {
    return UpsertCollectionModel(
      data: UpsertCollectionResponseModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class UpsertCollectionResponseModel {
  final UpsertCollectionOrderModel upsertCollectionOrders;

  UpsertCollectionResponseModel({required this.upsertCollectionOrders});

  factory UpsertCollectionResponseModel.fromJson(Map<String, dynamic> json) {
    return UpsertCollectionResponseModel(
      upsertCollectionOrders: UpsertCollectionOrderModel.fromJson(
          json['upsertCollectionOrders'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'upsertCollectionOrders': upsertCollectionOrders.toJson(),
    };
  }
}

class UpsertCollectionOrderModel {
  final String code;
  final String message;

  UpsertCollectionOrderModel({required this.code, required this.message});

  factory UpsertCollectionOrderModel.fromJson(Map<String, dynamic> json) {
    return UpsertCollectionOrderModel(
      code: json['code']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}
//The UpsertCollectionModel is used to represent the response from the server when upserting (inserting or updating) collection orders. It's a separate model from CollectionFormModel because it represents a different type of data - the result of an operation rather than the data being sent.
// For learning purposes, this model demonstrates:
//
// Nested JSON structures
// How to handle optional fields
// How to create factory constructors for JSON deserialization
// How to implement toJson methods for serialization
//UpsertCollectionModel likely represents the response from the server after attempting to upsert (insert or update) a collection.
//
// The UpsertCollectionModel probably contains information about whether the upsert operation was successful, and any messages or codes returned by the server. It's a different data structure with a different purpose.
