// /// below code is for JSON_Serialization
// /////////////////////////////////////////////////////////////////////////
// // import 'package:build_runner/build_runner.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// // import 'package:json_serializable/json_serializable.dart';
//
// part 'collection_form_model.g.dart';
//
// @JsonSerializable()
// class CollectionFormModel {
//   @JsonKey(name: 'sOrderId')
//   String? sOrderId;
//   @JsonKey(name: 'documentNo')
//   String? documentNo;
//   @JsonKey(name: 'reachName')
//   String? reachName;
//   @JsonKey(name: 'transactionDate')
//   String? transactionDate;
//   @JsonKey(name: 'typeOfDispatch')
//   String? typeOfDispatch;
//   @JsonKey(name: 'vehicleNumber')
//   String? vehicleNumber;
//   @JsonKey(name: 'vehicleSize')
//   String? vehicleSize;
//   @JsonKey(name: 'driverName')
//   String? driverName;
//   @JsonKey(name: 'driverNumber')
//   String? driverNumber;
//   @JsonKey(name: 'buckets')
//   String? buckets;
//   @JsonKey(name: 'bucketAmount')
//   String? bucketAmount;
//   @JsonKey(name: 'loadingCharges')
//   String? loadingCharges;
//   @JsonKey(name: 'tonnageAmount')
//   String? tonnageAmount;
//   @JsonKey(name: 'companyAmount')
//   String? companyAmount;
//   @JsonKey(name: 'credit')
//   String? credit;
//   @JsonKey(name: 'totalCollection')
//   String? totalCollection;
//   @JsonKey(name: 'partnerCredit')
//   String? partnerCredit;
//   @JsonKey(name: 'creditorName')
//   String? creditorName;
//   @JsonKey(name: 'suspenseAmount')
//   String? suspenseAmount;
//   @JsonKey(name: 'comments')
//   String? comments;
//   @JsonKey(name: 'paymentMethod')
//   String? paymentMethod;
//   @JsonKey(name: 'description')
//   String? description;
//   @JsonKey(name: 'loadingTime')
//   String? loadingTime;
//   @JsonKey(name: 'exitTime')
//   String? exitTime;
//   @JsonKey(name: 'loadingBy')
//   String? loadingBy;
//   @JsonKey(name: 'exitBy')
//   String? exitBy;
//   @JsonKey(name: 'type')
//   String? type;
//   @JsonKey(name: 'amount')
//   String? amount;
//   @JsonKey(name: 'remarks')
//   String? remarks;
//
//   CollectionFormModel({
//     this.sOrderId,
//     this.documentNo,
//     this.reachName,
//     this.transactionDate,
//     this.typeOfDispatch,
//     this.vehicleNumber,
//     this.vehicleSize,
//     this.driverName,
//     this.driverNumber,
//     this.buckets,
//     this.bucketAmount,
//     this.loadingCharges,
//     this.tonnageAmount,
//     this.companyAmount,
//     this.credit,
//     this.totalCollection,
//     this.partnerCredit,
//     this.creditorName,
//     this.suspenseAmount,
//     this.comments,
//     this.paymentMethod,
//     this.description,
//     this.loadingTime,
//     this.exitTime,
//     this.loadingBy,
//     this.exitBy,
//     this.type,
//     this.amount,
//     this.remarks,
//   });
//
//   //FromJson
//   factory CollectionFormModel.fromJson(Map<String, dynamic> json) =>
//       _$CollectionFormModelFromJson(json);
//
//   //ToJson
//   Map<String, dynamic> toJson() => _$CollectionFormModelToJson(this);
// }
// //////////////////////////////////////////////////////////////
