import 'dart:convert';
// To parse this JSON data, do
//
//     final userLoginPostReq = userLoginPostReqFromJson(jsonString);

UserLoginPostReq userLoginPostReqFromJson(String str) =>
    UserLoginPostReq.fromJson(json.decode(str));

String userLoginPostReqToJson(UserLoginPostReq data) =>
    json.encode(data.toJson());

class UserLoginPostReq {
  String email;
  String password;

  UserLoginPostReq({
    required this.email,
    required this.password,
  });

  factory UserLoginPostReq.fromJson(Map<String, dynamic> json) =>
      UserLoginPostReq(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
