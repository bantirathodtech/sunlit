import 'package:common/common_widgets.dart';

void callMainPage(BuildContext context) async {
  checkingUserInfo();
  buildContext = context;
  widgetController.currentBottomNavItemIndex.value = 0;
  context.pushReplacement('/home');
}

void callWebLogin(BuildContext context) {
  context.pushReplacement(kIsWeb ? '/web' : '/login');
}

void callWebRefreshToken(BuildContext context) {
  context.pushReplacement('/refresh');
}

void backPressed(BuildContext context, [bool status = false]) {
  Navigator.of(context).pop();
}

void backPressedDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

void backPressedWithResponse(BuildContext context) {
  Navigator.of(context).pop("1");
}

void finishApp(BuildContext context) {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}
