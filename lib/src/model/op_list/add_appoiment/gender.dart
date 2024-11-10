import 'dart:convert';

List<Gender> genderFromMap(String str) =>
    List<Gender>.from(json.decode(str).map((x) => Gender.fromMap(x)));

String genderToMap(List<Gender> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Gender {
  int genderId;
  String genderName;

  Gender({
    required this.genderId,
    required this.genderName,
  });

  factory Gender.fromMap(Map<String, dynamic> json) => Gender(
        genderId: json["GenderId"],
        genderName: json["GenderName"],
      );
static List<Gender> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<Gender>.from(
      json.map(
        (v) => Gender.fromMap(v),
      ),
    );
  }
  Map<String, dynamic> toMap() => {
        "GenderId": genderId,
        "GenderName": genderName,
      };
}
