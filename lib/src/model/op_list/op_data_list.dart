import 'dart:convert';

List<OpDataList> opDataListFromMap(String str) =>
    List<OpDataList>.from(json.decode(str).map((x) => OpDataList.fromMap(x)));

String opDataListToMap(List<OpDataList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OpDataList {
  int? visitId;
  String? patientName;
  String? regNo;
  DateTime? visitDate;
  String? doctorName;
  String? ageYear;
  String? patientType;
  String? opdNo;
  String? companyName;

  OpDataList({
    required this.visitId,
    required this.patientName,
    required this.regNo,
    required this.visitDate,
    required this.doctorName,
    required this.ageYear,
    required this.patientType,
    required this.opdNo,
    required this.companyName,
  });

  factory OpDataList.fromMap(Map<String, dynamic> json) => OpDataList(
        visitId: json["VisitId"],
        patientName: json["PatientName"],
        regNo: json["RegNo"],
        visitDate: DateTime.parse(json["VisitDate"]),
        doctorName: json["DoctorName"],
        ageYear: json["AgeYear"],
        patientType: json["PatientType"],
        opdNo: json["OPDNo"],
        companyName: json["CompanyName"],
      );

  Map<String, dynamic> toMap() => {
        "VisitId": visitId,
        "PatientName": patientName,
        "RegNo": regNo,
        "VisitDate": visitDate?.toIso8601String(),
        "DoctorName": doctorName,
        "AgeYear": ageYear,
        "PatientType": patientType,
        "OPDNo": opdNo,
        "CompanyName": companyName,
      };
}
