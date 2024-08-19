import 'dart:convert';
// To parse this JSON data, do
//
//     final numberGetRespone = numberGetResponeFromJson(jsonString);


List<NumberGetRespone> numberGetResponeFromJson(String str) => List<NumberGetRespone>.from(json.decode(str).map((x) => NumberGetRespone.fromJson(x)));

String numberGetResponeToJson(List<NumberGetRespone> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NumberGetRespone {
    int lottoid;
    String number;
    String price;
    String result;
    dynamic uidFk;

    NumberGetRespone({
        required this.lottoid,
        required this.number,
        required this.price,
        required this.result,
        required this.uidFk,
    });

    factory NumberGetRespone.fromJson(Map<String, dynamic> json) => NumberGetRespone(
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
