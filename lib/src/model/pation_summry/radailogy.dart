import 'dart:convert';

List<RadiologyList> radiologyListFromMap(String str) =>
    List<RadiologyList>.from(
        json.decode(str).map((x) => RadiologyList.fromMap(x)));

String radiologyListToMap(List<RadiologyList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RadiologyList {
  int? radReportId;
  String? radDate;
  DateTime radTime;
  String? consultantDoctor;
  String? testName;
  String? pBillNo;
  String? serviceName;
  bool? isCompleted;
  bool? isPrinted;
  String? opIpNumber;
  String? categoryName;
  int? opdIpdId;
  String? patientType;

  RadiologyList({
    required this.radReportId,
    required this.radDate,
    required this.radTime,
    required this.consultantDoctor,
    required this.testName,
    required this.pBillNo,
    required this.serviceName,
    required this.isCompleted,
    required this.isPrinted,
    required this.opIpNumber,
    required this.categoryName,
    required this.opdIpdId,
    required this.patientType,
  });

  factory RadiologyList.fromMap(Map<String, dynamic> json) => RadiologyList(
        radReportId: json["RadReportId"],
        radDate: json["RadDate"],
        radTime: DateTime.parse(json["RadTime"]),
        consultantDoctor: json["ConsultantDoctor"],
        testName: json["TestName"],
        pBillNo: json["PBillNo"],
        serviceName: json["ServiceName"],
        isCompleted: json["IsCompleted"],
        isPrinted: json["IsPrinted"],
        opIpNumber: json["OP_IP_Number"],
        categoryName: json["CategoryName"],
        opdIpdId: json["OPD_IPD_ID"],
        patientType: json["PatientType"],
      );
  static List<RadiologyList> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<RadiologyList>.from(
      json.map(
        (v) => RadiologyList.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "RadReportId": radReportId,
        "RadDate": radDate,
        "RadTime": radTime.toIso8601String(),
        "ConsultantDoctor": consultantDoctor,
        "TestName": testName,
        "PBillNo": pBillNo,
        "ServiceName": serviceName,
        "IsCompleted": isCompleted,
        "IsPrinted": isPrinted,
        "OP_IP_Number": opIpNumber,
        "CategoryName": categoryName,
        "OPD_IPD_ID": opdIpdId,
        "PatientType": patientType,
      };
}
