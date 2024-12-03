import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

class CollectionService {
  final ApiService _apiService;

  CollectionService({required ApiService apiService})
      : _apiService = apiService;

  // Fetch dropdown options
  Future<Map<String, List<String>>> fetchAllFieldOptions() async {
    Map<String, List<String>> allOptions = {};
    for (String fieldName
        in CollectionFormFieldIds.collectionFormFieldId.keys) {
      String fieldId =
          CollectionFormFieldIds.getCollectionFormFieldId(fieldName);
      List<String> options = await fetchOptions(fieldId);
      if (options.isNotEmpty) {
        allOptions[fieldName] = options;
      }
    }
    dev.log('Fetched dropdown options: $allOptions', name: 'CollectionService');
    return allOptions;
  }

  Future<List<String>> fetchOptions(String fieldId) async {
    try {
      final query = getSearchFieldQuery(
          fieldId, "7004", "270EED9D0E7F4C43B227FEDC44C5858F", "{}");
      final response = await _apiService.commonEntTaskData(
          plgCoreGraphQlUrl, {'query': query}, accessToken);

      if (response['data']?['searchField'] != null) {
        dynamic searchField = response['data']['searchField'];
        Map<String, dynamic> jsonData =
            searchField is String ? json.decode(searchField) : searchField;

        if (jsonData['searchData'] is List) {
          return (jsonData['searchData'] as List)
              .map((data) => data['Name']?.toString() ?? '')
              .where((option) => option.isNotEmpty)
              .toList();
        }
      }
      return [];
    } catch (e) {
      dev.log('Error fetching options for field $fieldId: $e',
          name: 'CollectionService');
      return [];
    }
  }

  // Upsert collection form
  // Updated upsert collection form method
  Future<UpsertCollectionModel> upsertCollectionForm(
    CollectionFormModel formData,
    Map<String, dynamic>? userData,
    String userBunitId,
    String userId,
  ) async {
    try {
      dev.log('Upserting collection form', name: 'CollectionService');
      dev.log('Form data: ${formData.toJsonString()}',
          name: 'CollectionService');
      dev.log('User data: ${json.encode(userData)}', name: 'CollectionService');

      final mutation = postCollectionOrdersQuery(
        formData,
        userBunitId,
        userId,
      );

      dev.log('Mutation: $mutation', name: 'CollectionService');

      final response = await _apiService.commonEntTaskData(
          plgGraphQlUrl, {'query': mutation}, accessToken);

      dev.log('Raw API response: ${json.encode(response)}',
          name: 'CollectionService');

      // if (response['data']?['upsertCollectionOrders'] != null) {
      //   final upsertResult = response['data']['upsertCollectionOrders'];
      //
      //   return UpsertCollectionModel.fromJson(upsertResult);
      // } else {
      //   throw Exception(
      //       'Unexpected response structure: ${json.encode(response)}');
      // }
      if (response['data'] != null) {
        return UpsertCollectionModel.fromJson(response);
      } else {
        throw Exception(
            'Unexpected response structure: ${json.encode(response)}');
      }
    } catch (e) {
      dev.log('Error in upsertCollectionForm: $e', name: 'CollectionService');
      if (e is TypeError) {
        dev.log('Type error details: ${e.stackTrace}',
            name: 'CollectionService');
      }
      rethrow;
    }
  }

  ///In the upsertCollectionForm() method, it's creating an UpsertCollectionModel from the API response.

  // Fetch collection order data
  // Updated fetch collection order data method
  Future<CollectionFormModel?> getCollectionOrders(String sOrderId) async {
    try {
      dev.log('Fetching collection order for sOrderId: $sOrderId',
          name: 'CollectionService');
      final mutation = getCollectionOrdersQuery(sOrderId);
      dev.log('Mutation: $mutation', name: 'CollectionService');

      final variables = {
        "apiBuilderId": "6686a3a82a8ac0478327c457",
        "params": json.encode({"s_order_id": sOrderId})
      };

      final response = await _apiService.sendGraphQLRequest(
        plgCoreGraphQlUrl,
        {'mutation': mutation},
        variables: variables,
      );
      dev.log('Fetch response: $response', name: 'CollectionService');

      if (response['data']?['executeAPIBuilder'] != null) {
        final jsonString = response['data']['executeAPIBuilder'] as String;
        final jsonData = json.decode(jsonString);
        if (jsonData is List && jsonData.isNotEmpty) {
          return CollectionFormModel.fromJson(jsonData[0]);
        }
      }
      return null;
    } catch (e) {
      dev.log('Error in getCollectionOrders: $e', name: 'CollectionService');
      if (e is DioException) {
        dev.log('DioException details: ${e.response?.data}',
            name: 'CollectionService');
      }
      rethrow;
    }
  }

  //TODO: to get the rates dynamically from backends
  Future<Map<String, dynamic>> fetchBucketRate(String csBunitId) async {
    print('CollectionService: Fetching bucket rate for csBunitId: $csBunitId');
    try {
      final query = getBucketRateQuery(csBunitId);
      print('CollectionService: Bucket rate query: $query');
      final response = await _apiService.commonEntTaskData(
          plgCoreGraphQlUrl, {'query': query}, accessToken);
      print('CollectionService: Raw response: $response');

      if (response['data']?['executeAPIBuilder'] != null) {
        final jsonString = response['data']['executeAPIBuilder'] as String;
        final decodedData = json.decode(jsonString) as List<dynamic>;
        if (decodedData.isNotEmpty) {
          final firstItem = decodedData[0] as Map<String, dynamic>;
          print('CollectionService: Decoded bucket rate data: $firstItem');
          return {
            'rate': firstItem['bucket_amount'] ?? 0.0,
            'qty': firstItem['bucket_qty'] ?? 0,
          };
        }
      }
      throw Exception('No data returned from bucket rate query');
    } catch (e) {
      print('CollectionService: Error fetching bucket rate: $e');
      rethrow;
    }
  }
}
