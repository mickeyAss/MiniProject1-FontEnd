import 'dart:convert';
// To parse this JSON data, do
//
//     final userMyLottoRespone = userMyLottoResponeFromJson(jsonString);

List<UserMyLottoRespone> userMyLottoResponeFromJson(String str) =>
    List<UserMyLottoRespone>.from(
        json.decode(str).map((x) => UserMyLottoRespone.fromJson(x)));

String userMyLottoResponeToJson(List<UserMyLottoRespone> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserMyLottoRespone {
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

  UserMyLottoRespone({
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

  factory UserMyLottoRespone.fromJson(Map<String, dynamic> json) =>
      UserMyLottoRespone(
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
