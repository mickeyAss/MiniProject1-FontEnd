import 'dart:convert';
// To parse this JSON data, do
//
//     final userMyLottoRespone = userMyLottoResponeFromJson(jsonString);


UserMyLottoRespone userMyLottoResponeFromJson(String str) => UserMyLottoRespone.fromJson(json.decode(str));

String userMyLottoResponeToJson(UserMyLottoRespone data) => json.encode(data.toJson());

class UserMyLottoRespone {
    List<Result> result;

    UserMyLottoRespone({
        required this.result,
    });

    factory UserMyLottoRespone.fromJson(Map<String, dynamic> json) => UserMyLottoRespone(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
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
    };
}
