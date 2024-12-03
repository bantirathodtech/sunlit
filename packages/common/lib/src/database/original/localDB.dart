// import 'package:common/common_widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// AccessToken accessToken = AccessToken();
// UserInfo userInfo = UserInfo();
// String firebaseToken = "";
//
// void saveUserToken(AccessToken accessToken) async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setString('accessToken', accessTokenToJson(accessToken));
// }
//
// void saveUserData(AccessToken accessToken, UserInfo userInfo) async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setString('accessToken', accessTokenToJson(accessToken));
//   sharedPreferences.setString('userInfo', userInfoToJson(userInfo));
// }
//
// checkingUserInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? accessTokenValue = prefs.getString('accessToken');
//   String? userInfoValue = prefs.getString('userInfo');
//
//   if (accessTokenValue != null &&
//       accessTokenValue.trim().isNotEmpty &&
//       userInfoValue != null &&
//       userInfoValue.trim().isNotEmpty) {
//     printMessage(accessTokenValue.toString());
//     printMessage(userInfoValue.toString());
//     accessToken = accessTokenFromJson(accessTokenValue);
//     userInfo = userInfoFromJson(userInfoValue);
//
//     if (accessToken.webAuth == true) {
//       setURL(0);
//     } else {
//       setURL(1);
//     }
//   }
// }
//
// clearUserInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('accessToken', "");
//   prefs.setString('userInfo', "");
// }
