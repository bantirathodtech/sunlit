// filename: fields_utils.dart

class FieldIds {
  static const Map<String, String> fieldId = {
    'reachName': '3AF49A63FFC849F298546685226A9B7C',
    'transactionDate': '07FCAADB108745489D2D0004362A1ACF',
    'typeOfDispatch': '27CF67E795E24673BD2786A93B65D3FC',
    'vehicleSize': '3AF49A63FFC849F298546685226A9B7C',
    'creditorName': '2EC7DEC4A85144F3AB6A70E8AF7335C4',
    'paymentMethod': '07FCAADB108745489D2D0004362A1ACF',
    'location': '10258BD823F64C0EB5FAFFA950B7D849',
    'date': '10258BD823F64C0EB5FAFFA950B7D849',
    'transactionType': 'E54FB9D7EBD745A7956F909685223DC0',
    'sourceAccount': '841470DE02624B90A7BC7BA43A590E47',
    'businessHead': '301DFA89CBC84CED90CC4A9B251F1AD9',
    'expenseHead': '5B2EA18000004700956FEC78912F40F0',
    // 'loadingBy': '43BF2CC0AB8C44E7A17FB5BDF3BD3D9B',
    // 'exitBy': '43BF2CC0AB8C44E7A17FB5BDF3BD3D9B',
  };

  static String getFieldId(String fieldName) {
    return fieldId[fieldName] ?? '';
  }
}

// class WindowIds {
//   static const Map<String, String> windowIds = {
//     'collection': '7004',
//     'express': '7288',
//   };
//
//   static String getWindowId(String windowName) {
//     return windowIds[windowName] ?? '';
//   }
// }

class CollectionFormFieldIds {
  static const Map<String, String> collectionFormFieldId = {
    ///entry
    'reachName': '3AF49A63FFC849F298546685226A9B7C',
    'transactionDate': '07FCAADB108745489D2D0004362A1ACF',
    'typeOfDispatch': '27CF67E795E24673BD2786A93B65D3FC',
    'vehicleNumber': '3AF49A63FFC849F298546685226A9B7C',
    'vehicleSize': '270EED9D0E7F4C43B227FEDC44C5858F',
    'driverName': '3AF49A63FFC849F298546685226A9B7C',
    'driverNumber': '3AF49A63FFC849F298546685226A9B7C',

    ///payment
    'buckets': '3AF49A63FFC849F298546685226A9B7C',
    'bucketsAmount': '3AF49A63FFC849F298546685226A9B7C',
    'loadingCharges': '3AF49A63FFC849F298546685226A9B7C',
    'tonnageAmount': '3AF49A63FFC849F298546685226A9B7C',
    'companyAmount': '3AF49A63FFC849F298546685226A9B7C',
    // 'credit': '3AF49A63FFC849F298546685226A9B7C',
    'totalCollection': '3AF49A63FFC849F298546685226A9B7C',
    // 'partnerCredit': '3AF49A63FFC849F298546685226A9B7C',
    'creditorName': '2EC7DEC4A85144F3AB6A70E8AF7335C4',
    'suspense': '3AF49A63FFC849F298546685226A9B7C',
    // 'freeOfCost': '3AF49A63FFC849F298546685226A9B7C',
    'paymentMethod': '07FCAADB108745489D2D0004362A1ACF',
    'comments': '27CF67E795E24673BD2786A93B65D3FC',
    // 'loadingBy': '43BF2CC0AB8C44E7A17FB5BDF3BD3D9B',
    // 'exitBy': '43BF2CC0AB8C44E7A17FB5BDF3BD3D9B',
    'type': 'A38D6D5CC1184C6990BE68D7FAD37CE4',
    // 'loadingTime': '',
    // 'loadingRemarks': '',
    // 'exitTime': '',
    // 'exitRemarks': '',
  };
  static String getCollectionFormFieldId(String fieldName) {
    return collectionFormFieldId[fieldName] ?? '';
  }
}

///Expenses fields ids for dropdown options fetching from service
class ExpenseFormFieldIds {
  static const Map<String, String> expenseFormFieldId = {
    'location': '10258BD823F64C0EB5FAFFA950B7D849',
    'date': '10258BD823F64C0EB5FAFFA950B7D849',
    // 'name': '3AF49A63FFC849F298546685226A9B7C',
    'transactionType': 'E54FB9D7EBD745A7956F909685223DC0',
    // 'payment': '10258BD823F64C0EB5FAFFA950B7D849',
    'sourceAccount': '841470DE02624B90A7BC7BA43A590E47',
    // 'description': '3AF49A63FFC849F298546685226A9B7C',
    'businessHead': '301DFA89CBC84CED90CC4A9B251F1AD9',
    'expenseHead': '5B2EA18000004700956FEC78912F40F0',
  };
  static String getExpenseFormFieldId(String fieldName) {
    return expenseFormFieldId[fieldName] ?? '';
  }
}
