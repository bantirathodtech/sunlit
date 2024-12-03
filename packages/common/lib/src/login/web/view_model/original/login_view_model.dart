// import 'package:common/common_widgets.dart';
//
// class LoginViewModel extends ChangeNotifier {
//   final LoginRepository loginRepository;
//
//   LoginViewModel({required this.loginRepository});
//
//   //AccessToken _userToken = AccessToken();
//   bool _loading = false;
//   String _errorMessage = '';
//
//   AccessToken get userToken1 => accessToken;
//   bool get loading => _loading;
//   String get errorMessage => _errorMessage;
//
//   Future<void> getLoginData(
//       String userName, String password, BuildContext context) async {
//     _loading = true;
//     _errorMessage = '';
//     notifyListeners();
//     try {
//       final data = await loginRepository.getPlgLoginData(userName, password);
//
//       printMessage("viewModel.....$data");
//
//       accessToken = AccessToken.fromJson(data);
//
//       if (!checkStatus(accessToken.userId.toString())) {
//         _errorMessage = "InValid Username or Password";
//         showSnackBar(_errorMessage);
//         _loading = false;
//         notifyListeners();
//       } else {
//         accessToken.loginTime = currentDate;
//         accessToken.userName = userName;
//         accessToken.password = password;
//         accessToken.webAuth = false;
//         //saveUserToken(accessToken);
//         getUserData(context);
//       }
//     } catch (e) {
//       printMessage("error....$e");
//       _errorMessage = 'Failed to fetch user information';
//       showSnackBar(_errorMessage);
//       _loading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> getUserData(BuildContext context) async {
//     _loading = true;
//     _errorMessage = '';
//     notifyListeners();
//     try {
//       Map data = {'query': getUserInfo()};
//       var queryData = json.encode(data);
//       printMessage("query.....$queryData");
//
//       var response = await loginRepository.getUserData(queryData);
//       printMessage("response.....$response");
//       String jsonData = response["data"]["getGlobalParameters"].toString();
//       printMessage("jsonData.....$jsonData");
//
//       userInfo = userInfoFromJson(jsonData);
//       if (checkStatus(userInfo.user!.bunitId.toString())) {
//         saveUserData(accessToken, userInfo);
//         callMainPage(context);
//       } else {
//         showSnackBar("Failed to fetch user information");
//       }
//     } catch (e) {
//       showSnackBar(_errorMessage);
//     } finally {
//       _loading = false;
//       notifyListeners();
//     }
//   }
// }
