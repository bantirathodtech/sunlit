import 'package:common/common_widgets.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository loginRepository;

  LoginViewModel({required this.loginRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  AccessToken accessToken1 = AccessToken();
  UserInfo userInfo1 = UserInfo();
  UserIdData userIdData1 = UserIdData();

  Future<void> getLoginData(
      String userName, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final data = await loginRepository.getPlgLoginData(userName, password);
      accessToken1 = AccessToken.fromJson(data);

      if (!checkStatus(accessToken1.userId.toString())) {
        _errorMessage = "Invalid Username or Password";
        showSnackBar(_errorMessage);
      } else {
        accessToken1.loginTime = DateTime.now().toIso8601String();
        accessToken1.userName = userName;
        accessToken1.password = password;
        accessToken1.webAuth = false;
        await getUserData(context);
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch user information: $e';
      showSnackBar(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      Map data = {'query': getUserInfo()};
      var queryData = json.encode(data);
      var response = await loginRepository.getUserData(queryData, accessToken1);
      String jsonData = response["data"]["getGlobalParameters"].toString();
      userInfo1 = userInfoFromJson(jsonData);
      if (checkStatus(userInfo1.user?.bunitId.toString() ?? '')) {
        await getUserIdData(context);
      } else {
        throw Exception("Failed to fetch user information");
      }
    } catch (e) {
      _errorMessage = e.toString();
      showSnackBar(_errorMessage);
    }
  }

  Future<void> getUserIdData(BuildContext context) async {
    try {
      Map data = {'query': getUserIdDataQuery(accessToken1.userId.toString())};
      var queryData = json.encode(data);
      var response = await loginRepository.getUserData(queryData, accessToken1);
      String jsonData = response["data"]["executeAPIBuilder"].toString();
      List<UserIdData> userIdDataList = getDataFromUserInfoFromData(jsonData);

      if (userIdDataList.isNotEmpty) {
        userIdData1 = userIdDataList[0];
        print(
            "LoginViewModel: User name set to ${userIdData1.name}"); // Log the name
        notifyListeners(); // Notify listeners when data is updated

        await saveUserData(accessToken1, userInfo1, userIdData1);
        callMainPage(context);
      } else {
        throw Exception("Failed to fetch user ID data");
      }
    } catch (e) {
      _errorMessage = e.toString();
      showSnackBar(_errorMessage);
    }
  }

  //added for auto login
  Future<bool> attemptAutoLogin(BuildContext context) async {
    if (await isUserLoggedIn()) {
      try {
        AccessToken? savedAccessToken = await loadAccessToken();
        UserInfo? savedUserInfo = await loadUserInfo();
        UserIdData? savedUserIdData = await loadUserIdData();

        if (savedAccessToken != null &&
            savedUserInfo != null &&
            savedUserIdData != null) {
          accessToken1 = savedAccessToken;
          userInfo1 = savedUserInfo;
          userIdData1 = savedUserIdData;

          if (isTokenValid(accessToken1)) {
            notifyListeners();
            callMainPage(context);
            return true;
          }
        }
      } catch (e) {
        _errorMessage = 'Auto-login failed: $e';
        showSnackBar(_errorMessage);
      }
    }
    return false;
  }

  bool isTokenValid(AccessToken token) {
    // Implement your token validation logic here
    return true; // Placeholder
  }
}
