// // // lib/common/di/di_container.dart
// //
// // import 'package:common/common_widgets.dart';
// // import 'package:get_it/get_it.dart';
// //
// // // Create a global service locator
// // final GetIt getIt = GetIt.instance;
// //
// // void setupDependencies(AppConfig appConfig) {
// //   // Register Dio as a singleton
// //   getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
// //         baseUrl: appConfig.apiUrl,
// //         connectTimeout: Duration(milliseconds: 5000),
// //         receiveTimeout: Duration(milliseconds: 3000),
// //       )));
// //
// //   // Register AppConfig as a singleton
// //   getIt.registerSingleton<AppConfig>(appConfig);
// //
// //   // Register ApiService as a lazy singleton with the provided AppConfig
// //   getIt.registerLazySingleton<ApiService>(
// //     () => ApiService(
// //       dio: getIt<Dio>(),
// //       appConfig: getIt<AppConfig>(),
// //     ),
// //   );
// //
// //   // Register LoginRepository as a lazy singleton
// //   getIt.registerLazySingleton<LoginRepository>(
// //     () => LoginRepository(apiService: getIt<ApiService>()),
// //   );
// //
// //   // Register MainRepository as a lazy singleton
// //   getIt.registerLazySingleton<MainRepository>(
// //     () => MainRepository(apiService: getIt<ApiService>()),
// //   );
// //
// //   // Register CollectionService and CollectionRepository as lazy singletons
// //   getIt.registerLazySingleton<CollectionService>(
// //     () => CollectionService(
// //       apiService: getIt<ApiService>(),
// //       appConfig: getIt<AppConfig>(),
// //     ),
// //   );
// //   getIt.registerLazySingleton<CollectionRepository>(
// //     () => CollectionRepository(collectionService: getIt<CollectionService>()),
// //   );
//
// // Register CollectionViewModel
// // getIt.registerFactory<CollectionViewModel>(() => CollectionViewModel(
// //       collectionService: getIt<CollectionService>(),
// //       loginViewModel: getIt<LoginViewModel>(),
// //     ));
// //
// //   // Register ExpenseService and ExpenseRepository as lazy singletons
// //   getIt.registerLazySingleton<ExpenseService>(
// //     () => ExpenseService(
// //       apiService: getIt<ApiService>(),
// //       appConfig: getIt<AppConfig>(),
// //     ),
// //   );
// //   getIt.registerLazySingleton<ExpenseRepository>(
// //     () => ExpenseRepository(expenseService: getIt<ExpenseService>()),
// //   );
//
// // Register ExpenseViewModel
// // getIt.registerFactory<ExpenseViewModel>(() => ExpenseViewModel(
// //       expenseService: getIt<ExpenseService>(),
// //       loginViewModel: getIt<LoginViewModel>(),
// //     ));
// //
// //   // Register other services and repositories as needed
// //   // getIt.registerLazySingleton<OtherService>(() => OtherService());
// //   // getIt.registerFactory<Repository>(() => Repository());
// // }
// // lib/common/di/di_container.dart
//
// import 'package:common/common_widgets.dart';
// import 'package:get_it/get_it.dart';
//
// // Create a global service locator
// final GetIt getIt = GetIt.instance;
//
// void setupDependencies(AppConfig appConfig) {
//   // Register AppConfig as a singleton
//   getIt.registerSingleton<AppConfig>(appConfig);
//
//   // Register Dio as a singleton
//   getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
//         baseUrl: appConfig.apiUrl,
//         connectTimeout: Duration(milliseconds: 5000),
//         receiveTimeout: Duration(milliseconds: 3000),
//       )));
//
//   // Register ApiService using its factory constructor
//   getIt.registerLazySingleton<ApiService>(() => ApiService.fromDI());
//
//   // Register LoginRepository using its factory constructor
//   getIt.registerLazySingleton<LoginRepository>(() => LoginRepository.fromDI());
//
//   // Register LoginViewModel
//   getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
//         loginRepository: getIt<LoginRepository>(),
//       ));
//
//   // Register MainRepository using its factory constructor
//   getIt.registerLazySingleton<MainRepository>(() => MainRepository.fromDI());
//
//   // Register CollectionService using its factory constructor
//   getIt.registerLazySingleton<CollectionService>(
//       () => CollectionService.fromDI());
//
//   // Register CollectionRepository using its factory constructor
//   getIt.registerLazySingleton<CollectionRepository>(
//       () => CollectionRepository.fromDI());
//
//   getIt.registerLazySingleton<CollectionViewModel>(
//       () => CollectionViewModel.fromDI());
//
//   // Register ExpenseService using its factory constructor
//   getIt.registerLazySingleton<ExpenseService>(() => ExpenseService.fromDI());
//
//   // Register ExpenseRepository using its factory constructor
//   getIt.registerLazySingleton<ExpenseRepository>(
//       () => ExpenseRepository.fromDI());
//
//   getIt
//       .registerLazySingleton<ExpenseViewModel>(() => ExpenseViewModel.fromDI());
//
//   // Register other view models as needed
//   // getIt.registerFactory<OtherViewModel>(() => OtherViewModel());
//
//   // Register other services and repositories as needed
//   // getIt.registerLazySingleton<OtherService>(() => OtherService.fromDI());
//   // getIt.registerFactory<Repository>(() => Repository.fromDI());
//
//   // Register other services and repositories as needed
//   // getIt.registerLazySingleton<OtherService>(() => OtherService.fromDI());
//   // getIt.registerFactory<Repository>(() => Repository.fromDI());
// }
