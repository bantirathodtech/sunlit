import 'package:common/common_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WidgetController extends GetxController {
  RxInt currentBottomNavItemIndex = 0.obs;

  void switchBetweenBottomNavigationItems(int currentIndex) {
    currentBottomNavItemIndex.value = currentIndex;
  }
}

Widget appBarTitle(String titleName) {
  return Expanded(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      blackTextWidgetSmall(titleName, "#1C1C1E", 18, FontWeight.w600),
    ],
  ));
}

Widget appBarTitleWithText(String titleName, String smallTitle) {
  return Expanded(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      blackTextWidgetSmall(titleName, "#1C1C1E", 18, FontWeight.w600),
      blackTextWidgetSmall(smallTitle, "#B31C1C1E", 12, FontWeight.w400),
    ],
  ));
}

appBarTextStyle() {
  return const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Inter',
      package: 'common',
      fontWeight: FontWeight.bold);
}

Widget backButton(BuildContext context) {
  return IconButton(
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    icon: Icon(
      Icons.arrow_back_ios_new_outlined,
      color: HexColor(blackColor),
      size: 22,
    ),
    onPressed: () => backPressed(context, false),
  );
}

Widget destroyButton(BuildContext context) {
  return IconButton(
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    icon: Icon(
      Icons.arrow_back_ios_new_outlined,
      color: HexColor(blackColor),
      size: 22,
    ),
    onPressed: () => finishApp(context),
  );
}

Widget showHideLoading(bool loading) {
  if (loading) {
    return LinearProgressIndicator(
      minHeight: 3.0,
      //value: wmsViewModel.loading,
      valueColor: AlwaysStoppedAnimation<Color>(HexColor(blackColor)),
      backgroundColor: HexColor(background),
      color: themeColor(),
    );
  } else {
    return emptyTextField();
  }
}

Widget circleLoadingIndicator() {
  return const SizedBox(
    height: 25.0,
    width: 25.0,
    child: Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 2,
    )),
  );
}

Widget loadingIndicator() {
  return LoadingIndicator(
    indicatorType: Indicator.ballPulse,

    /// Required, The loading type of the widget
    colors: [HexColor(blackColor)],

    /// Optional, The color collections
    strokeWidth: 1,

    /// Optional, The stroke of the line, only applicable to widget which contains line
  );
}

Widget bottomHeaderData(BuildContext context, String title) {
  return Column(
    //mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset("packages/common/assets/images/dash_icon.svg",
          width: 10, height: 2),
      const SizedBox(height: 5),
      //appBarHeaderTitle(title),
      Expanded(
          child: Center(
              child:
                  blackTextWidgetSmall(title, "#1C1C1E", 18, FontWeight.w500))),
      /*IconButton(
        alignment: Alignment.center,
        icon: const Icon(Icons.close, color: Colors.black, size: 22,),
        onPressed: () {
          backPressed(context, false);
        },
      ),*/
    ],
  );
}

Widget dialogHeaderData(BuildContext context, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset("packages/common/assets/images/dash_icon.svg",
          width: 10, height: 2),
      const SizedBox(height: 5),
      blackTextWidgetSmallCenter(
          checkString(title), "#1C1C1E", 15, FontWeight.w500),
    ],
  );
}

Widget appBarHeaderTitle(String titleName) {
  return Expanded(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      blackTextWidgetSmall(titleName, "#1C1C1E", 18, FontWeight.w500),
    ],
  ));
}

showBottomHeaderLabelName(String name) {
  return Text(name, style: appBarTextStyle());
}

Widget emptyTextField() {
  return const SizedBox(
      height: 0, width: 0, child: Text("", style: TextStyle(fontSize: 0)));
}

Widget showEditController(String hint, TextInputType inputType,
    TextEditingController editController, TextAlign textAlign) {
  return TextFormField(
    showCursor: true,
    controller: editController,
    //initialValue: getProductValue(productElement, type),
    cursorColor: HexColor(blackColor),
    maxLines: 1,
    readOnly: false,
    keyboardType: inputType,
    textCapitalization: TextCapitalization.words,
    style: editTextStyle(),
    textAlign: textAlign,
    decoration: InputDecoration(
      focusedBorder: editBorderRadius(blackColor, 5, 1),
      enabledBorder: editBorderRadius(blackColor, 5, 1),
      contentPadding: const EdgeInsets.all(10),
      hintText: hint,
      hintStyle: hintTextStyle(),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}

Widget showEditDateController(BuildContext context, StateSetter dialogState,
    TextEditingController editController, TextAlign textAlign) {
  return TextFormField(
    showCursor: true,
    controller: editController,
    //initialValue: getProductValue(productElement, type),
    cursorColor: HexColor(blackColor),
    maxLines: 1,
    readOnly: true,
    keyboardType: TextInputType.text,
    textCapitalization: TextCapitalization.words,
    style: editTextStyle(),
    textAlign: textAlign,
    onTap: () async {
      String? dateValue = await dateDialog(context);
      if (checkStatus(dateValue)) {
        dialogState(() {
          editController.text = dateValue;
        });
      }
    },
    decoration: InputDecoration(
      focusedBorder: editBorderRadius(blackColor, 5, 1),
      enabledBorder: editBorderRadius(blackColor, 5, 1),
      contentPadding: const EdgeInsets.all(10),
      hintText: "",
      hintStyle: hintTextStyle(),
      suffixIcon: Icon(
        Icons.date_range,
        color: HexColor(blackColor),
        size: 18,
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}

editTextStyle() {
  return TextStyle(
    color: HexColor(blackColor),
    fontSize: 16,
    overflow: TextOverflow.clip,
    fontFamily: 'Inter',
    package: 'common',
    fontWeight: FontWeight.w500,
  );
}

productRowLineText(String labelName, String productData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child:
            blackTextWidgetSmall(labelName, "#B21C1C1E", 15, FontWeight.w300),
      ),
      Expanded(
        child: blackTextWidgetSmallEnd(
            productData, "#1C1C1E", 16, FontWeight.w500),
      ),
    ],
  );
}

productRowLineEdit(String labelName, TextInputType inputType,
    TextEditingController editController, String type) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child:
            blackTextWidgetSmall(labelName, "#B21C1C1E", 15, FontWeight.w300),
      ),
      Expanded(
        child:
            showEditController(type, inputType, editController, TextAlign.end),
      ),
    ],
  );
}

productRowLineEditDate(String labelName, BuildContext context,
    StateSetter dialogState, TextEditingController editController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child:
            blackTextWidgetSmall(labelName, "#B21C1C1E", 15, FontWeight.w300),
      ),
      Expanded(
        child: showEditDateController(
            context, dialogState, editController, TextAlign.end),
      ),
    ],
  );
}

showBottomAlertLabelName(String name) {
  return Text(name, style: hintTextStyle());
}

showBottomAlertWidgetName(String name) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        name,
        style: blackTextStyle(),
      ));
}

blackTextWidget(String name) {
  return Text(name, style: blackTextStyle());
}

blackTextWidgetSmall(
    String name, String colorCode, double fontSize, FontWeight fontWeight) {
  return Text(name,
      style: TextStyle(
          color: HexColor(colorCode),
          fontSize: fontSize,
          overflow: TextOverflow.clip,
          fontFamily: 'Inter',
          package: 'common',
          fontWeight: fontWeight));
}

textStyle(String colorCode, double fontSize, FontWeight fontWeight) {
  return TextStyle(
      color: HexColor(colorCode),
      fontSize: fontSize,
      fontFamily: 'Inter',
      package: 'common',
      fontWeight: fontWeight);
}

editBorderRadius(String colorCode, double radius, double width) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: HexColor(colorCode), width: width),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

blackTextWidgetSmallCenter(
    String name, String colorCode, double fontSize, FontWeight fontWeight) {
  return Text(
    name,
    style: TextStyle(
        color: HexColor(colorCode),
        fontSize: fontSize,
        overflow: TextOverflow.clip,
        fontFamily: 'Inter',
        package: 'common',
        fontWeight: fontWeight),
    textAlign: TextAlign.center,
  );
}

blackTextWidgetSmallEnd(
    String name, String colorCode, double fontSize, FontWeight fontWeight) {
  return Text(
    name,
    style: TextStyle(
        color: HexColor(colorCode),
        fontSize: fontSize,
        overflow: TextOverflow.clip,
        fontFamily: 'Inter',
        package: 'common',
        fontWeight: fontWeight),
    textAlign: TextAlign.end,
  );
}

blueTextWidget(String name) {
  return Text(name, style: blueTextStyle());
}

blueTextStyle() {
  return TextStyle(
      color: HexColor(navyBlue),
      fontSize: 15,
      overflow: TextOverflow.clip,
      fontFamily: 'Inter',
      package: 'common',
      fontWeight: FontWeight.w500);
}

blackTextStyle() {
  return const TextStyle(
      color: Colors.black,
      fontSize: 15,
      overflow: TextOverflow.clip,
      fontFamily: 'Inter',
      package: 'common',
      fontWeight: FontWeight.w500);
}

hintTextStyle() {
  return const TextStyle(
      color: Colors.black54,
      fontSize: 13,
      fontFamily: 'Inter',
      package: 'common',
      fontWeight: FontWeight.w400);
}

bool checkValidToken() {
  DateTime loginTime = DateTime.parse(accessToken.loginTime.toString());
  DateTime currentTime = DateTime.parse(currentDate);

  if (loginTime.compareTo(currentTime) < 0) {
    return true;
  }
  return false;
}

Future<String> dateDialog(BuildContext context) async {
  String dateValue = "";
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: HexColor(blackColor),
              hintColor: HexColor(blackColor),
              colorScheme: ColorScheme.light(primary: HexColor(blackColor)),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      });
  if (pickedDate != null) {
    dateValue = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
  return dateValue;
}
