import 'dart:convert';
// To parse this JSON data, do
//
//     final routeLottoRespone = routeLottoResponeFromJson(jsonString);

RouteLottoRespone routeLottoResponeFromJson(String str) =>
    RouteLottoRespone.fromJson(json.decode(str));

String routeLottoResponeToJson(RouteLottoRespone data) =>
    json.encode(data.toJson());

class RouteLottoRespone {
  int lottoidCount;

  RouteLottoRespone({
    required this.lottoidCount,
  });

  factory RouteLottoRespone.fromJson(Map<String, dynamic> json) =>
      RouteLottoRespone(
        lottoidCount: json["lottoid_count"],
      );

  Map<String, dynamic> toJson() => {
        "lottoid_count": lottoidCount,
      };
}
