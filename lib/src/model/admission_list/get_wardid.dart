import 'dart:convert';

List<GetWardId> getWardIdFromMap(String str) =>
    List<GetWardId>.from(json.decode(str).map((x) => GetWardId.fromMap(x)));

String getWardIdToMap(List<GetWardId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetWardId {
  int wardId;
  String wardName;

  GetWardId({
    required this.wardId,
    required this.wardName,
  });

  factory GetWardId.fromMap(Map<String, dynamic> json) => GetWardId(
        wardId: json["WardId"],
        wardName: json["WardName"],
      );
  static List<GetWardId> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<GetWardId>.from(
      json.map(
        (v) => GetWardId.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "WardId": wardId,
        "WardName": wardName,
      };
}
