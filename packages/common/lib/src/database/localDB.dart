//filename: localDB.dart
import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// AccessToken oldToken = AccessToken();
AccessToken accessToken = AccessToken();
UserInfo userInfo = UserInfo();
UserIdData userIdData = UserIdData();
String firebaseToken = "";

// // String firebaseToken = "";
const String ACCESS_TOKEN_KEY = 'accessToken';
const String USER_INFO_KEY = 'userInfo';
const String USER_ID_DATA_KEY = 'userIdData';
const String DROPDOWN_OPTIONS_PREFIX = 'dropdownOptions_';

void saveUserToken(AccessToken accessToken) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('accessToken', accessTokenToJson(accessToken));
}

// Save user data
Future<void> saveUserData(AccessToken? accessToken, UserInfo? userInfo,
    UserIdData? userIdData) async {
  dev.log('Saving user data to local storage', name: 'LocalDB');
  final prefs = await SharedPreferences.getInstance();

  if (accessToken != null) {
    try {
      await prefs.setString(
          ACCESS_TOKEN_KEY, json.encode(accessToken.toJson()));
      dev.log('Access token saved successfully', name: 'LocalDB');
      dev.log('Stored Access Token: ${accessToken.toJson()}', name: 'LocalDB');
    } catch (e) {
      dev.log('Error saving user info: $e', name: 'LocalDB');
      rethrow; // Rethrow the exception
    }
  } else {
    dev.log('Access token is null, skipping save', name: 'LocalDB');
  }

  if (userInfo != null) {
    try {
      await prefs.setString(USER_INFO_KEY, json.encode(userInfo.toJson()));
      dev.log('User info saved successfully', name: 'LocalDB');
    } catch (e) {
      dev.log('Error saving user info: $e', name: 'LocalDB');
      dev.log('Stored User Info: ${userInfo.toJson()}', name: 'LocalDB');
      rethrow;
    }
  } else {
    dev.log('User info is null, skipping save', name: 'LocalDB');
  }
  if (userIdData != null) {
    try {
      await prefs.setString(USER_ID_DATA_KEY, json.encode(userIdData.toJson()));
      dev.log('User info saved successfully', name: 'LocalDB');
    } catch (e) {
      dev.log('Error saving user info: $e', name: 'LocalDB');
      dev.log('Stored User Info: ${userIdData.toJson()}', name: 'LocalDB');
      rethrow;
    }
  } else {
    dev.log('User info is null, skipping save', name: 'LocalDB');
  }
  // to save the login state
  await prefs.setBool('isLoggedIn', true);
}

// Check if user is logged in  //added for auto login
Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

// Load saved data
Future<AccessToken?> loadAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final accessTokenString = prefs.getString(ACCESS_TOKEN_KEY);
  if (accessTokenString != null) {
    return AccessToken.fromJson(json.decode(accessTokenString));
  }
  return null;
}
//added for auto login

Future<UserInfo?> loadUserInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final userInfoString = prefs.getString(USER_INFO_KEY);
  if (userInfoString != null) {
    return UserInfo.fromJson(json.decode(userInfoString));
  }
  return null;
}
//added for auto login

Future<UserIdData?> loadUserIdData() async {
  final prefs = await SharedPreferences.getInstance();
  final userIdDataString = prefs.getString(USER_ID_DATA_KEY);
  if (userIdDataString != null) {
    return UserIdData.fromJson(json.decode(userIdDataString));
  }
  return null;
}

// Clear user data  //added for auto login
Future<void> clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(ACCESS_TOKEN_KEY);
  await prefs.remove(USER_INFO_KEY);
  await prefs.remove(USER_ID_DATA_KEY);
  await prefs.remove('isLoggedIn');
}

// Future<void> saveUserIdData(Map<String, dynamic> userIdData) async {
//   dev.log('Saving user ID data to local storage', name: 'LocalDB');
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString(USER_ID_DATA_KEY, json.encode(userIdData));
// }
//
// Future<Map<String, dynamic>?> loadUserIdData() async {
//   dev.log('Loading user ID data from local storage', name: 'LocalDB');
//   final prefs = await SharedPreferences.getInstance();
//   final userIdDataString = prefs.getString(USER_ID_DATA_KEY);
//   if (userIdDataString != null) {
//     dev.log('User ID data found in local storage', name: 'LocalDB');
//     return json.decode(userIdDataString);
//   }
//   dev.log('No user ID data found in local storage', name: 'LocalDB');
//   return null;
// }

// Future<void> storeUserIdDataFromRepository(
//     Map<String, dynamic> userData) async {
//   try {
//     dev.log('Storing user ID data to local storage', name: 'LocalDB');
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(USER_ID_DATA_KEY, json.encode(userData));
//     dev.log('Stored User ID Data: $userData', name: 'LocalDB');
//   } catch (e) {
//     dev.log('Error storing user ID data: $e', name: 'LocalDB');
//     rethrow;
//   }
// }
//
// Future<Map<String, dynamic>> retrieveUserIdDataForRepository() async {
//   try {
//     dev.log('Retrieving user ID data from local storage', name: 'LocalDB');
//     final prefs = await SharedPreferences.getInstance();
//     final userDataString = prefs.getString(USER_ID_DATA_KEY);
//     if (userDataString != null) {
//       return json.decode(userDataString);
//     }
//     throw Exception('No user ID data found in local storage');
//   } catch (e) {
//     dev.log('Error retrieving user ID data: $e', name: 'LocalDB');
//     rethrow;
//   }
// }

// Future<Map<String, dynamic>> checkingUserInfo() async {
//   dev.log('Checking user info', name: 'LocalDB');
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? accessTokenValue = prefs.getString(ACCESS_TOKEN_KEY);
//   String? userInfoValue = prefs.getString(USER_INFO_KEY);
//   String? userIdDataValue = prefs.getString(USER_ID_DATA_KEY);
//
//   Map<String, dynamic> result = {
//     'isLoggedIn': false,
//     'accessToken': null,
//     'userInfo': null,
//     'userIdData': null,
//   };
//
//   if (accessTokenValue != null &&
//       accessTokenValue.trim().isNotEmpty &&
//       userInfoValue != null &&
//       userInfoValue.trim().isNotEmpty) {
//     dev.log('Access token and user info found', name: 'LocalDB');
//     AccessToken accessToken = accessTokenFromJson(accessTokenValue);
//     UserInfo userInfo = userInfoFromJson(userInfoValue);
//
//     result['isLoggedIn'] = true;
//     result['accessToken'] = accessToken;
//     result['userInfo'] = userInfo;
//
//     AppUrls.setURL(accessToken.webAuth == true ? 0 : 1);
//   } else {
//     dev.log('Access token or user info not found', name: 'LocalDB');
//   }
//
//   if (userIdDataValue != null && userIdDataValue.trim().isNotEmpty) {
//     Map<String, dynamic> userIdData = json.decode(userIdDataValue);
//     dev.log('UserIdData found: $userIdData', name: 'LocalDB');
//     result['userIdData'] = userIdData;
//   } else {
//     dev.log('No UserIdData found', name: 'LocalDB');
//   }
//
//   return result;
// }
///by Chandu given
checkingUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessTokenValue = prefs.getString(ACCESS_TOKEN_KEY);
  String? userInfoValue = prefs.getString(USER_INFO_KEY);
  String? userIdDataValue = prefs.getString(USER_ID_DATA_KEY);

  if (accessTokenValue != null &&
      accessTokenValue.trim().isNotEmpty &&
      userInfoValue != null &&
      userInfoValue.trim().isNotEmpty &&
      userIdDataValue != null &&
      userIdDataValue.trim().isNotEmpty) {
    printMessage(accessTokenValue.toString());
    printMessage(userInfoValue.toString());
    printMessage(userIdDataValue.toString());

    accessToken = accessTokenFromJson(accessTokenValue);
    userInfo = userInfoFromJson(userInfoValue);
    // userIdData = json.decode(userIdDataValue);
    userIdData = UserIdData.fromJson(json.decode(userIdDataValue));

    // if (accessToken.webAuth == true) {
    //   setURL(0);
    // } else {
    //   setURL(1);
    // }
  }
}

// Future<void> clearUserData() async {
//   dev.log('Clearing all user data from local storage', name: 'LocalDB');
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.remove(ACCESS_TOKEN_KEY);
//   await prefs.remove(USER_INFO_KEY);
//   await prefs.remove(USER_ID_DATA_KEY);
// }

clearUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', "");
  prefs.setString('userInfo', "");
}

// Future<AccessToken?> loadAccessToken() async {
//   dev.log('Loading access token from local storage', name: 'LocalDB');
//   final prefs = await SharedPreferences.getInstance();
//   final accessTokenString = prefs.getString(ACCESS_TOKEN_KEY);
//   if (accessTokenString != null) {
//     return AccessToken.fromJson(json.decode(accessTokenString));
//   }
//   return null;
// }

// Future<UserInfo?> loadUserInfo() async {
//   dev.log('Loading user info from local storage', name: 'LocalDB');
//   final prefs = await SharedPreferences.getInstance();
//   final userInfoString = prefs.getString(USER_INFO_KEY);
//   if (userInfoString != null) {
//     try {
//       return userInfoFromJson(userInfoString);
//     } catch (e) {
//       dev.log('Error loading user info: $e', name: 'LocalDB');
//       return null;
//     }
//   }
//   return null;
// }

// Future<void> saveDropdownOptions(String fieldId, List<String> options) async {
//   dev.log('Saving dropdown options for fieldId: $fieldId', name: 'LocalDB');
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setStringList(DROPDOWN_OPTIONS_PREFIX + fieldId, options);
// }
//
// Future<List<String>?> getDropdownOptions(String fieldId) async {
//   dev.log('Getting dropdown options for fieldId: $fieldId', name: 'LocalDB');
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getStringList(DROPDOWN_OPTIONS_PREFIX + fieldId);
// }
