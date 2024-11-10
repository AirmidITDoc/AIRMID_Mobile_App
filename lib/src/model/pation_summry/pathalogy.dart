import 'dart:convert';

List<PathalogyModel> pathalogyModelFromMap(String str) =>
    List<PathalogyModel>.from(
        json.decode(str).map((x) => PathalogyModel.fromMap(x)));

String pathalogyModelToMap(List<PathalogyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PathalogyModel {
  int? opdIpdId;
  DateTime? pathDate;
  String? testName;
  bool? isCompleted;
  dynamic pBillNo;

  PathalogyModel({
    this.opdIpdId,
    this.pathDate,
    this.testName,
    this.isCompleted,
    this.pBillNo,
  });

  factory PathalogyModel.fromMap(Map<String, dynamic> json) => PathalogyModel(
        opdIpdId: json["OPD_IPD_ID"],
        pathDate: DateTime.parse(json["PathDate"]),
        testName: json["TestName"],
        isCompleted: json["IsCompleted"],
        pBillNo: json["PBillNo"],
      );
  static List<PathalogyModel> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<PathalogyModel>.from(
      json.map(
        (v) => PathalogyModel.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "OPD_IPD_ID": opdIpdId,
        "PathDate": pathDate?.toIso8601String(),
        "TestName": testName,
        "IsCompleted": isCompleted,
        "PBillNo": pBillNo,
      };
}
