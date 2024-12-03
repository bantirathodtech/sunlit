import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

class LoginRepository {
  final ApiService apiService;
  // final LocalDB localDB;

  LoginRepository({
    required this.apiService,
    // required this.localDB,
  });

  Future<Map<String, dynamic>> getPlgLoginData(
      String userName, String password) async {
    dev.log('Authenticating user', name: 'LoginRepository');
    try {
      var data = {
        'username': userName,
        'password': password,
      };
      return await apiService.sendLoginRequest(plgAuthUrl, data);
    } catch (e) {
      throw Exception('Failed to fetch access token');
    }
  }

  Future<dynamic> getUserData(var data, AccessToken accessToken) async {
    try {
      return await apiService.commonEntTaskData(
          plgCoreGraphQlUrl, data, accessToken);
    } catch (e) {
      throw Exception('Failed to fetch user info');
    }
  }
}
