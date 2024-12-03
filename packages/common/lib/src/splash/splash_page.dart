import 'dart:async';

import 'package:common/common_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attemptAutoLogin();
    Timer(const Duration(seconds: 3), () {
      checkUserInfo();
    });
  }

  //added for auto login
  void attemptAutoLogin() async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    bool isLoggedIn = await loginViewModel.attemptAutoLogin(context);

    if (isLoggedIn) {
      callMainPage(context);
    } else {
      callWebLogin(context);
    }
  }

  void checkUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenValue = prefs.getString('accessToken');
    String? userInfo = prefs.getString('userInfo');

    printMessage("$tokenValue");

    if (tokenValue != null &&
        tokenValue.trim().isNotEmpty &&
        userInfo != null &&
        userInfo.trim().isNotEmpty) {
      callMainPage(context);
    } else {
      callWebLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Image(
                  image: AssetImage("packages/common/assets/images/my_cw.png"),
                  width: 260,
                  height: 60),
              const SizedBox(height: 20),
              SizedBox(
                  width: 140,
                  height: 4,
                  child: LinearProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor(blackColor)),
                    backgroundColor: HexColor(background),
                    color: themeColor(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
