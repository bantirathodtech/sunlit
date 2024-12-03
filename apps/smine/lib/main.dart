import 'package:common/common_widgets.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // if (!kIsWeb) {
  //   await Firebase.initializeApp();
  // }
  runApp(
    MultiProvider(
      providers: multiProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: themeColor()),
        useMaterial3: true,
      ),
      routerConfig: appRoute,
      // navigatorKey: navigatorKey, // Add this line
    );
  }
}

// Assume we have this function to get the user role
UserRole getUserRole() {
  // This should be implemented to return the actual user role
  // For now, let's return a default role
  return UserRole.operator;
}

final appRoute = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: "/",
    builder: (BuildContext context, GoRouterState state) {
      return const SplashPage();
    },
  ),
  GoRoute(
    path: "/login",
    name: "login",
    builder: (BuildContext context, GoRouterState state) {
      return const WebVersionLoginPage();
    },
  ),
  GoRoute(
    path: "/web",
    name: "web",
    builder: (BuildContext context, GoRouterState state) {
      return const WebVersionLoginPage();
    },
  ),
  GoRoute(
    path: "/home",
    name: "home",
    builder: (BuildContext context, GoRouterState state) {
      // return const MainPage();
      // Get the user role and pass it to MainPage
      final userRole = getUserRole();
      return MainPage();
    },
  ),
]);
