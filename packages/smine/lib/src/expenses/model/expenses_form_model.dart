/// expense_form_model.dart
/// Defines the data structure for the expense form

import 'dart:convert';

ExpenseFormModel expenseFormModelFromJson(String str) =>
    ExpenseFormModel.fromJson(json.decode(str));

String expenseFormModelToJson(ExpenseFormModel expenseFormModel) =>
    json.encode(expenseFormModel.toJson());

List<ExpenseFormModel> getExpenseFormModelsFromJson(String str) =>
    List<ExpenseFormModel>.from(
        json.decode(str).map((x) => ExpenseFormModel.fromJson(x)));

String getExpenseFormModelsToJson(List<ExpenseFormModel> dataList) =>
    json.encode(List<dynamic>.from(dataList.map((x) => x.toJson())));

class ExpenseFormModel {
  String? bunitId;
  String? clientId;
  String? finaccountId;
  String? documentNo;
  String? location;
  // String? locationName; // Changed from 'location' to 'locationName'

  String? date;
  String? name;
  String? transactionType;
  String? payment;
  // double? payment; // Changed from 'String?' to 'double?'

  String? sourceAccount;
  String? description;
  String? businessHead;
  String? expenseHead;
  String? status;
  String? suspense;
  String? createdBy;
  String? updatedBy;

  ExpenseFormModel({
    this.bunitId,
    this.clientId,
    this.finaccountId,
    this.documentNo,
    this.location,
    // this.locationName, // Changed from 'location' to 'locationName'

    this.date,
    this.name,
    this.transactionType,
    this.payment,
    this.sourceAccount,
    this.description,
    this.businessHead,
    this.expenseHead,
    this.status,
    this.suspense,
    this.createdBy,
    this.updatedBy,
  });

  factory ExpenseFormModel.fromJson(Map<String, dynamic> json) {
    return ExpenseFormModel(
      bunitId: json['bunitId']?.toString(),
      clientId: json['clientId']?.toString(),
      finaccountId: json['finaccountId']?.toString(),
      documentNo: json['documentNo']?.toString(),
      location: json['location']?.toString(),
      // locationName: json['locationName']
      //     ?.toString(), // Changed from 'location' to 'locationName'

      date: json['date']?.toString(),
      name: json['name']?.toString(),
      transactionType: json['transactionType']?.toString(),
      // payment: json['payment']?.toString(),
      payment: json['payment']
          ?.toDouble(), // Changed from 'toString()' to 'toDouble()'

      sourceAccount: json['sourceAccount']?.toString(),
      description: json['description']?.toString(),
      businessHead: json['businessHead']?.toString(),
      expenseHead: json['expenseHead']?.toString(),
      status: json['status']?.toString(),
      suspense: json['suspense']?.toString(),
      createdBy: json['createdBy']?.toString(),
      updatedBy: json['updatedBy']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bunitId': bunitId,
      'clientId': clientId,
      'finaccountId': finaccountId,
      'documentNo': documentNo,
      'location': location,
      // 'locationName': locationName, // Changed from 'location' to 'locationName'

      'date': date,
      'name': name,
      'transactionType': transactionType,
      'payment': payment,
      'sourceAccount': sourceAccount,
      'description': description,
      'businessHead': businessHead,
      'expenseHead': expenseHead,
      'status': status,
      'suspense': suspense,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }
}
