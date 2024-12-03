import 'dart:developer' as dev;

import '../../common_widgets.dart';

///Global params for the application - Query to get user information- (updated - don't touch anytime)         global params
String getUserInfo() {
  dev.log('Fetching user info query', name: 'GraphQLQueries');
  return '''
      query {
        getGlobalParameters
      }
    ''';
}

String getSearchFieldQuery(
    String fieldId, String windowId, String adTabId, String headerParams) {
  return '''
    query SearchField {
      searchField(
        windowId: "$windowId",
        ad_tab_id: "$adTabId",
        ad_field_id: "$fieldId",
        searchField: "",
        dependent: null,
        param: null,
        headerId: "NEW_RECORD"
      )
    }
  ''';
}

String getCollectionOrdersQuery(String sOrderId) {
  dev.log('Fetching collection orders query for sOrderId: $sOrderId',
      name: 'GraphQLQueries');
  return '''
    mutation ExecuteAPIBuilder(\$apiBuilderId: String!, \$params: String!) {
      executeAPIBuilder(apiBuilderId: \$apiBuilderId, params: \$params)
    }
  ''';
}

///fetching expenses fields dropdowns (updated - don't touch now)                  fetching expense fields
String generateExpenseFieldOptionsQuery(
    String fieldId, String windowId, String adTabId, String headerParams) {
  dev.log('Fetching search field query for fieldId: $fieldId',
      name: 'GraphQLQueries');
  return '''
      query {
        searchField(
          windowId: "7288",
          ad_tab_id: "C1C1DF4992164B079E4B63BF93F9A35D",
          ad_field_id: "$fieldId",
          searchField: "",
          dependent: null,
          param: ${json.encode(headerParams)},
          headerId: "NEW_RECORD"
        )
      }
    ''';
}

/// Sending expenses form records to the server (updated - don't touch now)     //Sending expense records
Map<String, dynamic> generateUpsertExpenseMutation(
  ExpenseFormModel formData,
  Map<String, dynamic>? userData,
) {
  print('Generating postExpenseFormRecordQuery');
  print('Form data: ${formData.toJson()}');
  print('User data: $userData');

  final variables = {
    "vouchers": [
      {
        "bunitId": userData?['default_cs_bunit_id'] ??
            "C530054AEBE448E5A38D2415C1C0907D",
        "clientId": "3CF003E557704269AFF00463F1F452E8",
        "finaccountId": "82FE066DDA724B99ACA10CA303BEAC51",
        "documentNo": "DOC${DateTime.now().millisecondsSinceEpoch}",
        "locationName": formData.location ?? '',
        "date": formData.date ?? DateTime.now().toIso8601String().split('T')[0],
        "name": formData.name ?? '',
        "status": "DR",
        "transactionType": formData.transactionType ?? "Expense",
        "payment": double.tryParse(formData.payment ?? '') ?? 0.0,
        "sourceAccount": formData.sourceAccount ?? '',
        "description": formData.description ?? '',
        "suspense": "N",
        "businessHead": formData.businessHead ?? '',
        "expenseHead": formData.expenseHead ?? '',
        "createdBy": userData?['cs_user_id'] ?? '',
        "updatedBy": userData?['cs_user_id'] ?? ''
      }
    ]
  };

  const query = '''
  mutation UpsertExpenseVouchers(\$vouchers: [ExpenseVoucherInput!]!) {
    upsertExpenseVouchers(vouchers: \$vouchers) {
      code
      message
    }
  }
  ''';

  return {
    'query': query,
    'variables': variables,
  };
}

/// User ID data query (updated - don't touch now)                              //getting user ID data
String getUserIdDataQuery(String userId) {
  dev.log('Fetching user ID data query for userId: $userId',
      name: 'GraphQLQueries');
  return "mutation{executeAPIBuilder(apiBuilderId:\"668785ea2a8ac0478327c459\", "
      "params: \"{\\\"user_id\\\":\\\"$userId\\\"}\")}";
}

String getBucketRateQuery(String csBunitId) {
  dev.log('Fetching bucket rate data query for csBunitId: $csBunitId',
      name: 'GraphQLQueries');
  return "mutation { executeAPIBuilder(apiBuilderId: \"66a778f42a8ac0478327c4cf\", params: \"{\\\"cs_bunit_id\\\":\\\"$csBunitId\\\"}\") }";
}

///last query request - Mutation to post collection ordersAPI
String postCollectionOrdersQuery(
    CollectionFormModel formData, String userBunitId, String userId) {
  dev.log('Posting collection orders query', name: 'GraphQLQueries');
  dev.log('Form Data: ${formData.toJson()}', name: 'GraphQLQueries');

  return '''
    mutation {
      upsertCollectionOrders(orders: [
        {
          bunitId: ${_nullableString(userBunitId)},
          sorderId: ${_nullableString(formData.sOrderId)},
          doctypeId: ${_nullableString("AF8B1736C4D6487A89C36DC897096890")},
          customerId: ${_nullableString("59816A8FC04B41CBB84500AEA9763767")},
          documentNo: ${_nullableString(formData.documentno)},
          reachName: ${_nullableString(formData.bunitname)},
          transactionDate: ${_nullableString(formData.dateordered)},
          typeOfDispatch: ${_nullableString(formData.saletypename)},
          vehicleNumber: ${_nullableString(formData.vehicleNumber)},
          vehicleSize: ${_nullableString(formData.vehicleSize)},
          driverName: ${_nullableString(formData.driverName)},
          driverNumber: ${formData.driverNumber != null ? formData.driverNumber.toString() : "null"},
          buckets: ${formData.buckets ?? 0},
          bucketAmount: ${formData.bucketAmount ?? 0},
          loadingCharges: ${formData.loadingCharges ?? 0},
          tonnageAmount: ${formData.tonnageAmount ?? 0},
          companyAmount: ${formData.companyAmount ?? 0},
          totalCollection: ${formData.grosstotal ?? 0},
          creditorName: ${_nullableString(formData.b2ccustomername)},
          suspenseAmount: ${formData.suspense ?? 0},
          suspense: ${_nullableString(formData.isSuspense ?? "N")},
          comments: ${_nullableString(formData.description)},
          shipment: ${_nullableString(formData.isShipment ?? "N")},
          loadingTime: ${_nullableString(formData.loadingTime)},
          loadingBy: ${_nullableString(formData.loadingBy)},
          loadingRemarks: ${_nullableString(formData.loadingRemarks)},
          exit: ${_nullableString(formData.isExit ?? "N")},
          exitTime: ${_nullableString(formData.exitTime)},
          exitBy: ${_nullableString(formData.exitBy)},
          exitRemarks: ${_nullableString(formData.exitRemarks)},
          payments: [
            ${formData.payments?.map((payment) => '''
              {
                bunitID: ${_nullableString("14C7046E60164A55ADA464BEE4F14053")},
                updateBy: ${_nullableString("5D3FB240E8484E9E9E08EDEC8ADCE2DB")},
                paymentMethod: ${_nullableString(payment.paymentMethod ?? "")},
                type: ${_nullableString(payment.type ?? "")},
                amount: ${payment.amount ?? "null"},
                remarks: ${_nullableString(payment.remarks ?? "NA")}
              }
            ''').join(',') ?? ''}
          ]
        }
      ]) {
        code
        message
      }
    }
  ''';
}

String _nullableString(String? value) {
  return value != null ? '"$value"' : "null";
}

String _nullableInt(int? value) {
  return value != null ? "$value" : "null";
}

//                cs_bunit_id: "${payment.cs_bunit_id}"  // Add this line
//                cs_bunit_id: "$userBunitId"
//          exitTime: ${formData.exitTime != null ? '"${formData.exitTime}"' : null},
//          loadingTime: ${formData.loadingTime != null ? '"${formData.loadingTime}"' : null},
//          exitTime: "${currentDateTime()}",
//          loadingTime: "$formattedDateTime",
//          driverNo: ${_nullableString(formData.driverNo)},
