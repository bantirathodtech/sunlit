// filename: access_token.dart

import 'dart:convert';

AccessToken accessTokenFromJson(String str) =>
    AccessToken.fromJson(json.decode(str));
String accessTokenToJson(AccessToken accessToken) =>
    json.encode(accessToken.toJson());

class AccessToken {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  String? userName;
  String? userId;
  String? password;
  String? loginTime;
  String? userEmail;
  bool? webAuth;

  AccessToken(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.userName,
      this.userId,
      this.password,
      this.loginTime,
      this.userEmail,
      this.webAuth});

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
      accessToken: json["accessToken"],
      tokenType: json["tokenType"],
      refreshToken: json["refreshToken"],
      userName: json["username"],
      userId: json["userId"],
      password: json["password"],
      loginTime: json["loginTime"],
      userEmail: json["email"],
      webAuth: json["webAuth"]);

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "tokenType": tokenType,
        "refreshToken": refreshToken,
        "username": userName,
        "userId": userId,
        "password": password,
        "loginTime": loginTime,
        "email": userEmail,
        "webAuth": webAuth,
      };
}
