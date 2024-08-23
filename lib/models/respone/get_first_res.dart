import 'dart:convert';
// To parse this JSON data, do
//
//     final getFristRespone = getFristResponeFromJson(jsonString);


List<GetFristRespone> getFristResponeFromJson(String str) => List<GetFristRespone>.from(json.decode(str).map((x) => GetFristRespone.fromJson(x)));

String getFristResponeToJson(List<GetFristRespone> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFristRespone {
    int lottoid;
    String number;
    String price;
    String result;
    dynamic uidFk;

    GetFristRespone({
        required this.lottoid,
        required this.number,
        required this.price,
        required this.result,
        required this.uidFk,
    });

    factory GetFristRespone.fromJson(Map<String, dynamic> json) => GetFristRespone(
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
