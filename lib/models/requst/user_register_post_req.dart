import 'dart:convert';
// To parse this JSON data, do
//
//     final userRegisterPostReq = userRegisterPostReqFromJson(jsonString);


UserRegisterPostReq userRegisterPostReqFromJson(String str) => UserRegisterPostReq.fromJson(json.decode(str));

String userRegisterPostReqToJson(UserRegisterPostReq data) => json.encode(data.toJson());

class UserRegisterPostReq {
    String email;
    String password;
    String name;
    String surname;
    String phone;
    String wallet;

    UserRegisterPostReq({
        required this.email,
        required this.password,
        required this.name,
        required this.surname,
        required this.phone,
        required this.wallet,
    });

    factory UserRegisterPostReq.fromJson(Map<String, dynamic> json) => UserRegisterPostReq(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        surname: json["surname"],
        phone: json["phone"],
        wallet: json["wallet"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "surname": surname,
        "phone": phone,
        "wallet": wallet,
    };
}
