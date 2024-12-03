import 'dart:convert';

class CollectionModelModel {
  final Data? data;

  CollectionModelModel({this.data});

  factory CollectionModelModel.fromJson(Map<String, dynamic> json) {
    return CollectionModelModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }

  static CollectionModelModel fromJsonString(String jsonString) {
    return CollectionModelModel.fromJson(json.decode(jsonString));
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}

class Data {
  final List<ExecuteAPIBuilder>? executeAPIBuilder;

  Data({this.executeAPIBuilder});

  factory Data.fromJson(Map<String, dynamic> json) {
    var executeAPIBuilderJson = json['executeAPIBuilder'];
    List<ExecuteAPIBuilder> executeAPIBuilderList = [];
    if (executeAPIBuilderJson is String) {
      executeAPIBuilderList = (jsonDecode(executeAPIBuilderJson) as List)
          .map((item) => ExecuteAPIBuilder.fromJson(item))
          .toList();
    } else if (executeAPIBuilderJson is List) {
      executeAPIBuilderList = executeAPIBuilderJson
          .map((item) => ExecuteAPIBuilder.fromJson(item))
          .toList();
    }
    return Data(executeAPIBuilder: executeAPIBuilderList);
  }

  Map<String, dynamic> toJson() {
    return {
      'executeAPIBuilder': executeAPIBuilder?.map((e) => e.toJson()).toList(),
    };
  }
}

class ExecuteAPIBuilder {
  final double? companyAmount;
  final dynamic exitBy;
  final String? isExit;
  final List<Payment>? payments;
  final String? isSuspense;
  final dynamic description;
  final dynamic b2ccustomername;
  final dynamic suspense;
  final dynamic exitTime;
  final double? tonnageAmount;
  final dynamic loadingTime;
  final dynamic exitRemarks;
  final String? saletypename;
  final double? bucketAmount;
  final String? isShipment;
  final int? buckets;
  final double? grosstotal;
  final dynamic loadingBy;
  final String? dateordered;
  final String? driverName;
  final String? documentno;
  final String? vehicleNumber;
  final String? vehicleSize;
  final dynamic loadingRemarks;
  final double? loadingCharges;
  final String? bunitname;

  ExecuteAPIBuilder({
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
    this.documentno,
    this.vehicleNumber,
    this.vehicleSize,
    this.loadingRemarks,
    this.loadingCharges,
    this.bunitname,
  });

  factory ExecuteAPIBuilder.fromJson(Map<String, dynamic> json) {
    return ExecuteAPIBuilder(
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
      'documentno': documentno,
      'vehicle_number': vehicleNumber,
      'vehicle_size': vehicleSize,
      'loading_remarks': loadingRemarks,
      'loading_charges': loadingCharges,
      'bunitname': bunitname,
    };
  }
}

class Payment {
  final dynamic type;
  final dynamic amount;
  final dynamic remarks;
  final dynamic paymentMethod;

  Payment({
    this.type,
    this.amount,
    this.remarks,
    this.paymentMethod,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      type: json['type'],
      amount: json['amount'],
      remarks: json['remarks'],
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'remarks': remarks,
      'paymentMethod': paymentMethod,
    };
  }
}
