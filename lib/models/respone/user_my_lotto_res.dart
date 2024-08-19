import 'dart:convert';
// To parse this JSON data, do
//
//     final userMyLottoRespone = userMyLottoResponeFromJson(jsonString);


UserMyLottoRespone userMyLottoResponeFromJson(String str) => UserMyLottoRespone.fromJson(json.decode(str));

String userMyLottoResponeToJson(UserMyLottoRespone data) => json.encode(data.toJson());

class UserMyLottoRespone {
    String message;
    List<Datum> data;

    UserMyLottoRespone({
        required this.message,
        required this.data,
    });

    factory UserMyLottoRespone.fromJson(Map<String, dynamic> json) => UserMyLottoRespone(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int lottoid;
    String number;
    String price;
    String result;
    int uidFk;

    Datum({
        required this.lottoid,
        required this.number,
        required this.price,
        required this.result,
        required this.uidFk,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        lottoid: json["lottoid"],
        number: json["number"],
        price: json["price"],
        result: json["result"],
        uidFk: json["uid_fk"],
    );

    Map<String, dynamic> toJson() => {
        "lottoid": lottoid,
        "number": number,
        "price": price,
        "result": result,
        "uid_fk": uidFk,
    };
}
