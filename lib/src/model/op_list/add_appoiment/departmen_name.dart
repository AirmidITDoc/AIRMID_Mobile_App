import 'dart:convert';

List<DepartmentName> departmentNameFromMap(String str) =>
    List<DepartmentName>.from(
        json.decode(str).map((x) => DepartmentName.fromMap(x)));

String departmentNameToMap(List<DepartmentName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DepartmentName {
  int departmentid;
  String departmentName;

  DepartmentName({
    required this.departmentid,
    required this.departmentName,
  });

  factory DepartmentName.fromMap(Map<String, dynamic> json) => DepartmentName(
        departmentid: json["Departmentid"],
        departmentName: json["departmentName"],
      );
  static List<DepartmentName> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<DepartmentName>.from(
      json.map(
        (v) => DepartmentName.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "Departmentid": departmentid,
        "departmentName": departmentName,
      };
}
