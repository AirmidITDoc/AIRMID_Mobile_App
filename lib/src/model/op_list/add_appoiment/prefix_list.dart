import 'dart:convert';

List<PreFixList> preFixListFromMap(String str) =>
    List<PreFixList>.from(json.decode(str).map((x) => PreFixList.fromMap(x)));

String preFixListToMap(List<PreFixList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PreFixList {
  int prefixId;
  String prefixName;

  PreFixList({
    required this.prefixId,
    required this.prefixName,
  });

  factory PreFixList.fromMap(Map<String, dynamic> json) => PreFixList(
        prefixId: json["PrefixID"],
        prefixName: json["PrefixName"],
      );
  static List<PreFixList> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<PreFixList>.from(
      json.map(
        (v) => PreFixList.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "PrefixID": prefixId,
        "PrefixName": prefixName,
      };
}
