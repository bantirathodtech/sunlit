// import 'package:common/common_widgets.dart';
//
// class CollectionRepository {
//   final ApiService apiService;
//
//   CollectionRepository({required this.apiService});
//
//   // Future<List<String>> fetchOptions(String fieldId) async {
//   //   try {
//   //     final data = {
//   //       'query': getSearchFieldQuery(
//   //         fieldId,
//   //         "7004",
//   //         "270EED9D0E7F4C43B227FEDC44C5858F",
//   //         "{}",
//   //       )
//   //     };
//   //     final queryData = json.encode(data);
//   //
//   //     final response = await apiService
//   //         .fetchGraphQLData(plgCoreGraphQlUrl, queryData, variables: {});
//   //
//   //     if (response.containsKey('errors')) {
//   //       throw Exception("GraphQL error: ${response['errors']}");
//   //     }
//   //
//   //     if (response['data']?['searchField'] != null) {
//   //       final searchField = response['data']['searchField'];
//   //       final jsonData =
//   //           searchField is String ? json.decode(searchField) : searchField;
//   //
//   //       if (jsonData['searchData'] is List) {
//   //         final options = (jsonData['searchData'] as List)
//   //             .map((data) => data['Name']?.toString() ?? '')
//   //             .where((option) => option.isNotEmpty)
//   //             .toList();
//   //         return options;
//   //       }
//   //     }
//   //
//   //     return [];
//   //   } catch (e) {
//   //     print('Error fetching options: $e');
//   //     rethrow;
//   //   }
//   // }
//
//   Future<List<String>> fetchOptions(String fieldId) async {
//     try {
//       final query = getSearchFieldQuery(
//           fieldId, "7004", "270EED9D0E7F4C43B227FEDC44C5858F", "{}");
//
//       final response = await apiService.fetchGraphQLData(
//         plgCoreGraphQlUrl,
//         {'query': query},
//         variables: {},
//       );
//
//       if (response.containsKey('errors')) {
//         throw Exception("GraphQL error: ${response['errors']}");
//       }
//
//       if (response['data']?['searchField'] != null) {
//         dynamic searchField = response['data']['searchField'];
//         Map<String, dynamic> jsonData;
//
//         if (searchField is String) {
//           jsonData = json.decode(searchField);
//         } else if (searchField is Map<String, dynamic>) {
//           jsonData = searchField;
//         } else {
//           throw Exception(
//               "Unexpected searchField type: ${searchField.runtimeType}");
//         }
//
//         if (jsonData['searchData'] is List) {
//           final options = (jsonData['searchData'] as List)
//               .map((data) => data['Name']?.toString() ?? '')
//               .where((option) => option.isNotEmpty)
//               .toList();
//           return options;
//         } else {
//           throw Exception(
//               "searchData is not a List: ${jsonData['searchData']}");
//         }
//       } else {
//         throw Exception("No searchField data in response");
//       }
//     } catch (e) {
//       print('Error fetching options: $e');
//       rethrow;
//     }
//   }
// }
/////above is backup for oldest version
// import 'package:common/common_widgets.dart';
//
// class CollectionRepository {
//   final ApiService apiService;
//   // final CollectionService collectionService;
//
//   CollectionRepository({
//     required this.apiService,
//     // required this.collectionService,
//   });
//
//   Future<List<String>> fetchOptions(String fieldId) async {
//     try {
//       final query = getSearchFieldQuery(
//           fieldId, "7004", "270EED9D0E7F4C43B227FEDC44C5858F", "{}");
//       print("Original service request: for field $fieldId:"); // Log the request
//       print("Endpoint: $plgCoreGraphQlUrl");
//       print("Query: $query");
//
//       final response = await apiService.fetchGraphQLData(
//         plgCoreGraphQlUrl,
//         {'query': query},
//         variables: {},
//       );
//
//       print("Dropdown options response: $response"); // Log the response
//
//       if (response['data']?['searchField'] != null) {
//         dynamic searchField = response['data']['searchField'];
//         Map<String, dynamic> jsonData =
//             searchField is String ? json.decode(searchField) : searchField;
//
//         if (jsonData['searchData'] is List) {
//           return (jsonData['searchData'] as List)
//               .map((data) => data['Name']?.toString() ?? '')
//               .where((option) => option.isNotEmpty)
//               .toList();
//         }
//       }
//       return [];
//     } catch (e) {
//       print('Error fetching options: $e');
//       print('Error fetching options for field $fieldId: $e');
//       return [];
//     }
//   }
//
//   Future<UpsertCollectionModel> upsertCollectionForm(
//     CollectionFormModel formData,
//     Map<String, dynamic>? userData,
//     // CollectionFormModel collectionFormModel,
//   ) async {
//     final mutation = postCollectionOrdersQuery(
//       formData,
//       formData.payments ?? [],
//
//       // userData,
//       // collectionFormModel.payments?.map((p) => p.toJson()).toList() ?? [],
//       // formData.loadingTime ?? '',
//       // formData.exitTime ?? '',
//     );
//
//     print("Collection Form Data before upsert: ${formData.toJson()}");
//     print("Upsert collection form request: $mutation");
//
//     final response = await apiService
//         .fetchGraphQLData(plgGraphQlUrl, {'query': mutation}, variables: {});
//
//     print("Upsert collection form response: $response"); // Log the response
//
//     if (response['data']?['upsertCollectionOrders'] != null) {
//       return UpsertCollectionModel.fromJson(
//           response['data']['upsertCollectionOrders']);
//     }
//     throw Exception('Failed to upsert collection form');
//   }
//
//   Future<CollectionFormModel?> getCollectionOrders(String sOrderId) async {
//     final mutation = getCollectionOrdersQuery(sOrderId);
//     final response = await apiService
//         .fetchGraphQLData(plgGraphQlUrl, {'mutation': mutation}, variables: {});
//
//     if (response['data']?['executeAPIBuilder'] != null) {
//       final jsonString = response['data']['executeAPIBuilder'] as String;
//       final models =
//           CollectionFormModel.getCollectionFormModelsFromJson(jsonString);
//       return models.isNotEmpty ? models.first : null;
//     }
//     return null;
//   }
//
//   ///taken from chandu's code for understanding
//   // Future<dynamic> sendCollectionForm(String endPoint, var jsonBody) async {
//   //   try {
//   //     return await collectionService.sendCollectionForm(endPoint, jsonBody);
//   //   } catch (e) {
//   //     printMessage("error00...$e");
//   //     throw Exception('$e');
//   //   }
//   // }
// }
/////above is backup for oldest version
import 'dart:developer' as dev;

import '../../../smine_widgets.dart';

class CollectionRepository {
  final CollectionService _collectionService;

  CollectionRepository({required CollectionService collectionService})
      : _collectionService = collectionService;

  Future<Map<String, List<String>>> fetchDropdownOptions() async {
    try {
      dev.log('Fetching dropdown options from repository',
          name: 'CollectionRepository');
      return await _collectionService.fetchAllFieldOptions();
    } catch (e) {
      dev.log('Error fetching dropdown options: $e',
          name: 'CollectionRepository');
      rethrow;
    }
  }

  Future<UpsertCollectionModel> upsertCollectionForm(
    CollectionFormModel formData,
    Map<String, dynamic>? userData,
    String? userBunitId,
    String? userId,
  ) async {
    try {
      dev.log('Upserting collection form from repository',
          name: 'CollectionRepository');
      return await _collectionService.upsertCollectionForm(
          formData, userData, userBunitId!, userId!);
    } catch (e) {
      dev.log('Error upserting collection form: $e',
          name: 'CollectionRepository');
      rethrow;
    }
  }

  Future<CollectionFormModel?> getCollectionOrders(String sOrderId) async {
    try {
      dev.log('Fetching collection orders from repository',
          name: 'CollectionRepository');
      return await _collectionService.getCollectionOrders(sOrderId);
    } catch (e) {
      dev.log('Error fetching collection orders: $e',
          name: 'CollectionRepository');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getBucketRate(String csBunitId) async {
    print(
        'CollectionRepository: Getting bucket rate for csBunitId: $csBunitId');
    try {
      final result = await _collectionService.fetchBucketRate(csBunitId);
      print('CollectionRepository: Received bucket rate data: $result');
      return result;
    } catch (e) {
      print('CollectionRepository: Error getting bucket rate: $e');
      rethrow;
    }
  }
}
