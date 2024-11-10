import 'dart:convert';

List<TariffMaster> tariffMasterFromMap(String str) => List<TariffMaster>.from(
    json.decode(str).map((x) => TariffMaster.fromMap(x)));

String tariffMasterToMap(List<TariffMaster> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TariffMaster {
  int tariffId;
  String tariffName;

  TariffMaster({
    required this.tariffId,
    required this.tariffName,
  });

  factory TariffMaster.fromMap(Map<String, dynamic> json) => TariffMaster(
        tariffId: json["TariffId"],
        tariffName: json["TariffName"],
      );
  static List<TariffMaster> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<TariffMaster>.from(
      json.map(
        (v) => TariffMaster.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "TariffId": tariffId,
        "TariffName": tariffName,
      };
}
