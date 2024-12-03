// filename: expense_api_response_model.dart

class ExpenseVoucherResult {
  final String code;
  final String message;

  ExpenseVoucherResult({
    required this.code,
    required this.message,
  });

  factory ExpenseVoucherResult.fromJson(Map<String, dynamic> json) {
    return ExpenseVoucherResult(
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}

class ExpenseVoucherResponse {
  final ExpenseVoucherResult upsertExpenseVouchers;

  ExpenseVoucherResponse({
    required this.upsertExpenseVouchers,
  });

  factory ExpenseVoucherResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseVoucherResponse(
      upsertExpenseVouchers:
          ExpenseVoucherResult.fromJson(json['upsertExpenseVouchers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'upsertExpenseVouchers': upsertExpenseVouchers.toJson(),
    };
  }
}

class ApiResponse {
  final ExpenseVoucherResponse data;

  ApiResponse({
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      data: ExpenseVoucherResponse.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}
