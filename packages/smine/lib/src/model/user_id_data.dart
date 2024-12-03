import 'dart:convert';

UserIdData userIdDataFromJson(String str) =>
    UserIdData.fromJson(json.decode(str));

String userIdDataToJson(UserIdData userInfo) => json.encode(userInfo.toJson());

List<UserIdData> getDataFromUserInfoFromData(String str) =>
    List<UserIdData>.from(json.decode(str).map((x) => UserIdData.fromJson(x)));

String getDataFromUserInfoToData(List<UserIdData> dataList) =>
    json.encode(List<dynamic>.from(dataList.map((x) => x.toJson())));

class UserIdData {
  String? defaultCsBunitId;
  String? password;
  String? csRole;
  String? name;
  String? csUserId;
  String? username;

  UserIdData({
    this.defaultCsBunitId,
    this.password,
    this.csRole,
    this.name,
    this.csUserId,
    this.username,
  });

  factory UserIdData.fromJson(Map<String, dynamic> json) {
    return UserIdData(
      defaultCsBunitId: json['default_cs_bunit_id'] ?? '',
      password: json['password'] ?? '',
      csRole: json['cs_role'] ?? '',
      name: json['name'] ?? '',
      csUserId: json['cs_user_id'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_cs_bunit_id': defaultCsBunitId,
      'password': password,
      'cs_role': csRole,
      'name': name,
      'cs_user_id': csUserId,
      'username': username,
    };
  }
}
