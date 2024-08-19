import 'dart:convert';
// To parse this JSON data, do
//
//     final userloginPostRespone = userloginPostResponeFromJson(jsonString);


UserloginPostRespone userloginPostResponeFromJson(String str) => UserloginPostRespone.fromJson(json.decode(str));

String userloginPostResponeToJson(UserloginPostRespone data) => json.encode(data.toJson());

class UserloginPostRespone {
    String message;
    List<Result> result;
    String userType;
    String token;

    UserloginPostRespone({
        required this.message,
        required this.result,
        required this.userType,
        required this.token,
    });

    factory UserloginPostRespone.fromJson(Map<String, dynamic> json) => UserloginPostRespone(
        message: json["message"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        userType: json["userType"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "userType": userType,
        "token": token,
    };
}

class Result {
    int uid;
    String name;
    String surname;
    String email;
    String password;
    String phone;
    dynamic image;
    dynamic wallet;
    String type;

    Result({
        required this.uid,
        required this.name,
        required this.surname,
        required this.email,
        required this.password,
        required this.phone,
        required this.image,
        required this.wallet,
        required this.type,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        uid: json["uid"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        image: json["image"],
        wallet: json["wallet"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "phone": phone,
        "image": image,
        "wallet": wallet,
        "type": type,
    };
}
