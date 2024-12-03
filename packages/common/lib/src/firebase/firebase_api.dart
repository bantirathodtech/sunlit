// import 'dart:async';
//
// import 'package:common/common_widgets.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FirebaseAPI {
//   final firebaseMessaging = FirebaseMessaging.instance;
//
//   final StreamController<String?> selectNotificationStream =
//       StreamController<String?>.broadcast();
//
//   final StreamController<ReceivedNotification>
//       didReceiveLocalNotificationStream =
//       StreamController<ReceivedNotification>.broadcast();
//
//   String darwinNotificationCategoryText = 'textCategory';
//
//   /// Defines a iOS/MacOS notification category for plain actions.
//   String darwinNotificationCategoryPlain = 'plainCategory';
//
//   Future<void> handleBackgroundMessage(RemoteMessage remoteMessage) async {
//     printMessage("handleBackgroundMessage");
//     printMessage("remoteMessage.....$remoteMessage");
//     printMessage("Title00: ${remoteMessage.notification?.title}");
//     printMessage("Body00: ${remoteMessage.notification?.body}");
//     printMessage("Payload00: ${remoteMessage.data}");
//     navigatorKey.currentState?.pushNamed(
//       NotificationScreen.route,
//       arguments: remoteMessage,
//     );
//   }
//
//   void handleMessage(RemoteMessage? remoteMessage) {
//     printMessage("handleMessage");
//     printMessage("remoteMessage.....$remoteMessage");
//     if (remoteMessage == null) return;
//     printMessage("Title11: ${remoteMessage.notification?.title}");
//     printMessage("Body11: ${remoteMessage.notification?.body}");
//     printMessage("Payload11: ${remoteMessage.data}");
//     navigatorKey.currentState?.pushNamed(
//       NotificationScreen.route,
//       arguments: remoteMessage,
//     );
//   }
//
//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//
//     //app is closed/background
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }
//
//   Future<void> initNotifications() async {
//     await firebaseMessaging.requestPermission();
//     //final fcmToken = await firebaseMessaging.getToken();
//     //firebaseToken = fcmToken.toString();
//     printMessage("Token: $firebaseToken");
//     initPushNotifications();
//
// /*FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if(notification!=null){
//         localNotifications.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//                 androidChannel.id,
//                 androidChannel.name,
//                 channelDescription: androidChannel.description,
//                 icon: '@drawable/cw_logo',
//                 priority: Priority.high,
//                 importance: Importance.high,
//                 fullScreenIntent: true
//             ),
//           ),
//           payload: jsonEncode(message.toMap()),
//         );
//       }
//     });*/
//   }
// }
//
// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
//
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }
