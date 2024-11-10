import 'dart:convert';

List<GetDoctorName> getDoctorNameFromMap(String str) =>
    List<GetDoctorName>.from(
        json.decode(str).map((x) => GetDoctorName.fromMap(x)));

String getDoctorNameToMap(List<GetDoctorName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetDoctorName {
  int doctorId;
  String doctorname;
  int departmentId;
  String departmentName;
  bool isActive;

  GetDoctorName({
    required this.doctorId,
    required this.doctorname,
    required this.departmentId,
    required this.departmentName,
    required this.isActive,
  });

  factory GetDoctorName.fromMap(Map<String, dynamic> json) => GetDoctorName(
        doctorId: json["DoctorId"],
        doctorname: json["Doctorname"],
        departmentId: json["DepartmentId"],
        departmentName: json["DepartmentName"],
        isActive: json["IsActive"],
      );
  static List<GetDoctorName> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<GetDoctorName>.from(
      json.map(
        (v) => GetDoctorName.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "DoctorId": doctorId,
        "Doctorname": doctorname,
        "DepartmentId": departmentId,
        "DepartmentName": departmentName,
        "IsActive": isActive,
      };
}
