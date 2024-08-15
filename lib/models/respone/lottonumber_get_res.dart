import 'dart:convert';
// To parse this JSON data, do
//
//     final lottoNumberGetRespone = lottoNumberGetResponeFromJson(jsonString);


List<LottoNumberGetRespone> lottoNumberGetResponeFromJson(String str) => List<LottoNumberGetRespone>.from(json.decode(str).map((x) => LottoNumberGetRespone.fromJson(x)));

String lottoNumberGetResponeToJson(List<LottoNumberGetRespone> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LottoNumberGetRespone {
    int lottoid;
    String number;

    LottoNumberGetRespone({
        required this.lottoid,
        required this.number,
    });

    factory LottoNumberGetRespone.fromJson(Map<String, dynamic> json) => LottoNumberGetRespone(
        lottoid: json["lottoid"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "lottoid": lottoid,
        "number": number,
    };
}
