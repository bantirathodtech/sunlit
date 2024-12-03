//
// import 'package:common/common_widgets.dart';
//
// class LoginRepository {
//   final ApiService apiService;
//
//   LoginRepository({required this.apiService});
//
//   Future<dynamic> getPlgLoginData(String userName, String password) async {
//     try {
//       var data = {
//         'username': userName,
//         'password': password,
//       };
//       return await apiService.plgLoginData(plgAuthUrl, data);
//     } catch (e) {
//       throw Exception('Failed to fetch access token');
//     }
//   }
//
//   Future<dynamic> getUserData(var data) async {
//     try {
//       return await apiService.commonEntTaskData(plgCoreGraphQlUrl, data);
//     } catch (e) {
//       throw Exception('Failed to fetch user info');
//     }
//   }
//
// }
