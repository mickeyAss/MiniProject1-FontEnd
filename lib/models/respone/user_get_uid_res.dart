import 'dart:convert';
// To parse this JSON data, do
//
//     final userlGetUidRespone = userlGetUidResponeFromJson(jsonString);


UserlGetUidRespone userlGetUidResponeFromJson(String str) => UserlGetUidRespone.fromJson(json.decode(str));

String userlGetUidResponeToJson(UserlGetUidRespone data) => json.encode(data.toJson());

class UserlGetUidRespone {
    int uid;
    String name;
    String surname;
    String email;
    String password;
    String phone;
    dynamic image;
    dynamic wallet;
    String type;

    UserlGetUidRespone({
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

    factory UserlGetUidRespone.fromJson(Map<String, dynamic> json) => UserlGetUidRespone(
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
