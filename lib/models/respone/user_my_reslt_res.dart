import 'dart:convert';
// To parse this JSON data, do
//
//     final userMyresultRespone = userMyresultResponeFromJson(jsonString);


UserMyresultRespone userMyresultResponeFromJson(String str) => UserMyresultRespone.fromJson(json.decode(str));

String userMyresultResponeToJson(UserMyresultRespone data) => json.encode(data.toJson());

class UserMyresultRespone {
    String message;
    List<Result> result;
    int prizeAmount;

    UserMyresultRespone({
        required this.message,
        required this.result,
        required this.prizeAmount,
    });

    factory UserMyresultRespone.fromJson(Map<String, dynamic> json) => UserMyresultRespone(
        message: json["message"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        prizeAmount: json["prizeAmount"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "prizeAmount": prizeAmount,
    };
}

class Result {
    int uid;
    String name;
    String surname;
    String phone;
    String email;
    String password;
    String image;
    String wallet;
    String type;
    int lottoid;
    String number;
    String price;
    String result;
    int uidFk;
    String prize;

    Result({
        required this.uid,
        required this.name,
        required this.surname,
        required this.phone,
        required this.email,
        required this.password,
        required this.image,
        required this.wallet,
        required this.type,
        required this.lottoid,
        required this.number,
        required this.price,
        required this.result,
        required this.uidFk,
        required this.prize,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        uid: json["uid"],
        name: json["name"],
        surname: json["surname"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        wallet: json["wallet"],
        type: json["type"],
        lottoid: json["lottoid"],
        number: json["number"],
        price: json["price"],
        result: json["result"],
        uidFk: json["uid_fk"],
        prize: json["prize"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "surname": surname,
        "phone": phone,
        "email": email,
        "password": password,
        "image": image,
        "wallet": wallet,
        "type": type,
        "lottoid": lottoid,
        "number": number,
        "price": price,
        "result": result,
        "uid_fk": uidFk,
        "prize": prize,
    };
}
