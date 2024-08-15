import 'dart:convert';
// To parse this JSON data, do
//
//     final userLoginPostReq = userLoginPostReqFromJson(jsonString);


UserLoginPostReq userLoginPostReqFromJson(String str) => UserLoginPostReq.fromJson(json.decode(str));

String userLoginPostReqToJson(UserLoginPostReq data) => json.encode(data.toJson());

class UserLoginPostReq {
    String phone;
    String password;

    UserLoginPostReq({
        required this.phone,
        required this.password,
    });

    factory UserLoginPostReq.fromJson(Map<String, dynamic> json) => UserLoginPostReq(
        phone: json["phone"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
    };
}
