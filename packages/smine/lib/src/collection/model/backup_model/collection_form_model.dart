// // filename: collection_form_model.dart
//
// import 'package:common/common_widgets.dart';
//
// class CollectionFormModel {
//   ///Entry data
//   String? sOrderId;
//   String? documentNo;
//   String? reachName;
//   String? transactionDate;
//   String? typeOfDispatch;
//   String? vehicleNumber;
//   String? vehicleSize;
//   String? driverName;
//   String? driverNumber;
//
//   ///Payment data
//   String? buckets;
//   String? bucketAmount;
//   String? loadingCharges;
//   String? tonnageAmount;
//   String? companyAmount;
//   String? totalCollection;
//   String? creditorName;
//   String? suspenseAmount;
//   String? commentsPayment;
//   List<CollectionPaymentModel>? payments;
//
//   ///Loading Data
//   String? loadingTime;
//   String? loadingRemarks;
//
//   ///Exit Data
//   String? exitTime;
//   String? exitRemarks;
//
//   ///Default constructor
//   CollectionFormModel({
//     ///Entry data
//     this.sOrderId,
//     this.documentNo,
//     this.reachName,
//     this.transactionDate,
//     this.typeOfDispatch,
//     this.vehicleNumber,
//     this.vehicleSize,
//     this.driverName,
//     this.driverNumber,
//
//     ///Payment data
//     this.buckets,
//     this.bucketAmount,
//     this.loadingCharges,
//     this.tonnageAmount,
//     this.companyAmount,
//     this.totalCollection,
//     this.creditorName,
//     this.suspenseAmount,
//     this.commentsPayment,
//     this.payments,
//
//     ///Loading Data
//     this.loadingTime,
//     this.loadingRemarks,
//
//     ///Exit Data
//     this.exitTime,
//     this.exitRemarks,
//   });
//
//   // Factory constructor to create a new CollectionFormModel instance from JSON
//   factory CollectionFormModel.fromJson(Map<String, dynamic> json) {
//     return CollectionFormModel(
//       ///Entry data
//       // sOrderId: json['s_order_id']?.toString(),
//       sOrderId: json['s_order_id']?.toString() ?? json['sorderId']?.toString(),
//       documentNo: json['documentno']?.toString(),
//       reachName: json['reach_name']?.toString(),
//       transactionDate: json['dateordered']?.toString(),
//       typeOfDispatch: json['cwr_saletype_id']?.toString(),
//       vehicleNumber: json['vehicle_number']?.toString(),
//       vehicleSize: json['vehicle_size']?.toString(),
//       driverName: json['driver_name']?.toString(),
//       driverNumber: json['driver_number']?.toString(),
//
//       ///Payment data
//       buckets: json['buckets']?.toString(),
//       bucketAmount: json['bucket_amount']?.toString(),
//       loadingCharges: json['loading_charges']?.toString(),
//       tonnageAmount: json['tonnage_amount']?.toString(),
//       companyAmount: json['company_amount']?.toString(),
//       totalCollection: json['grosstotal']?.toString(),
//       creditorName: json['creditor_name']?.toString(),
//       suspenseAmount: json['suspense']?.toString(),
//       commentsPayment: json['description']?.toString(),
//
//       // payments: (json['payments'] as List<dynamic>?)
//       //         ?.map((p) => CollectionPaymentModel.fromJson(p))
//       //         .toList() ??
//       //     [],
//       payments: json['payments'] != null
//           ? List<CollectionPaymentModel>.from(
//           json['payments'].map((x) => CollectionPaymentModel.fromJson(x)))
//           : null,
//
//       ///Loading Data
//       loadingTime: json['loading_time']?.toString(),
//       loadingRemarks: json['loading_remarks']?.toString(),
//
//       ///Exit Data
//       exitTime: json['exit_time']?.toString(),
//       exitRemarks: json['exit_remarks']?.toString(),
//     );
//   }
//
//   // Method to convert CollectionFormModel instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       ///Entry Data
//       'sOrderId': sOrderId,
//       'documentNo': documentNo,
//       'reachName': reachName,
//       'transactionDate': transactionDate,
//       'typeOfDispatch': typeOfDispatch,
//       'vehicleNumber': vehicleNumber,
//       'vehicleSize': vehicleSize,
//       'driverName': driverName,
//
//       ///Payment Data
//       'buckets': buckets,
//       'bucketAmount': bucketAmount,
//       'loadingCharges': loadingCharges,
//       'tonnageAmount': tonnageAmount,
//       'companyAmount': companyAmount,
//       'totalCollection': totalCollection,
//       'suspenseAmount': suspenseAmount,
//       'commentsPayment': commentsPayment,
//       // 'payments': payments?.map((p) => p.toJson()).toList(),
//       'payments': payments?.map((x) => x.toJson()).toList(),
//
//       ///Loading Data
//       'loadingTime': loadingTime,
//       'loadingRemarks': loadingRemarks,
//
//       ///Exit Data
//       'exitTime': exitTime,
//       'exitRemarks': exitRemarks,
//     };
//   }
//
//   void mergeWith(CollectionFormModel other) {
//     ///Entry Data
//     sOrderId = other.sOrderId ?? sOrderId;
//     documentNo = other.documentNo ?? documentNo;
//     reachName = other.reachName ?? reachName;
//     transactionDate = other.transactionDate ?? transactionDate;
//     typeOfDispatch = other.typeOfDispatch ?? typeOfDispatch;
//     vehicleNumber = other.vehicleNumber ?? vehicleNumber;
//     vehicleSize = other.vehicleSize ?? vehicleSize;
//     driverName = other.driverName ?? driverName;
//     driverNumber = other.driverNumber ?? driverNumber;
//
//     ///Payment Data
//     buckets = other.buckets ?? buckets;
//     bucketAmount = other.bucketAmount ?? bucketAmount;
//     loadingCharges = other.loadingCharges ?? loadingCharges;
//     tonnageAmount = other.tonnageAmount ?? tonnageAmount;
//     companyAmount = other.companyAmount ?? companyAmount;
//     // credit = other.credit ?? credit;
//     totalCollection = other.totalCollection ?? totalCollection;
//     // partnerCredit = other.partnerCredit ?? partnerCredit;
//     creditorName = other.creditorName ?? creditorName;
//     suspenseAmount = other.suspenseAmount ?? suspenseAmount;
//     commentsPayment = other.commentsPayment ?? commentsPayment;
//     payments = other.payments ?? payments;
//
//     ///Loading Data
//     loadingTime = other.loadingTime ?? loadingTime;
//     loadingTime = other.loadingTime ?? loadingTime;
//
//     ///Exit Data
//     exitRemarks = other.exitRemarks ?? exitRemarks;
//     exitTime = other.exitTime ?? exitTime;
//   }
//
//   // Converts a JSON string to a single CollectionFormModel object
// // Use: When receiving a single collection form data from an API
//   static CollectionFormModel collectionFormModelFromJson(String str) =>
//       CollectionFormModel.fromJson(json.decode(str));
//
// // Converts a single CollectionFormModel object to a JSON string
// // Use: When sending a single collection form data to an API or storing it
//   static String collectionFormModelToJson(
//       CollectionFormModel collectionFormModel) =>
//       json.encode(collectionFormModel.toJson());
//
// // Converts a JSON string containing a list of collection forms to a List of CollectionFormModel objects
// // Use: When receiving multiple collection form data from an API
//   static List<CollectionFormModel> getCollectionFormModelsFromJson(
//       String str) =>
//       List<CollectionFormModel>.from(
//           json.decode(str).map((x) => CollectionFormModel.fromJson(x)));
//
// // Converts a List of CollectionFormModel objects to a JSON string
// // Use: When sending multiple collection form data to an API or storing them
//   static String getCollectionFormModelsToJson(
//       List<CollectionFormModel> dataList) =>
//       json.encode(List<dynamic>.from(dataList.map((x) => x.toJson())));
// }
//
// ///
