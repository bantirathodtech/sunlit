import 'package:common/common_widgets.dart';

class MainRepository {
  final ApiService apiService;

  MainRepository({required this.apiService});

  Future<dynamic> insertUser(String endPoint) async {
    try {
      return await apiService.createNewUser(endPoint);
    } catch (e) {
      throw Exception('Failed to insert user: ${e.toString()}');
    }
  }
}
