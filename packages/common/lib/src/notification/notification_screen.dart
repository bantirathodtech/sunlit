
import 'package:common/common_widgets.dart';

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({super.key});
  static const route = '/notification';

  @override
  State<NotificationScreen> createState() => NotificationScreenState();

}

class NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return MaterialApp(
      title: appName,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: HexColor(navyBlue),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => backPressed(context, true),
          ),
          title: Text("Notification Screen",
            style: const TextStyle(color: Colors.white,
                fontSize: 16,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.bold),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 6),
                    Text(
                      'Push Notification Page', style: TextStyle(color: Colors.black,
                        fontSize: 15, fontFamily: "DMSans",
                        fontWeight: FontWeight.w600),),
                    const SizedBox(height: 20),
                    Text(
                      '${checkString(message.notification!.title.toString())}', style: TextStyle(color: Colors.black,
                        fontSize: 14, fontFamily: "DMSans",
                        fontWeight: FontWeight.w400),),
                    const SizedBox(height: 5),
                    Text(
                      '${checkString(message.notification!.body.toString())}', style: TextStyle(color: Colors.black,
                        fontSize: 14, fontFamily: "DMSans",
                        fontWeight: FontWeight.w400),),
                    const SizedBox(height: 5),
                    Text(
                      '${checkString(message.data.toString())}', style: TextStyle(color: Colors.black,
                        fontSize: 14, fontFamily: "DMSans",
                        fontWeight: FontWeight.w400),),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

}