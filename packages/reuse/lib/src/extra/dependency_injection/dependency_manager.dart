// // lib/common/di/dependency_manager.dart
//
// import 'package:common/common_widgets.dart';
// import 'package:get_it/get_it.dart';
// import 'package:dio/dio.dart';
// import 'package:your_app/services/api_service.dart';
// import 'package:your_app/services/expense_service.dart';
// import 'package:your_app/repositories/login_repository.dart';
// import 'package:your_app/repositories/main_repository.dart';
// import 'package:your_app/services/collection_service.dart';
// import 'package:your_app/repositories/collection_repository.dart';
// import 'package:your_app/view_models/collection_view_model.dart';
// import 'package:your_app/view_models/expense_view_model.dart';
// import 'package:your_app/config/app_config.dart';
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
//     baseUrl: appConfig.apiUrl,
//     connectTimeout: Duration(milliseconds: 5000),
//     receiveTimeout: Duration(milliseconds: 3000),
//   )));
//
//   // Register ApiService directly
//   getIt.registerLazySingleton<ApiService>(() => ApiService(
//     dio: getIt<Dio>(),
//     appConfig: getIt<AppConfig>(),
//   ));
//
//   // Register LoginRepository directly
//   getIt.registerLazySingleton<LoginRepository>(() => LoginRepository(
//     apiService: getIt<ApiService>(),
//   ));
//
//   // Register MainRepository directly
//   getIt.registerLazySingleton<MainRepository>(() => MainRepository(
//     apiService: getIt<ApiService>(),
//   ));
//
//   // Register CollectionService and CollectionRepository directly
//   getIt.registerLazySingleton<CollectionService>(() => CollectionService(
//     apiService: getIt<ApiService>(),
//     appConfig: getIt<AppConfig>(),
//   ));
//   getIt.registerLazySingleton<CollectionRepository>(() => CollectionRepository(
//     collectionService: getIt<CollectionService>(),
//   ));
//
//   // Register CollectionViewModel directly
//   getIt.registerFactory<CollectionViewModel>(() => CollectionViewModel(
//     collectionService: getIt<CollectionService>(),
//     loginViewModel: getIt<LoginViewModel>(),
//   ));
//
//   // Register ExpenseService and ExpenseRepository directly
//   getIt.registerLazySingleton<ExpenseService>(() => ExpenseService(
//     apiService: getIt<ApiService>(),
//     appConfig: getIt<AppConfig>(),
//   ));
//   getIt.registerLazySingleton<ExpenseRepository>(() => ExpenseRepository(
//     expenseService: getIt<ExpenseService>(),
//   ));
//
//   // Register ExpenseViewModel directly
//   getIt.registerFactory<ExpenseViewModel>(() => ExpenseViewModel(
//     expenseService: getIt<ExpenseService>(),
//     loginViewModel: getIt<LoginViewModel>(),
//   ));
// }
//Purpose: Handles dependency injection and service locators to manage dependencies.
// Usage: Used to manage and provide dependencies throughout the app, typically using a service locator like GetIt.
