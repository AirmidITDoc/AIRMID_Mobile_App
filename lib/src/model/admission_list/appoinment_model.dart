import 'dart:convert';

List<AdmitListData> admitListDataFromMap(String str) =>
    List<AdmitListData>.from(
        json.decode(str).map((x) => AdmitListData.fromMap(x)));

String admitListDataToMap(List<AdmitListData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class AdmitListData {
  int admissionId;
  String? regNo;
  String? patientName;
  String? wardName;
  String? bedName;
  String? doctorName;
  String? ipdNo;
  String? patientType;
  DateTime? doa;
  String? companyName;
  String? refDoctorName;
  String? ageYear;

  AdmitListData({
    required this.admissionId,
    required this.regNo,
    required this.patientName,
    required this.wardName,
    required this.bedName,
    required this.doctorName,
    required this.ipdNo,
    required this.patientType,
    required this.doa,
    required this.companyName,
    required this.refDoctorName,
    required this.ageYear,
  });

  factory AdmitListData.fromMap(Map<String, dynamic> json) => AdmitListData(
        admissionId: json["AdmissionID"],
        regNo: json["RegNo"],
        patientName: json["PatientName"],
        wardName: json["WardName"],
        bedName: json["BedName"],
        doctorName: json["DoctorName"],
        ipdNo: json["IPDNo"],
        patientType: json["PatientType"],
        doa: DateTime.parse(json["DOA"]),
        companyName: json["CompanyName"],
        refDoctorName: json["RefDoctorName"],
        ageYear: json["AgeYear"],
      );

  Map<String, dynamic> toMap() => {
        "AdmissionID": admissionId,
        "RegNo": regNo,
        "PatientName": patientName,
        "WardName": wardName,
        "BedName": bedName,
        "DoctorName": doctorName,
        "IPDNo": ipdNo,
        "PatientType": patientType,
        "DOA": doa?.toIso8601String(),
        "CompanyName": companyName,
        "RefDoctorName": refDoctorName,
        "AgeYear": ageYear,
      };
}
