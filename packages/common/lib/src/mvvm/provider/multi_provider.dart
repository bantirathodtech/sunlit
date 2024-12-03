// import '../../../common_widgets.dart';
//
// List<ChangeNotifierProvider> multiProvider() {
//   final dio = Dio(BaseOptions(
//     extra: {"withCredentials": true},
//     baseUrl: baseURL,
//     connectTimeout: const Duration(milliseconds: 300000),
//     receiveTimeout: const Duration(milliseconds: 300000),
//   ));
//
//   final apiService = ApiService(dio: dio);
//
//   final loginRepository = LoginRepository(apiService: apiService);
//   final mainRepository = MainRepository(apiService: apiService);
//   final collectionRepository = CollectionRepository(apiService: apiService);
//   final collectionService =
//       CollectionService(repository: collectionRepository, dio: dio);
//   final expenseService = ExpenseService(apiService: apiService);
//   final expenseRepository = ExpenseRepository(expenseService: expenseService);
//
//   return [
//     ChangeNotifierProvider<LoginViewModel>(
//       create: (context) => LoginViewModel(loginRepository: loginRepository),
//     ),
//     ChangeNotifierProvider<MainViewModel>(
//       create: (context) => MainViewModel(mainRepository: mainRepository),
//     ),
//     ChangeNotifierProvider<CollectionViewModel>(
//       create: (context) => CollectionViewModel(
//         // collectionRepository: collectionRepository,
//         collectionService: collectionService,
//         loginViewModel: Provider.of<LoginViewModel>(context, listen: false),
//       ),
//     ),
//     ChangeNotifierProvider<ExpenseViewModel>(
//       create: (context) => ExpenseViewModel(
//         expenseRepository: expenseRepository,
//         expenseService: expenseService,
//         loginViewModel: Provider.of<LoginViewModel>(context, listen: false),
//       ),
//     ),
//   ];
// }

import '../../../common_widgets.dart';

List<ChangeNotifierProvider> multiProvider() {
  final dio = Dio(BaseOptions(
    extra: {"withCredentials": true},
    baseUrl: baseURL,
    connectTimeout: const Duration(milliseconds: 300000),
    receiveTimeout: const Duration(milliseconds: 300000),
  ));

  final apiService = ApiService(dio: dio);

  // Login related
  final loginRepository = LoginRepository(apiService: apiService);

  // Main related
  final mainRepository = MainRepository(apiService: apiService);

  // Collection related
  final collectionService = CollectionService(apiService: apiService);
  final collectionRepository =
      CollectionRepository(collectionService: collectionService);

  // Expense related
  final expenseAPIService = ExpenseApiService(apiService: apiService);
  final expenseRepository = ExpenseRepository(apiService: expenseAPIService);

  return [
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(loginRepository: loginRepository),
    ),
    ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(mainRepository: mainRepository),
    ),
    // ChangeNotifierProvider<CollectionViewModel>(
    //   create: (context) => CollectionViewModel(
    //     collectionRepository: collectionRepository,
    //     loginViewModel: Provider.of<LoginViewModel>(context, listen: false),
    //   ),
    // ),
    ChangeNotifierProvider<CollectionViewModel>(
      create: (context) => CollectionViewModel(
        // collectionService: collectionService,
        collectionRepository: collectionRepository,
        loginViewModel: Provider.of<LoginViewModel>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider<ExpenseFormViewModel>(
      create: (context) => ExpenseFormViewModel(
        expenseRepository: expenseRepository,
        loginViewModel: Provider.of<LoginViewModel>(context, listen: false),
      ),
    ),
  ];
}
