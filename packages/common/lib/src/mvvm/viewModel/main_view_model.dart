
import 'package:common/common_widgets.dart';

class MainViewModel extends ChangeNotifier {
  final MainRepository mainRepository;

  MainViewModel({required this.mainRepository});

  List<UserModel> _users = []; // List to store user data fetched from the API.
  bool _loading = false; // Boolean flag to track if data is currently being fetched.
  String _errorMessage = ''; // String to store any error message that occurs during data fetching.

  List<UserModel> get users => _users; // Getter method to access the list of users.
  bool get loading => _loading; // Getter method to access the loading flag.
  String get errorMessage => _errorMessage; // Getter method to access the error message.

  void insertUser() {
    printMessage("insertUser...");
    mainRepository.insertUser("user");
  }
}