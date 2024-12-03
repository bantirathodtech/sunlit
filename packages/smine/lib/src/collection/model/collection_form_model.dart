import 'dart:convert';

class CollectionFormModel {
  String? sOrderId;
  String? documentno;
  String? bunitname;
  String? dateordered;
  String? saletypename;
  String? vehicleNumber;
  String? vehicleSize;
  String? driverName;
  int? driverNumber;
  String? isSuspense;
  String? driverNo; //added by myself because it is not in response
  int? buckets;
  double? bucketAmount;
  double? loadingCharges;
  double? tonnageAmount;
  double? companyAmount;
  double? grosstotal;
  dynamic description;
  dynamic b2ccustomername;
  double? suspense;
  List<Payment>? payments;
  String? isShipment;
  dynamic loadingTime;
  dynamic loadingBy;
  dynamic loadingRemarks;
  String? isExit;
  dynamic exitTime;
  dynamic exitBy;
  dynamic exitRemarks;

  CollectionFormModel({
    this.sOrderId,
    this.companyAmount,
    this.exitBy,
    this.isExit,
    this.payments,
    this.isSuspense,
    this.description,
    this.b2ccustomername,
    this.suspense,
    this.exitTime,
    this.tonnageAmount,
    this.loadingTime,
    this.exitRemarks,
    this.saletypename,
    this.bucketAmount,
    this.isShipment,
    this.buckets,
    this.grosstotal,
    this.loadingBy,
    this.dateordered,
    this.driverName,
    this.driverNumber,
    this.documentno,
    this.vehicleNumber,
    this.vehicleSize,
    this.loadingRemarks,
    this.loadingCharges,
    this.bunitname,
  });

  factory CollectionFormModel.fromJson(Map<String, dynamic> json) {
    return CollectionFormModel(
      sOrderId: json['s_order_id'],
      companyAmount: json['company_amount']?.toDouble(),
      exitBy: json['exit_by'],
      isExit: json['is_exit'],
      payments: json['payments'] != null
          ? List<Payment>.from(json['payments'].map((x) => Payment.fromJson(x)))
          : null,
      isSuspense: json['is_suspense'],
      description: json['description'],
      b2ccustomername: json['b2ccustomername'],
      suspense: json['suspense'],
      exitTime: json['exit_time'],
      tonnageAmount: json['tonnage_amount']?.toDouble(),
      loadingTime: json['loading_time'],
      exitRemarks: json['exit_remarks'],
      saletypename: json['saletypename'],
      bucketAmount: json['bucket_amount']?.toDouble(),
      isShipment: json['is_shipment'],
      buckets: json['buckets'],
      grosstotal: json['grosstotal']?.toDouble(),
      loadingBy: json['loading_by'],
      dateordered: json['dateordered'],
      driverName: json['driver_name'],
      driverNumber: json['driver_number'],
      documentno: json['documentno'],
      vehicleNumber: json['vehicle_number'],
      vehicleSize: json['vehicle_size'],
      loadingRemarks: json['loading_remarks'],
      loadingCharges: json['loading_charges']?.toDouble(),
      bunitname: json['bunitname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sOrderId': sOrderId,
      'company_amount': companyAmount,
      'exit_by': exitBy,
      'is_exit': isExit,
      'payments': payments?.map((e) => e.toJson()).toList(),
      'is_suspense': isSuspense,
      'description': description,
      'b2ccustomername': b2ccustomername,
      'suspense': suspense,
      'exit_time': exitTime,
      'tonnage_amount': tonnageAmount,
      'loading_time': loadingTime,
      'exit_remarks': exitRemarks,
      'saletypename': saletypename,
      'bucket_amount': bucketAmount,
      'is_shipment': isShipment,
      'buckets': buckets,
      'grosstotal': grosstotal,
      'loading_by': loadingBy,
      'dateordered': dateordered,
      'driver_name': driverName,
      'driver_number': driverNumber,
      'documentno': documentno,
      'vehicle_number': vehicleNumber,
      'vehicle_size': vehicleSize,
      'loading_remarks': loadingRemarks,
      'loading_charges': loadingCharges,
      'bunitname': bunitname,
    };
  }

  void mergeWith(CollectionFormModel other) {
    sOrderId = other.sOrderId ?? sOrderId;
    companyAmount = other.companyAmount ?? companyAmount;
    exitBy = other.exitBy ?? exitBy;
    isExit = other.isExit ?? isExit;
    payments = other.payments ?? payments;
    isSuspense = other.isSuspense ?? isSuspense;
    description = other.description ?? description;
    b2ccustomername = other.b2ccustomername ?? b2ccustomername;
    suspense = other.suspense ?? suspense;
    exitTime = other.exitTime ?? exitTime;
    tonnageAmount = other.tonnageAmount ?? tonnageAmount;
    loadingTime = other.loadingTime ?? loadingTime;
    exitRemarks = other.exitRemarks ?? exitRemarks;
    saletypename = other.saletypename ?? saletypename;
    bucketAmount = other.bucketAmount ?? bucketAmount;
    isShipment = other.isShipment ?? isShipment;
    buckets = other.buckets ?? buckets;
    grosstotal = other.grosstotal ?? grosstotal;
    loadingBy = other.loadingBy ?? loadingBy;
    dateordered = other.dateordered ?? dateordered;
    driverName = other.driverName ?? driverName;
    driverNumber = other.driverNumber ?? driverNumber;
    documentno = other.documentno ?? documentno;
    vehicleNumber = other.vehicleNumber ?? vehicleNumber;
    vehicleSize = other.vehicleSize ?? vehicleSize;
    loadingRemarks = other.loadingRemarks ?? loadingRemarks;
    loadingCharges = other.loadingCharges ?? loadingCharges;
    bunitname = other.bunitname ?? bunitname;
  }

  // Add these methods for easier serialization/deserialization
  static CollectionFormModel fromJsonString(String jsonString) =>
      CollectionFormModel.fromJson(json.decode(jsonString));

  String toJsonString() => json.encode(toJson());
}

// class Payment {
//   dynamic type;
//   dynamic amount;
//   dynamic remarks;
//   dynamic paymentMethod;
//   String? cs_bunit_id; // Add this field
//
//   Payment({
//     this.type,
//     this.amount,
//     this.remarks,
//     this.paymentMethod,
//     this.cs_bunit_id,
//   });
//
//   factory Payment.fromJson(Map<String, dynamic> json) {
//     return Payment(
//       type: json['type'],
//       amount: json['amount'],
//       remarks: json['remarks'],
//       paymentMethod: json['paymentMethod'],
//       cs_bunit_id: json['cs_bunit_id'], // Add this field
//     );
//   }
class Payment {
  String? paymentMethod;
  String? type;
  double? amount;
  String? remarks;
  String? cs_bunit_id;

  Payment({
    this.paymentMethod,
    this.type,
    this.amount,
    this.remarks,
    this.cs_bunit_id,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentMethod: json['paymentMethod'],
      type: json['type'],
      amount:
          json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      remarks: json['remarks'],
      cs_bunit_id: json['cs_bunit_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'remarks': remarks,
      'paymentMethod': paymentMethod,
      'cs_bunit_id': cs_bunit_id, // Add this field
    };
  }

  Payment copyWith({
    dynamic type,
    dynamic amount,
    dynamic remarks,
    dynamic paymentMethod,
    String? cs_bunit_id,
  }) {
    return Payment(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cs_bunit_id: cs_bunit_id ?? this.cs_bunit_id,
    );
  }
}

//it's a valid manual implementation of serialization and deserialization.
