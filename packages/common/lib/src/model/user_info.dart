// filename: user_info.dart

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));
String userInfoToJson(UserInfo userInfo) => json.encode(userInfo.toJson());

class UserInfo {
  UserPreferences? userPreferences;
  //List<Map<String, Uom>> uom;
  User? user;
  //List<Map<String, Currency>> currency;

  UserInfo({
    this.userPreferences,
    //required this.uom,
    this.user,
    //required this.currency,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userPreferences: json["UserPreferences"] != null
            ? UserPreferences.fromJson(json["UserPreferences"])
            : UserPreferences(),
        //uom: List<Map<String, Uom>>.from(json["UOM"].map((x) => Map.from(x).map((k, v) => MapEntry<String, Uom>(k, Uom.fromJson(v))))),
        user: json["User"] != null ? User.fromJson(json["User"]) : User(),
        //currency: List<Map<String, Currency>>.from(json["Currency"].map((x) => Map.from(x).map((k, v) => MapEntry<String, Currency>(k, Currency.fromJson(v))))),
      );

  Map<String, dynamic> toJson() => {
        "UserPreferences": userPreferences?.toJson(),
        //"UOM": List<dynamic>.from(uom.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "User": user?.toJson(),
        //"Currency": List<dynamic>.from(currency.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
      };
}

class User {
  String? homeDashboardId;
  String? language;
  String? bunitId;
  String? bunitIden;
  String? roleIden;
  String? csClientId;
  dynamic homeWindowId;
  String? isadmin;
  String? userId;
  dynamic phone;
  String? roleId;
  String? currency;
  //Cw360V2Ui cw360V2Ui;
  String? user;
  dynamic email;
  String? csCurrencyId;
  dynamic homeReportId;

  User({
    this.homeDashboardId,
    this.language,
    this.bunitId,
    this.bunitIden,
    this.roleIden,
    this.csClientId,
    this.homeWindowId,
    this.isadmin,
    this.userId,
    this.phone,
    this.roleId,
    this.currency,
    //required this.cw360V2Ui,
    this.user,
    this.email,
    this.csCurrencyId,
    this.homeReportId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        homeDashboardId: json["home_dashboard_id"],
        language: json["language"],
        bunitId: json["bunit_id"],
        bunitIden: json["bunit_iden"],
        roleIden: json["role_iden"],
        csClientId: json["cs_client_id"],
        homeWindowId: json["home_window_id"],
        isadmin: json["isadmin"],
        userId: json["user_id"],
        phone: json["phone"],
        roleId: json["role_id"],
        currency: json["currency"],
        //cw360V2Ui: Cw360V2Ui.fromJson(json["CW360_V2_UI"]),
        user: json["user"],
        email: json["email"],
        csCurrencyId: json["cs_currency_id"],
        homeReportId: json["home_report_id"],
      );

  Map<String, dynamic> toJson() => {
        "home_dashboard_id": homeDashboardId,
        "language": language,
        "bunit_id": bunitId,
        "bunit_iden": bunitIden,
        "role_iden": roleIden,
        "cs_client_id": csClientId,
        "home_window_id": homeWindowId,
        "isadmin": isadmin,
        "user_id": userId,
        "phone": phone,
        "role_id": roleId,
        "currency": currency,
        //"CW360_V2_UI": cw360V2Ui.toJson(),
        "user": user,
        "email": email,
        "cs_currency_id": csCurrencyId,
        "home_report_id": homeReportId,
      };
}

class UserPreferences {
  int? decimalPlaces;
  String? dateTimeFormat;
  String? dateFormat;
  String? timezone;
  String? timeFormat;
  String? currency;
  String? enableMultiTab;
  String? countryCode;

  UserPreferences({
    this.decimalPlaces,
    this.dateTimeFormat,
    this.dateFormat,
    this.timezone,
    this.timeFormat,
    this.currency,
    this.enableMultiTab,
    this.countryCode,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      UserPreferences(
        decimalPlaces: json["decimalPlaces"],
        dateTimeFormat: json["dateTimeFormat"],
        dateFormat: json["dateFormat"],
        timezone: json["timezone"],
        timeFormat: json["timeFormat"],
        currency: json["Currency"],
        enableMultiTab: json["enableMultiTab"],
        countryCode: json["CountryCode"],
      );

  Map<String, dynamic> toJson() => {
        "decimalPlaces": decimalPlaces,
        "dateTimeFormat": dateTimeFormat,
        "dateFormat": dateFormat,
        "timezone": timezone,
        "timeFormat": timeFormat,
        "Currency": currency,
        "enableMultiTab": enableMultiTab,
        "CountryCode": countryCode,
      };
}

////////////////////////////////////////////////////////////////
class Currency {
  int pricePrecision;
  String currSymbol;
  String isoCode;
  int standardPrecision;
  dynamic language;
  bool symbolRightSide;
  int costingPrecision;
  String csCurrencyId;

  Currency({
    required this.pricePrecision,
    required this.currSymbol,
    required this.isoCode,
    required this.standardPrecision,
    required this.language,
    required this.symbolRightSide,
    required this.costingPrecision,
    required this.csCurrencyId,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        pricePrecision: json["pricePrecision"],
        currSymbol: json["currSymbol"],
        isoCode: json["isoCode"],
        standardPrecision: json["standardPrecision"],
        language: json["language"],
        symbolRightSide: json["symbolRightSide"],
        costingPrecision: json["costingPrecision"],
        csCurrencyId: json["csCurrencyId"],
      );

  Map<String, dynamic> toJson() => {
        "pricePrecision": pricePrecision,
        "currSymbol": currSymbol,
        "isoCode": isoCode,
        "standardPrecision": standardPrecision,
        "language": language,
        "symbolRightSide": symbolRightSide,
        "costingPrecision": costingPrecision,
        "csCurrencyId": csCurrencyId,
      };
}

class Uom {
  String csUomId;
  String ediCode;
  String name;
  int standardPrecision;
  int costingPrecision;

  Uom({
    required this.csUomId,
    required this.ediCode,
    required this.name,
    required this.standardPrecision,
    required this.costingPrecision,
  });

  factory Uom.fromJson(Map<String, dynamic> json) => Uom(
        csUomId: json["csUomId"],
        ediCode: json["ediCode"],
        name: json["name"],
        standardPrecision: json["standardPrecision"],
        costingPrecision: json["costingPrecision"],
      );

  Map<String, dynamic> toJson() => {
        "csUomId": csUomId,
        "ediCode": ediCode,
        "name": name,
        "standardPrecision": standardPrecision,
        "costingPrecision": costingPrecision,
      };
}

class Cw360V2Ui {
  NavBar navBar;
  AppTheme appTheme;
  Body footer;
  Header header;
  String fontSize;
  SideMenu sideMenu;
  ContentWindow contentWindow;
  Body body;
  String marginTop;

  Cw360V2Ui({
    required this.navBar,
    required this.appTheme,
    required this.footer,
    required this.header,
    required this.fontSize,
    required this.sideMenu,
    required this.contentWindow,
    required this.body,
    required this.marginTop,
  });

  factory Cw360V2Ui.fromJson(Map<String, dynamic> json) => Cw360V2Ui(
        navBar: NavBar.fromJson(json["navBar"]),
        appTheme: AppTheme.fromJson(json["appTheme"]),
        footer: Body.fromJson(json["footer"]),
        header: Header.fromJson(json["header"]),
        fontSize: json["fontSize"],
        sideMenu: SideMenu.fromJson(json["sideMenu"]),
        contentWindow: ContentWindow.fromJson(json["contentWindow"]),
        body: Body.fromJson(json["body"]),
        marginTop: json["marginTop"],
      );

  Map<String, dynamic> toJson() => {
        "navBar": navBar.toJson(),
        "appTheme": appTheme.toJson(),
        "footer": footer.toJson(),
        "header": header.toJson(),
        "fontSize": fontSize,
        "sideMenu": sideMenu.toJson(),
        "contentWindow": contentWindow.toJson(),
        "body": body.toJson(),
        "marginTop": marginTop,
      };
}

class AppTheme {
  String primaryBackgroundColor;
  String tabsCardBackground;
  String tableColumColor;
  String tableColumnBackground;
  String primaryColor;
  String primeryTextColor;
  String baseFontSize;
  String themePrimaryColor;
  String analyticsBackgroundColor;
  String formLabelColor;

  AppTheme({
    required this.primaryBackgroundColor,
    required this.tabsCardBackground,
    required this.tableColumColor,
    required this.tableColumnBackground,
    required this.primaryColor,
    required this.primeryTextColor,
    required this.baseFontSize,
    required this.themePrimaryColor,
    required this.analyticsBackgroundColor,
    required this.formLabelColor,
  });

  factory AppTheme.fromJson(Map<String, dynamic> json) => AppTheme(
        primaryBackgroundColor: json["primaryBackgroundColor"],
        tabsCardBackground: json["tabsCardBackground"],
        tableColumColor: json["tableColumColor"],
        tableColumnBackground: json["tableColumnBackground"],
        primaryColor: json["primaryColor"],
        primeryTextColor: json["primeryTextColor"],
        baseFontSize: json["baseFontSize"],
        themePrimaryColor: json["themePrimaryColor"],
        analyticsBackgroundColor: json["analyticsBackgroundColor"],
        formLabelColor: json["formLabelColor"],
      );

  Map<String, dynamic> toJson() => {
        "primaryBackgroundColor": primaryBackgroundColor,
        "tabsCardBackground": tabsCardBackground,
        "tableColumColor": tableColumColor,
        "tableColumnBackground": tableColumnBackground,
        "primaryColor": primaryColor,
        "primeryTextColor": primeryTextColor,
        "baseFontSize": baseFontSize,
        "themePrimaryColor": themePrimaryColor,
        "analyticsBackgroundColor": analyticsBackgroundColor,
        "formLabelColor": formLabelColor,
      };
}

class Body {
  String backgroundColor;
  String description;
  String height;
  String? padding;

  Body({
    required this.backgroundColor,
    required this.description,
    required this.height,
    this.padding,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        backgroundColor: json["backgroundColor"],
        description: json["description"],
        height: json["height"],
        padding: json["padding"],
      );

  Map<String, dynamic> toJson() => {
        "backgroundColor": backgroundColor,
        "description": description,
        "height": height,
        "padding": padding,
      };
}

class ContentWindow {
  String background;
  String paddingRight;
  String description;
  ListWindowTable listWindowTable;
  String paddingTop;
  String paddingLeft;
  ContentWindowMainCard mainCard;
  ListWindowHeader listWindowHeader;
  String height;
  ContentCard contentCard;
  RecordWindow recordWindow;

  ContentWindow({
    required this.background,
    required this.paddingRight,
    required this.description,
    required this.listWindowTable,
    required this.paddingTop,
    required this.paddingLeft,
    required this.mainCard,
    required this.listWindowHeader,
    required this.height,
    required this.contentCard,
    required this.recordWindow,
  });

  factory ContentWindow.fromJson(Map<String, dynamic> json) => ContentWindow(
        background: json["background"],
        paddingRight: json["paddingRight"],
        description: json["description"],
        listWindowTable: ListWindowTable.fromJson(json["listWindowTable"]),
        paddingTop: json["paddingTop"],
        paddingLeft: json["paddingLeft"],
        mainCard: ContentWindowMainCard.fromJson(json["mainCard"]),
        listWindowHeader: ListWindowHeader.fromJson(json["ListWindowHeader"]),
        height: json["height"],
        contentCard: ContentCard.fromJson(json["contentCard"]),
        recordWindow: RecordWindow.fromJson(json["recordWindow"]),
      );

  Map<String, dynamic> toJson() => {
        "background": background,
        "paddingRight": paddingRight,
        "description": description,
        "listWindowTable": listWindowTable.toJson(),
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
        "mainCard": mainCard.toJson(),
        "ListWindowHeader": listWindowHeader.toJson(),
        "height": height,
        "contentCard": contentCard.toJson(),
        "recordWindow": recordWindow.toJson(),
      };
}

class ContentCard {
  String borderRadius;
  String? background;
  String description;
  String height;
  String? width;

  ContentCard({
    required this.borderRadius,
    this.background,
    required this.description,
    required this.height,
    this.width,
  });

  factory ContentCard.fromJson(Map<String, dynamic> json) => ContentCard(
        borderRadius: json["borderRadius"],
        background: json["background"],
        description: json["description"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "borderRadius": borderRadius,
        "background": background,
        "description": description,
        "height": height,
        "width": width,
      };
}

class ListWindowHeader {
  LinesActionButtons listActionButtons;
  ListWindowTitle listWindowTitle;
  String description;
  NewButtonForlist newButtonForlist;
  LinesActionButtons listActionEditButtons;
  ActionButtons headerActionButtons;
  ActionButtons printActionButtons;
  SearchIcon listSearchIcon;
  ViewTypeDropdown viewTypeDropdown;
  LinesActionButtons quickAddButton;
  QuickAddButtonImage quickAddButtonImage;
  LinesActionButtons linesActionButtons;
  ProfileInfo listActionButtonImages;

  ListWindowHeader({
    required this.listActionButtons,
    required this.listWindowTitle,
    required this.description,
    required this.newButtonForlist,
    required this.listActionEditButtons,
    required this.headerActionButtons,
    required this.printActionButtons,
    required this.listSearchIcon,
    required this.viewTypeDropdown,
    required this.quickAddButton,
    required this.quickAddButtonImage,
    required this.linesActionButtons,
    required this.listActionButtonImages,
  });

  factory ListWindowHeader.fromJson(Map<String, dynamic> json) =>
      ListWindowHeader(
        listActionButtons:
            LinesActionButtons.fromJson(json["listActionButtons"]),
        listWindowTitle: ListWindowTitle.fromJson(json["listWindowTitle"]),
        description: json["description"],
        newButtonForlist: NewButtonForlist.fromJson(json["newButtonForlist"]),
        listActionEditButtons:
            LinesActionButtons.fromJson(json["listActionEditButtons"]),
        headerActionButtons:
            ActionButtons.fromJson(json["headerActionButtons"]),
        printActionButtons: ActionButtons.fromJson(json["printActionButtons"]),
        listSearchIcon: SearchIcon.fromJson(json["listSearchIcon"]),
        viewTypeDropdown: ViewTypeDropdown.fromJson(json["viewTypeDropdown"]),
        quickAddButton: LinesActionButtons.fromJson(json["quickAddButton"]),
        quickAddButtonImage:
            QuickAddButtonImage.fromJson(json["quickAddButtonImage"]),
        linesActionButtons:
            LinesActionButtons.fromJson(json["linesActionButtons"]),
        listActionButtonImages:
            ProfileInfo.fromJson(json["listActionButtonImages"]),
      );

  Map<String, dynamic> toJson() => {
        "listActionButtons": listActionButtons.toJson(),
        "listWindowTitle": listWindowTitle.toJson(),
        "description": description,
        "newButtonForlist": newButtonForlist.toJson(),
        "listActionEditButtons": listActionEditButtons.toJson(),
        "headerActionButtons": headerActionButtons.toJson(),
        "printActionButtons": printActionButtons.toJson(),
        "listSearchIcon": listSearchIcon.toJson(),
        "viewTypeDropdown": viewTypeDropdown.toJson(),
        "quickAddButton": quickAddButton.toJson(),
        "quickAddButtonImage": quickAddButtonImage.toJson(),
        "linesActionButtons": linesActionButtons.toJson(),
        "listActionButtonImages": listActionButtonImages.toJson(),
      };
}

class ActionButtons {
  String border;
  String cursor;
  String backgroundColor;
  String color;
  String? paddingRight;
  String description;
  String marginLeft;
  String fontFamily;
  String borderRadius;
  String width;
  String paddingTop;
  int opacity;
  String? paddingLeft;
  int fontWeight;
  String height;

  ActionButtons({
    required this.border,
    required this.cursor,
    required this.backgroundColor,
    required this.color,
    this.paddingRight,
    required this.description,
    required this.marginLeft,
    required this.fontFamily,
    required this.borderRadius,
    required this.width,
    required this.paddingTop,
    required this.opacity,
    this.paddingLeft,
    required this.fontWeight,
    required this.height,
  });

  factory ActionButtons.fromJson(Map<String, dynamic> json) => ActionButtons(
        border: json["border"],
        cursor: json["cursor"],
        backgroundColor: json["backgroundColor"],
        color: json["color"],
        paddingRight: json["paddingRight"],
        description: json["description"],
        marginLeft: json["marginLeft"],
        fontFamily: json["fontFamily"],
        borderRadius: json["borderRadius"],
        width: json["width"],
        paddingTop: json["paddingTop"],
        opacity: json["opacity"],
        paddingLeft: json["paddingLeft"],
        fontWeight: json["fontWeight"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "cursor": cursor,
        "backgroundColor": backgroundColor,
        "color": color,
        "paddingRight": paddingRight,
        "description": description,
        "marginLeft": marginLeft,
        "fontFamily": fontFamily,
        "borderRadius": borderRadius,
        "width": width,
        "paddingTop": paddingTop,
        "opacity": opacity,
        "paddingLeft": paddingLeft,
        "fontWeight": fontWeight,
        "height": height,
      };
}

class LinesActionButtons {
  String border;
  String cursor;
  String borderRadius;
  String? background;
  String paddingRight;
  String width;
  String description;
  String? paddingTop;
  String paddingLeft;
  String height;
  String? marginRight;
  String? boxShadow;
  String? color;
  String? float;

  LinesActionButtons({
    required this.border,
    required this.cursor,
    required this.borderRadius,
    this.background,
    required this.paddingRight,
    required this.width,
    required this.description,
    this.paddingTop,
    required this.paddingLeft,
    required this.height,
    this.marginRight,
    this.boxShadow,
    this.color,
    this.float,
  });

  factory LinesActionButtons.fromJson(Map<String, dynamic> json) =>
      LinesActionButtons(
        border: json["border"],
        cursor: json["cursor"],
        borderRadius: json["borderRadius"],
        background: json["background"],
        paddingRight: json["paddingRight"],
        width: json["width"],
        description: json["description"],
        paddingTop: json["paddingTop"],
        paddingLeft: json["paddingLeft"],
        height: json["height"],
        marginRight: json["marginRight"],
        boxShadow: json["box-shadow"],
        color: json["color"],
        float: json["float"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "cursor": cursor,
        "borderRadius": borderRadius,
        "background": background,
        "paddingRight": paddingRight,
        "width": width,
        "description": description,
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
        "height": height,
        "marginRight": marginRight,
        "box-shadow": boxShadow,
        "color": color,
        "float": float,
      };
}

class ProfileInfo {
  String color;
  String description;
  String fontSize;
  String fontWeight;
  String? fontFamily;

  ProfileInfo({
    required this.color,
    required this.description,
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
        color: json["color"],
        description: json["description"],
        fontSize: json["fontSize"],
        fontWeight: json["fontWeight"],
        fontFamily: json["fontFamily"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "description": description,
        "fontSize": fontSize,
        "fontWeight": fontWeight,
        "fontFamily": fontFamily,
      };
}

class SearchIcon {
  String cursor;
  String color;
  String description;

  SearchIcon({
    required this.cursor,
    required this.color,
    required this.description,
  });

  factory SearchIcon.fromJson(Map<String, dynamic> json) => SearchIcon(
        cursor: json["cursor"],
        color: json["color"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "cursor": cursor,
        "color": color,
        "description": description,
      };
}

class ListWindowTitle {
  String whiteSpace;
  String overflow;
  String color;
  String width;
  String description;
  String fontSize;
  String marginBottom;
  String textOverflow;
  String position;
  String fontWeight;
  String marginTop;
  String maxWidth;

  ListWindowTitle({
    required this.whiteSpace,
    required this.overflow,
    required this.color,
    required this.width,
    required this.description,
    required this.fontSize,
    required this.marginBottom,
    required this.textOverflow,
    required this.position,
    required this.fontWeight,
    required this.marginTop,
    required this.maxWidth,
  });

  factory ListWindowTitle.fromJson(Map<String, dynamic> json) =>
      ListWindowTitle(
        whiteSpace: json["whiteSpace"],
        overflow: json["overflow"],
        color: json["color"],
        width: json["width"],
        description: json["description"],
        fontSize: json["fontSize"],
        marginBottom: json["marginBottom"],
        textOverflow: json["textOverflow"],
        position: json["position"],
        fontWeight: json["fontWeight"],
        marginTop: json["marginTop"],
        maxWidth: json["maxWidth"],
      );

  Map<String, dynamic> toJson() => {
        "whiteSpace": whiteSpace,
        "overflow": overflow,
        "color": color,
        "width": width,
        "description": description,
        "fontSize": fontSize,
        "marginBottom": marginBottom,
        "textOverflow": textOverflow,
        "position": position,
        "fontWeight": fontWeight,
        "marginTop": marginTop,
        "maxWidth": maxWidth,
      };
}

class NewButtonForlist {
  String border;
  String fontFamily;
  String borderRadius;
  String color;
  String background;
  String width;
  String description;
  String fontSize;
  String float;
  int opacity;
  int fontWeight;
  String height;

  NewButtonForlist({
    required this.border,
    required this.fontFamily,
    required this.borderRadius,
    required this.color,
    required this.background,
    required this.width,
    required this.description,
    required this.fontSize,
    required this.float,
    required this.opacity,
    required this.fontWeight,
    required this.height,
  });

  factory NewButtonForlist.fromJson(Map<String, dynamic> json) =>
      NewButtonForlist(
        border: json["border"],
        fontFamily: json["fontFamily"],
        borderRadius: json["borderRadius"],
        color: json["color"],
        background: json["background"],
        width: json["width"],
        description: json["description"],
        fontSize: json["fontSize"],
        float: json["float"],
        opacity: json["opacity"],
        fontWeight: json["fontWeight"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "fontFamily": fontFamily,
        "borderRadius": borderRadius,
        "color": color,
        "background": background,
        "width": width,
        "description": description,
        "fontSize": fontSize,
        "float": float,
        "opacity": opacity,
        "fontWeight": fontWeight,
        "height": height,
      };
}

class QuickAddButtonImage {
  String paddingRight;
  String description;
  String marginBottom;
  String paddingTop;
  String paddingLeft;

  QuickAddButtonImage({
    required this.paddingRight,
    required this.description,
    required this.marginBottom,
    required this.paddingTop,
    required this.paddingLeft,
  });

  factory QuickAddButtonImage.fromJson(Map<String, dynamic> json) =>
      QuickAddButtonImage(
        paddingRight: json["paddingRight"],
        description: json["description"],
        marginBottom: json["marginBottom"],
        paddingTop: json["paddingTop"],
        paddingLeft: json["paddingLeft"],
      );

  Map<String, dynamic> toJson() => {
        "paddingRight": paddingRight,
        "description": description,
        "marginBottom": marginBottom,
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
      };
}

class ViewTypeDropdown {
  String cursor;
  String fontFamily;
  String color;
  String description;
  String fontSize;
  String fontWeight;

  ViewTypeDropdown({
    required this.cursor,
    required this.fontFamily,
    required this.color,
    required this.description,
    required this.fontSize,
    required this.fontWeight,
  });

  factory ViewTypeDropdown.fromJson(Map<String, dynamic> json) =>
      ViewTypeDropdown(
        cursor: json["cursor"],
        fontFamily: json["fontFamily"],
        color: json["color"],
        description: json["description"],
        fontSize: json["fontSize"],
        fontWeight: json["fontWeight"],
      );

  Map<String, dynamic> toJson() => {
        "cursor": cursor,
        "fontFamily": fontFamily,
        "color": color,
        "description": description,
        "fontSize": fontSize,
        "fontWeight": fontWeight,
      };
}

class ListWindowTable {
  String minHeight;
  String description;
  String paddingTop;

  ListWindowTable({
    required this.minHeight,
    required this.description,
    required this.paddingTop,
  });

  factory ListWindowTable.fromJson(Map<String, dynamic> json) =>
      ListWindowTable(
        minHeight: json["minHeight"],
        description: json["description"],
        paddingTop: json["paddingTop"],
      );

  Map<String, dynamic> toJson() => {
        "minHeight": minHeight,
        "description": description,
        "paddingTop": paddingTop,
      };
}

class ContentWindowMainCard {
  String description;
  String fontSize;
  String marginTop;
  String marginLeft;

  ContentWindowMainCard({
    required this.description,
    required this.fontSize,
    required this.marginTop,
    required this.marginLeft,
  });

  factory ContentWindowMainCard.fromJson(Map<String, dynamic> json) =>
      ContentWindowMainCard(
        description: json["description"],
        fontSize: json["fontSize"],
        marginTop: json["marginTop"],
        marginLeft: json["marginLeft"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "fontSize": fontSize,
        "marginTop": marginTop,
        "marginLeft": marginLeft,
      };
}

class RecordWindow {
  LinesTab linesTab;
  String overflowX;
  String overflowY;
  String description;
  String requiredThing;
  RecordHeader recordHeader;
  RecordWindowMainCard mainCard;
  String height;

  RecordWindow({
    required this.linesTab,
    required this.overflowX,
    required this.overflowY,
    required this.description,
    required this.requiredThing,
    required this.recordHeader,
    required this.mainCard,
    required this.height,
  });

  factory RecordWindow.fromJson(Map<String, dynamic> json) => RecordWindow(
        linesTab: LinesTab.fromJson(json["linesTab"]),
        overflowX: json["overflowX"],
        overflowY: json["overflowY"],
        description: json["description"],
        requiredThing: json["requiredThing"],
        recordHeader: RecordHeader.fromJson(json["RecordHeader"]),
        mainCard: RecordWindowMainCard.fromJson(json["mainCard"]),
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "linesTab": linesTab.toJson(),
        "overflowX": overflowX,
        "overflowY": overflowY,
        "description": description,
        "requiredThing": requiredThing,
        "RecordHeader": recordHeader.toJson(),
        "mainCard": mainCard.toJson(),
        "height": height,
      };
}

class LinesTab {
  MainDiv mainDiv;
  LinesTable linesTable;
  LineTabIcons lineTabIcons;
  LinesAddNewButton linesAddNewButton;
  LinesSearchBar linesSearchBar;
  Button popUpNewButton;
  String description;
  TabStyle tabStyle;

  LinesTab({
    required this.mainDiv,
    required this.linesTable,
    required this.lineTabIcons,
    required this.linesAddNewButton,
    required this.linesSearchBar,
    required this.popUpNewButton,
    required this.description,
    required this.tabStyle,
  });

  factory LinesTab.fromJson(Map<String, dynamic> json) => LinesTab(
        mainDiv: MainDiv.fromJson(json["mainDiv"]),
        linesTable: LinesTable.fromJson(json["linesTable"]),
        lineTabIcons: LineTabIcons.fromJson(json["lineTabIcons"]),
        linesAddNewButton:
            LinesAddNewButton.fromJson(json["LinesAddNewButton"]),
        linesSearchBar: LinesSearchBar.fromJson(json["linesSearchBar"]),
        popUpNewButton: Button.fromJson(json["popUpNewButton"]),
        description: json["description"],
        tabStyle: TabStyle.fromJson(json["tabStyle"]),
      );

  Map<String, dynamic> toJson() => {
        "mainDiv": mainDiv.toJson(),
        "linesTable": linesTable.toJson(),
        "lineTabIcons": lineTabIcons.toJson(),
        "LinesAddNewButton": linesAddNewButton.toJson(),
        "linesSearchBar": linesSearchBar.toJson(),
        "popUpNewButton": popUpNewButton.toJson(),
        "description": description,
        "tabStyle": tabStyle.toJson(),
      };
}

class LineTabIcons {
  ReadOnlyViewColumn tabIconsMaximize;
  ReadOnlyViewColumn tabIconsMinimize;
  String paddingRight;
  String description;
  TabIconButtons tabIconButtons;

  LineTabIcons({
    required this.tabIconsMaximize,
    required this.tabIconsMinimize,
    required this.paddingRight,
    required this.description,
    required this.tabIconButtons,
  });

  factory LineTabIcons.fromJson(Map<String, dynamic> json) => LineTabIcons(
        tabIconsMaximize: ReadOnlyViewColumn.fromJson(json["tabIconsMaximize"]),
        tabIconsMinimize: ReadOnlyViewColumn.fromJson(json["tabIconsMinimize"]),
        paddingRight: json["paddingRight"],
        description: json["description"],
        tabIconButtons: TabIconButtons.fromJson(json["tabIconButtons"]),
      );

  Map<String, dynamic> toJson() => {
        "tabIconsMaximize": tabIconsMaximize.toJson(),
        "tabIconsMinimize": tabIconsMinimize.toJson(),
        "paddingRight": paddingRight,
        "description": description,
        "tabIconButtons": tabIconButtons.toJson(),
      };
}

class TabIconButtons {
  String border;
  String cursor;
  String boxShadow;
  String backgroundColor;
  String borderRadius;
  String paddingRight;
  String width;
  String description;
  String height;

  TabIconButtons({
    required this.border,
    required this.cursor,
    required this.boxShadow,
    required this.backgroundColor,
    required this.borderRadius,
    required this.paddingRight,
    required this.width,
    required this.description,
    required this.height,
  });

  factory TabIconButtons.fromJson(Map<String, dynamic> json) => TabIconButtons(
        border: json["border"],
        cursor: json["cursor"],
        boxShadow: json["boxShadow"],
        backgroundColor: json["backgroundColor"],
        borderRadius: json["borderRadius"],
        paddingRight: json["paddingRight"],
        width: json["width"],
        description: json["description"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "cursor": cursor,
        "boxShadow": boxShadow,
        "backgroundColor": backgroundColor,
        "borderRadius": borderRadius,
        "paddingRight": paddingRight,
        "width": width,
        "description": description,
        "height": height,
      };
}

class ReadOnlyViewColumn {
  String? paddingBottom;
  String paddingRight;
  String? paddingTop;
  String paddingLeft;
  String? description;

  ReadOnlyViewColumn({
    this.paddingBottom,
    required this.paddingRight,
    this.paddingTop,
    required this.paddingLeft,
    this.description,
  });

  factory ReadOnlyViewColumn.fromJson(Map<String, dynamic> json) =>
      ReadOnlyViewColumn(
        paddingBottom: json["paddingBottom"],
        paddingRight: json["paddingRight"],
        paddingTop: json["paddingTop"],
        paddingLeft: json["paddingLeft"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "paddingBottom": paddingBottom,
        "paddingRight": paddingRight,
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
        "description": description,
      };
}

class LinesAddNewButton {
  String border;
  String cursor;
  String padding;
  String boxShadow;
  String note;
  String backgroundColor;
  String color;
  String marginLeft;
  String fontFamily;
  String borderRadius;
  String top;
  String fontSize;
  int opacity;
  String marginTop;
  String fontWeight;

  LinesAddNewButton({
    required this.border,
    required this.cursor,
    required this.padding,
    required this.boxShadow,
    required this.note,
    required this.backgroundColor,
    required this.color,
    required this.marginLeft,
    required this.fontFamily,
    required this.borderRadius,
    required this.top,
    required this.fontSize,
    required this.opacity,
    required this.marginTop,
    required this.fontWeight,
  });

  factory LinesAddNewButton.fromJson(Map<String, dynamic> json) =>
      LinesAddNewButton(
        border: json["border"],
        cursor: json["cursor"],
        padding: json["padding"],
        boxShadow: json["boxShadow"],
        note: json["note"],
        backgroundColor: json["backgroundColor"],
        color: json["color"],
        marginLeft: json["marginLeft"],
        fontFamily: json["fontFamily"],
        borderRadius: json["borderRadius"],
        top: json["top"],
        fontSize: json["fontSize"],
        opacity: json["opacity"],
        marginTop: json["marginTop"],
        fontWeight: json["fontWeight"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "cursor": cursor,
        "padding": padding,
        "boxShadow": boxShadow,
        "note": note,
        "backgroundColor": backgroundColor,
        "color": color,
        "marginLeft": marginLeft,
        "fontFamily": fontFamily,
        "borderRadius": borderRadius,
        "top": top,
        "fontSize": fontSize,
        "opacity": opacity,
        "marginTop": marginTop,
        "fontWeight": fontWeight,
      };
}

class LinesSearchBar {
  String paddingBottom;
  IconUser iconUser;
  String paddingLeft;

  LinesSearchBar({
    required this.paddingBottom,
    required this.iconUser,
    required this.paddingLeft,
  });

  factory LinesSearchBar.fromJson(Map<String, dynamic> json) => LinesSearchBar(
        paddingBottom: json["paddingBottom"],
        iconUser: IconUser.fromJson(json["icon"]),
        paddingLeft: json["paddingLeft"],
      );

  Map<String, dynamic> toJson() => {
        "paddingBottom": paddingBottom,
        "icon": iconUser.toJson(),
        "paddingLeft": paddingLeft,
      };
}

class IconUser {
  String cursor;
  String paddingBottom;
  String color;
  String paddingRight;
  String opacity;

  IconUser({
    required this.cursor,
    required this.paddingBottom,
    required this.color,
    required this.paddingRight,
    required this.opacity,
  });

  factory IconUser.fromJson(Map<String, dynamic> json) => IconUser(
        cursor: json["cursor"],
        paddingBottom: json["paddingBottom"],
        color: json["color"],
        paddingRight: json["paddingRight"],
        opacity: json["opacity"],
      );

  Map<String, dynamic> toJson() => {
        "cursor": cursor,
        "paddingBottom": paddingBottom,
        "color": color,
        "paddingRight": paddingRight,
        "opacity": opacity,
      };
}

class LinesTable {
  String fontWeight;

  LinesTable({
    required this.fontWeight,
  });

  factory LinesTable.fromJson(Map<String, dynamic> json) => LinesTable(
        fontWeight: json["fontWeight"],
      );

  Map<String, dynamic> toJson() => {
        "fontWeight": fontWeight,
      };
}

class MainDiv {
  String boxShadow;
  String paddingBottom;
  String background;
  String paddingRight;
  String description;
  String marginBottom;
  String paddingTop;
  String paddingLeft;

  MainDiv({
    required this.boxShadow,
    required this.paddingBottom,
    required this.background,
    required this.paddingRight,
    required this.description,
    required this.marginBottom,
    required this.paddingTop,
    required this.paddingLeft,
  });

  factory MainDiv.fromJson(Map<String, dynamic> json) => MainDiv(
        boxShadow: json["boxShadow"],
        paddingBottom: json["paddingBottom"],
        background: json["background"],
        paddingRight: json["paddingRight"],
        description: json["description"],
        marginBottom: json["marginBottom"],
        paddingTop: json["paddingTop"],
        paddingLeft: json["paddingLeft"],
      );

  Map<String, dynamic> toJson() => {
        "boxShadow": boxShadow,
        "paddingBottom": paddingBottom,
        "background": background,
        "paddingRight": paddingRight,
        "description": description,
        "marginBottom": marginBottom,
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
      };
}

class Button {
  String boxShadow;
  String margin;
  String? borderRadius;
  String? color;
  String width;
  String description;
  String fontSize;
  String fontWeight;
  String height;
  String? border;

  Button({
    required this.boxShadow,
    required this.margin,
    this.borderRadius,
    this.color,
    required this.width,
    required this.description,
    required this.fontSize,
    required this.fontWeight,
    required this.height,
    this.border,
  });

  factory Button.fromJson(Map<String, dynamic> json) => Button(
        boxShadow: json["boxShadow"],
        margin: json["margin"],
        borderRadius: json["borderRadius"],
        color: json["color"],
        width: json["width"],
        description: json["description"],
        fontSize: json["fontSize"],
        fontWeight: json["fontWeight"],
        height: json["height"],
        border: json["border"],
      );

  Map<String, dynamic> toJson() => {
        "boxShadow": boxShadow,
        "margin": margin,
        "borderRadius": borderRadius,
        "color": color,
        "width": width,
        "description": description,
        "fontSize": fontSize,
        "fontWeight": fontWeight,
        "height": height,
        "border": border,
      };
}

class TabStyle {
  String background;
  String description;
  String marginBottom;

  TabStyle({
    required this.background,
    required this.description,
    required this.marginBottom,
  });

  factory TabStyle.fromJson(Map<String, dynamic> json) => TabStyle(
        background: json["background"],
        description: json["description"],
        marginBottom: json["marginBottom"],
      );

  Map<String, dynamic> toJson() => {
        "background": background,
        "description": description,
        "marginBottom": marginBottom,
      };
}

class RecordWindowMainCard {
  String overflowX;
  String margin;
  String overflowY;
  String background;
  String description;
  String height;

  RecordWindowMainCard({
    required this.overflowX,
    required this.margin,
    required this.overflowY,
    required this.background,
    required this.description,
    required this.height,
  });

  factory RecordWindowMainCard.fromJson(Map<String, dynamic> json) =>
      RecordWindowMainCard(
        overflowX: json["overflowX"],
        margin: json["margin"],
        overflowY: json["overflowY"],
        background: json["background"],
        description: json["description"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "overflowX": overflowX,
        "margin": margin,
        "overflowY": overflowY,
        "background": background,
        "description": description,
        "height": height,
      };
}

class RecordHeader {
  ProfileInfo recordTitle;
  AboveHeaderEditButtons aboveHeaderEditButtons;
  IconActionButtonDiv iconActionButtonDiv;
  ReadOnlyViewColumn readOnlyViewColumn;
  HeaderCard headerCard;
  RecordForm recordForm;
  StatusBar statusBar;
  RecordTitleDiv recordTitleDiv;
  FormViewButton formViewButton;
  StatusBarKeys statusBarKeys;
  BreadCrumb breadCrumb;
  ActionButtons iconActionButtons;
  BreadCrumb statusBarValues;

  RecordHeader({
    required this.recordTitle,
    required this.aboveHeaderEditButtons,
    required this.iconActionButtonDiv,
    required this.readOnlyViewColumn,
    required this.headerCard,
    required this.recordForm,
    required this.statusBar,
    required this.recordTitleDiv,
    required this.formViewButton,
    required this.statusBarKeys,
    required this.breadCrumb,
    required this.iconActionButtons,
    required this.statusBarValues,
  });

  factory RecordHeader.fromJson(Map<String, dynamic> json) => RecordHeader(
        recordTitle: ProfileInfo.fromJson(json["recordTitle"]),
        aboveHeaderEditButtons:
            AboveHeaderEditButtons.fromJson(json["aboveHeaderEditButtons"]),
        iconActionButtonDiv:
            IconActionButtonDiv.fromJson(json["iconActionButtonDiv"]),
        readOnlyViewColumn:
            ReadOnlyViewColumn.fromJson(json["readOnlyViewColumn"]),
        headerCard: HeaderCard.fromJson(json["headerCard"]),
        recordForm: RecordForm.fromJson(json["RecordForm"]),
        statusBar: StatusBar.fromJson(json["StatusBar"]),
        recordTitleDiv: RecordTitleDiv.fromJson(json["recordTitleDiv"]),
        formViewButton: FormViewButton.fromJson(json["formViewButton"]),
        statusBarKeys: StatusBarKeys.fromJson(json["statusBarKeys"]),
        breadCrumb: BreadCrumb.fromJson(json["breadCrumb"]),
        iconActionButtons: ActionButtons.fromJson(json["iconActionButtons"]),
        statusBarValues: BreadCrumb.fromJson(json["statusBarValues"]),
      );

  Map<String, dynamic> toJson() => {
        "recordTitle": recordTitle.toJson(),
        "aboveHeaderEditButtons": aboveHeaderEditButtons.toJson(),
        "iconActionButtonDiv": iconActionButtonDiv.toJson(),
        "readOnlyViewColumn": readOnlyViewColumn.toJson(),
        "headerCard": headerCard.toJson(),
        "RecordForm": recordForm.toJson(),
        "StatusBar": statusBar.toJson(),
        "recordTitleDiv": recordTitleDiv.toJson(),
        "formViewButton": formViewButton.toJson(),
        "statusBarKeys": statusBarKeys.toJson(),
        "breadCrumb": breadCrumb.toJson(),
        "iconActionButtons": iconActionButtons.toJson(),
        "statusBarValues": statusBarValues.toJson(),
      };
}

class AboveHeaderEditButtons {
  String border;
  String cursor;
  String color;
  String borderRadius;
  String width;
  String description;
  int opacity;
  int fontWeight;
  String height;
  String marginLeft;

  AboveHeaderEditButtons({
    required this.border,
    required this.cursor,
    required this.color,
    required this.borderRadius,
    required this.width,
    required this.description,
    required this.opacity,
    required this.fontWeight,
    required this.height,
    required this.marginLeft,
  });

  factory AboveHeaderEditButtons.fromJson(Map<String, dynamic> json) =>
      AboveHeaderEditButtons(
        border: json["border"],
        cursor: json["cursor"],
        color: json["color"],
        borderRadius: json["borderRadius"],
        width: json["width"],
        description: json["description"],
        opacity: json["opacity"],
        fontWeight: json["fontWeight"],
        height: json["height"],
        marginLeft: json["marginLeft"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "cursor": cursor,
        "color": color,
        "borderRadius": borderRadius,
        "width": width,
        "description": description,
        "opacity": opacity,
        "fontWeight": fontWeight,
        "height": height,
        "marginLeft": marginLeft,
      };
}

class BreadCrumb {
  String? paddingBottom;
  String? fontFamily;
  String color;
  String description;
  String fontSize;
  String paddingTop;
  String paddingLeft;
  String fontWeight;

  BreadCrumb({
    this.paddingBottom,
    this.fontFamily,
    required this.color,
    required this.description,
    required this.fontSize,
    required this.paddingTop,
    required this.paddingLeft,
    required this.fontWeight,
  });

  factory BreadCrumb.fromJson(Map<String, dynamic> json) => BreadCrumb(
        paddingBottom: json["paddingBottom"],
        fontFamily: json["fontFamily"],
        color: json["color"],
        description: json["description"],
        fontSize: json["fontSize"],
        paddingTop: json["paddingTop"],
        paddingLeft: json["paddingLeft"],
        fontWeight: json["fontWeight"],
      );

  Map<String, dynamic> toJson() => {
        "paddingBottom": paddingBottom,
        "fontFamily": fontFamily,
        "color": color,
        "description": description,
        "fontSize": fontSize,
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
        "fontWeight": fontWeight,
      };
}

class FormViewButton {
  ActionButtonMenu actionButtonMenu;
  String description;
  FormTopButtons formTopButtons;

  FormViewButton({
    required this.actionButtonMenu,
    required this.description,
    required this.formTopButtons,
  });

  factory FormViewButton.fromJson(Map<String, dynamic> json) => FormViewButton(
        actionButtonMenu: ActionButtonMenu.fromJson(json["actionButtonMenu"]),
        description: json["description"],
        formTopButtons: FormTopButtons.fromJson(json["formTopButtons"]),
      );

  Map<String, dynamic> toJson() => {
        "actionButtonMenu": actionButtonMenu.toJson(),
        "description": description,
        "formTopButtons": formTopButtons.toJson(),
      };
}

class ActionButtonMenu {
  String marginRight;
  String background;
  String marginLeft;

  ActionButtonMenu({
    required this.marginRight,
    required this.background,
    required this.marginLeft,
  });

  factory ActionButtonMenu.fromJson(Map<String, dynamic> json) =>
      ActionButtonMenu(
        marginRight: json["marginRight"],
        background: json["background"],
        marginLeft: json["marginLeft"],
      );

  Map<String, dynamic> toJson() => {
        "marginRight": marginRight,
        "background": background,
        "marginLeft": marginLeft,
      };
}

class FormTopButtons {
  String borderRadius;
  String color;
  String textAlign;
  String width;
  String minWidth;
  int opacity;
  int fontWeight;

  FormTopButtons({
    required this.borderRadius,
    required this.color,
    required this.textAlign,
    required this.width,
    required this.minWidth,
    required this.opacity,
    required this.fontWeight,
  });

  factory FormTopButtons.fromJson(Map<String, dynamic> json) => FormTopButtons(
        borderRadius: json["borderRadius"],
        color: json["color"],
        textAlign: json["textAlign"],
        width: json["width"],
        minWidth: json["minWidth"],
        opacity: json["opacity"],
        fontWeight: json["fontWeight"],
      );

  Map<String, dynamic> toJson() => {
        "borderRadius": borderRadius,
        "color": color,
        "textAlign": textAlign,
        "width": width,
        "minWidth": minWidth,
        "opacity": opacity,
        "fontWeight": fontWeight,
      };
}

class HeaderCard {
  String border;
  String boxShadow;
  String borderRadius;
  String description;
  String marginBottom;
  String marginTop;

  HeaderCard({
    required this.border,
    required this.boxShadow,
    required this.borderRadius,
    required this.description,
    required this.marginBottom,
    required this.marginTop,
  });

  factory HeaderCard.fromJson(Map<String, dynamic> json) => HeaderCard(
        border: json["border"],
        boxShadow: json["boxShadow"],
        borderRadius: json["borderRadius"],
        description: json["description"],
        marginBottom: json["marginBottom"],
        marginTop: json["marginTop"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "boxShadow": boxShadow,
        "borderRadius": borderRadius,
        "description": description,
        "marginBottom": marginBottom,
        "marginTop": marginTop,
      };
}

class IconActionButtonDiv {
  String description;
  String float;
  String marginTop;

  IconActionButtonDiv({
    required this.description,
    required this.float,
    required this.marginTop,
  });

  factory IconActionButtonDiv.fromJson(Map<String, dynamic> json) =>
      IconActionButtonDiv(
        description: json["description"],
        float: json["float"],
        marginTop: json["marginTop"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "float": float,
        "marginTop": marginTop,
      };
}

class RecordForm {
  CollapsePanel collapsePanel;
  String paddingBottom;
  String paddingRight;
  String description;
  String paddingTop;
  String paddingLeft;

  RecordForm({
    required this.collapsePanel,
    required this.paddingBottom,
    required this.paddingRight,
    required this.description,
    required this.paddingTop,
    required this.paddingLeft,
  });

  factory RecordForm.fromJson(Map<String, dynamic> json) => RecordForm(
      collapsePanel: CollapsePanel.fromJson(json["collapsePanel"]),
      paddingBottom: json["paddingBottom"],
      paddingRight: json["paddingRight"],
      description: json["description"],
      paddingTop: json["paddingTop"],
      paddingLeft: json["paddingLeft"]);

  Map<String, dynamic> toJson() => {
        "collapsePanel": collapsePanel.toJson(),
        "paddingBottom": paddingBottom,
        "paddingRight": paddingRight,
        "description": description,
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
      };
}

class CollapsePanel {
  String border;

  CollapsePanel({
    required this.border,
  });

  factory CollapsePanel.fromJson(Map<String, dynamic> json) => CollapsePanel(
        border: json["border"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
      };
}

class FormItem {
  String marginBottom;

  FormItem({
    required this.marginBottom,
  });

  factory FormItem.fromJson(Map<String, dynamic> json) => FormItem(
        marginBottom: json["marginBottom"],
      );

  Map<String, dynamic> toJson() => {
        "marginBottom": marginBottom,
      };
}

class SelectTag {
  String width;

  SelectTag({
    required this.width,
  });

  factory SelectTag.fromJson(Map<String, dynamic> json) => SelectTag(
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
      };
}

class RecordTitleDiv {
  String whiteSpace;
  String overflow;
  String width;
  String description;
  String textOverflow;
  String position;
  String maxWidth;

  RecordTitleDiv({
    required this.whiteSpace,
    required this.overflow,
    required this.width,
    required this.description,
    required this.textOverflow,
    required this.position,
    required this.maxWidth,
  });

  factory RecordTitleDiv.fromJson(Map<String, dynamic> json) => RecordTitleDiv(
        whiteSpace: json["whiteSpace"],
        overflow: json["overflow"],
        width: json["width"],
        description: json["description"],
        textOverflow: json["textOverflow"],
        position: json["position"],
        maxWidth: json["maxWidth"],
      );

  Map<String, dynamic> toJson() => {
        "whiteSpace": whiteSpace,
        "overflow": overflow,
        "width": width,
        "description": description,
        "textOverflow": textOverflow,
        "position": position,
        "maxWidth": maxWidth,
      };
}

class StatusBar {
  String marginRight;
  String overflowX;
  String paddingBottom;
  String background;
  String paddingRight;
  String width;
  String description;
  String paddingTop;
  String paddingLeft;
  String marginLeft;
  String maxWidth;

  StatusBar({
    required this.marginRight,
    required this.overflowX,
    required this.paddingBottom,
    required this.background,
    required this.paddingRight,
    required this.width,
    required this.description,
    required this.paddingTop,
    required this.paddingLeft,
    required this.marginLeft,
    required this.maxWidth,
  });

  factory StatusBar.fromJson(Map<String, dynamic> json) => StatusBar(
        marginRight: json["marginRight"],
        overflowX: json["overflowX"],
        paddingBottom: json["paddingBottom"],
        background: json["background"],
        paddingRight: json["paddingRight"],
        width: json["width"],
        description: json["description"],
        paddingTop: json["paddingTop"],
        paddingLeft: json["paddingLeft"],
        marginLeft: json["marginLeft"],
        maxWidth: json["maxWidth"],
      );

  Map<String, dynamic> toJson() => {
        "marginRight": marginRight,
        "overflowX": overflowX,
        "paddingBottom": paddingBottom,
        "background": background,
        "paddingRight": paddingRight,
        "width": width,
        "description": description,
        "paddingTop": paddingTop,
        "paddingLeft": paddingLeft,
        "marginLeft": marginLeft,
        "maxWidth": maxWidth,
      };
}

class StatusBarKeys {
  String whiteSpace;
  String overflow;
  String color;
  String description;
  String fontSize;
  String position;
  String textOverflow;
  String fontWeight;

  StatusBarKeys({
    required this.whiteSpace,
    required this.overflow,
    required this.color,
    required this.description,
    required this.fontSize,
    required this.position,
    required this.textOverflow,
    required this.fontWeight,
  });

  factory StatusBarKeys.fromJson(Map<String, dynamic> json) => StatusBarKeys(
        whiteSpace: json["whiteSpace"],
        overflow: json["overflow"],
        color: json["color"],
        description: json["description"],
        fontSize: json["fontSize"],
        position: json["position"],
        textOverflow: json["textOverflow"],
        fontWeight: json["fontWeight"],
      );

  Map<String, dynamic> toJson() => {
        "whiteSpace": whiteSpace,
        "overflow": overflow,
        "color": color,
        "description": description,
        "fontSize": fontSize,
        "position": position,
        "textOverflow": textOverflow,
        "fontWeight": fontWeight,
      };
}

class Header {
  String backgroundColor;
  String description;

  Header({
    required this.backgroundColor,
    required this.description,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        backgroundColor: json["backgroundColor"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "backgroundColor": backgroundColor,
        "description": description,
      };
}

class NavBar {
  ProfileInfo profileName;
  LogoutCardStyle logoutCardStyle;
  BusinessUnit businessUnit;
  ProfileInfo profileInfo;
  LogoStyles navbarIcons;
  LogoStyles navbarEmailIcon;
  BusinessUnit roles;
  LogoStyles navbarDashboardIcon;
  LogoutButton logoutButton;
  ContentCard profileIcon;
  LogoStyles navbarSettingIcon;
  Button applyButton;
  Button cancelButton;
  LogoStyles toggleStyles;
  LogoStyles logoStyles;

  NavBar({
    required this.profileName,
    required this.logoutCardStyle,
    required this.businessUnit,
    required this.profileInfo,
    required this.navbarIcons,
    required this.navbarEmailIcon,
    required this.roles,
    required this.navbarDashboardIcon,
    required this.logoutButton,
    required this.profileIcon,
    required this.navbarSettingIcon,
    required this.applyButton,
    required this.cancelButton,
    required this.toggleStyles,
    required this.logoStyles,
  });

  factory NavBar.fromJson(Map<String, dynamic> json) => NavBar(
        profileName: ProfileInfo.fromJson(json["profileName"]),
        logoutCardStyle: LogoutCardStyle.fromJson(json["logoutCardStyle"]),
        businessUnit: BusinessUnit.fromJson(json["businessUnit"]),
        profileInfo: ProfileInfo.fromJson(json["profileInfo"]),
        navbarIcons: LogoStyles.fromJson(json["navbarIcons"]),
        navbarEmailIcon: LogoStyles.fromJson(json["navbarEmailIcon"]),
        roles: BusinessUnit.fromJson(json["roles"]),
        navbarDashboardIcon: LogoStyles.fromJson(json["navbarDashboardIcon"]),
        logoutButton: LogoutButton.fromJson(json["logoutButton"]),
        profileIcon: ContentCard.fromJson(json["profileIcon"]),
        navbarSettingIcon: LogoStyles.fromJson(json["navbarSettingIcon"]),
        applyButton: Button.fromJson(json["applyButton"]),
        cancelButton: Button.fromJson(json["cancelButton"]),
        toggleStyles: LogoStyles.fromJson(json["toggleStyles"]),
        logoStyles: LogoStyles.fromJson(json["logoStyles"]),
      );

  Map<String, dynamic> toJson() => {
        "profileName": profileName.toJson(),
        "logoutCardStyle": logoutCardStyle.toJson(),
        "businessUnit": businessUnit.toJson(),
        "profileInfo": profileInfo.toJson(),
        "navbarIcons": navbarIcons.toJson(),
        "navbarEmailIcon": navbarEmailIcon.toJson(),
        "roles": roles.toJson(),
        "navbarDashboardIcon": navbarDashboardIcon.toJson(),
        "logoutButton": logoutButton.toJson(),
        "profileIcon": profileIcon.toJson(),
        "navbarSettingIcon": navbarSettingIcon.toJson(),
        "applyButton": applyButton.toJson(),
        "cancelButton": cancelButton.toJson(),
        "toggleStyles": toggleStyles.toJson(),
        "logoStyles": logoStyles.toJson(),
      };
}

class BusinessUnit {
  String description;
  String marginBottom;

  BusinessUnit({
    required this.description,
    required this.marginBottom,
  });

  factory BusinessUnit.fromJson(Map<String, dynamic> json) => BusinessUnit(
        description: json["description"],
        marginBottom: json["marginBottom"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "marginBottom": marginBottom,
      };
}

class LogoStyles {
  String paddingBottom;
  String width;
  String description;
  String? marginLeft;
  String? cursor;

  LogoStyles({
    required this.paddingBottom,
    required this.width,
    required this.description,
    this.marginLeft,
    this.cursor,
  });

  factory LogoStyles.fromJson(Map<String, dynamic> json) => LogoStyles(
        paddingBottom: json["paddingBottom"],
        width: json["width"],
        description: json["description"],
        marginLeft: json["marginLeft"],
        cursor: json["cursor"],
      );

  Map<String, dynamic> toJson() => {
        "paddingBottom": paddingBottom,
        "width": width,
        "description": description,
        "marginLeft": marginLeft,
        "cursor": cursor,
      };
}

class LogoutButton {
  LogoutText logoutText;
  LogoutIcon logoutIcon;
  String description;
  String marginBottom;
  String marginTop;
  String marginLeft;

  LogoutButton({
    required this.logoutText,
    required this.logoutIcon,
    required this.description,
    required this.marginBottom,
    required this.marginTop,
    required this.marginLeft,
  });

  factory LogoutButton.fromJson(Map<String, dynamic> json) => LogoutButton(
        logoutText: LogoutText.fromJson(json["logoutText"]),
        logoutIcon: LogoutIcon.fromJson(json["logoutIcon"]),
        description: json["description"],
        marginBottom: json["marginBottom"],
        marginTop: json["marginTop"],
        marginLeft: json["marginLeft"],
      );

  Map<String, dynamic> toJson() => {
        "logoutText": logoutText.toJson(),
        "logoutIcon": logoutIcon.toJson(),
        "description": description,
        "marginBottom": marginBottom,
        "marginTop": marginTop,
        "marginLeft": marginLeft,
      };
}

class LogoutIcon {
  String marginRight;
  String color;
  String fontSize;

  LogoutIcon({
    required this.marginRight,
    required this.color,
    required this.fontSize,
  });

  factory LogoutIcon.fromJson(Map<String, dynamic> json) => LogoutIcon(
        marginRight: json["marginRight"],
        color: json["color"],
        fontSize: json["fontSize"],
      );

  Map<String, dynamic> toJson() => {
        "marginRight": marginRight,
        "color": color,
        "fontSize": fontSize,
      };
}

class LogoutText {
  String color;
  String fontSize;

  LogoutText({
    required this.color,
    required this.fontSize,
  });

  factory LogoutText.fromJson(Map<String, dynamic> json) => LogoutText(
        color: json["color"],
        fontSize: json["fontSize"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "fontSize": fontSize,
      };
}

class LogoutCardStyle {
  String border;
  String boxShadow;
  String padding;
  String width;
  String description;

  LogoutCardStyle({
    required this.border,
    required this.boxShadow,
    required this.padding,
    required this.width,
    required this.description,
  });

  factory LogoutCardStyle.fromJson(Map<String, dynamic> json) =>
      LogoutCardStyle(
        border: json["border"],
        boxShadow: json["boxShadow"],
        padding: json["padding"],
        width: json["width"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "border": border,
        "boxShadow": boxShadow,
        "padding": padding,
        "width": width,
        "description": description,
      };
}

class SideMenu {
  SearchIcon sideMenuSearchIcon;
  String backgroundColor;
  SideMenuCard sideMenuCard;
  String description;
  String height;

  SideMenu({
    required this.sideMenuSearchIcon,
    required this.backgroundColor,
    required this.sideMenuCard,
    required this.description,
    required this.height,
  });

  factory SideMenu.fromJson(Map<String, dynamic> json) => SideMenu(
        sideMenuSearchIcon: SearchIcon.fromJson(json["sideMenuSearchIcon"]),
        backgroundColor: json["backgroundColor"],
        sideMenuCard: SideMenuCard.fromJson(json["sideMenuCard"]),
        description: json["description"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "sideMenuSearchIcon": sideMenuSearchIcon.toJson(),
        "backgroundColor": backgroundColor,
        "sideMenuCard": sideMenuCard.toJson(),
        "description": description,
        "height": height,
      };
}

class SideMenuCard {
  String marginRight;
  String backgroundColor;
  String borderRadius;
  String paddingRight;
  String description;
  String position;
  String height;

  SideMenuCard({
    required this.marginRight,
    required this.backgroundColor,
    required this.borderRadius,
    required this.paddingRight,
    required this.description,
    required this.position,
    required this.height,
  });

  factory SideMenuCard.fromJson(Map<String, dynamic> json) => SideMenuCard(
        marginRight: json["marginRight"],
        backgroundColor: json["backgroundColor"],
        borderRadius: json["borderRadius"],
        paddingRight: json["paddingRight"],
        description: json["description"],
        position: json["position"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "marginRight": marginRight,
        "backgroundColor": backgroundColor,
        "borderRadius": borderRadius,
        "paddingRight": paddingRight,
        "description": description,
        "position": position,
        "height": height,
      };
}
