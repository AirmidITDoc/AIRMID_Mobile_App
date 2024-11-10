import 'dart:convert';

List<PatientType> patientTypeFromMap(String str) =>
    List<PatientType>.from(json.decode(str).map((x) => PatientType.fromMap(x)));

String patientTypeToMap(List<PatientType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PatientType {
  int patientTypeId;
  String patientType;

  PatientType({
    required this.patientTypeId,
    required this.patientType,
  });

  factory PatientType.fromMap(Map<String, dynamic> json) => PatientType(
        patientTypeId: json["PatientTypeId"],
        patientType: json["PatientType"],
      );
  static List<PatientType> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<PatientType>.from(
      json.map(
        (v) => PatientType.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "PatientTypeId": patientTypeId,
        "PatientType": patientType,
      };
}
