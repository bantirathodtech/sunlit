// import 'dart:async';
// import 'dart:ui';
//
// import 'package:common/common_widgets.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
//
// // Define the background service task
// @pragma('vm:entry-point')
// void backgroundTask(ServiceInstance service) {
//   service.on('setAsForeground').listen((event) {
//     service.setAsForegroundService();
//   });
//
//   service.on('setAsBackground').listen((event) {
//     service.setAsBackgroundService();
//   });
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   // Simulate a background task
//   Timer.periodic(Duration(minutes: 1), (timer) {
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "Background Service",
//         content: "Running ${DateTime.now()}",
//       );
//     }
//
//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//       },
//     );
//   });
// }
//
// // Initialize and configure the background service
// class BackgroundTasks {
//   static Future<void> initialize() async {
//     final service = FlutterBackgroundService();
//
//     await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         onStart: backgroundTask,
//         autoStart: true,
//         isForegroundMode: true,
//       ),
//       iosConfiguration: IosConfiguration(
//         autoStart: true,
//         onForeground: backgroundTask,
//         onBackground: onIosBackground,
//       ),
//     );
//   }
//
//   // Example function to start the background service
//   static Future<bool> startService() async {
//     final service = FlutterBackgroundService();
//     return await service.startService();
//   }
//
//   // Example function to stop the background service
//   static Future<bool??> stopService() async {
//     final service = FlutterBackgroundService();
//     return await service.invoke("stopService");
//   }
// }
//
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//
//   return true;
// }
//
// // Example usage in a Flutter widget
// class BackgroundTasksExample extends StatefulWidget {
//   @override
//   _BackgroundTasksExampleState createState() => _BackgroundTasksExampleState();
// }
//
// class _BackgroundTasksExampleState extends State<BackgroundTasksExample> {
//   @override
//   void initState() {
//     super.initState();
//     BackgroundTasks.initialize();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Background Tasks Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 final isRunning = await BackgroundTasks.startService();
//                 if (isRunning) {
//                   print('Service started successfully');
//                 } else {
//                   print('Failed to start service');
//                 }
//               },
//               child: Text('Start Background Service'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final isStopped = await BackgroundTasks.stopService();
//                 if (isStopped) {
//                   print('Service stopped successfully');
//                 } else {
//                   print('Failed to stop service');
//                 }
//               },
//               child: Text('Stop Background Service'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//Purpose: Handles background tasks and scheduled operations that need to run independently of the app’s foreground operations.
// Usage: Used to manage and execute tasks that need to run in the background.
