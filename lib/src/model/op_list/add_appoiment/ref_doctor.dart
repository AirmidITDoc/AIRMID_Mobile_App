import 'dart:convert';

List<RefDoctor> refDoctorFromMap(String str) =>
    List<RefDoctor>.from(json.decode(str).map((x) => RefDoctor.fromMap(x)));

String refDoctorToMap(List<RefDoctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RefDoctor {
  int doctorId;
  String doctorName;

  RefDoctor({
    required this.doctorId,
    required this.doctorName,
  });

  factory RefDoctor.fromMap(Map<String, dynamic> json) => RefDoctor(
        doctorId: json["DoctorId"],
        doctorName: json["DoctorName"],
      );
  static List<RefDoctor> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<RefDoctor>.from(
      json.map(
        (v) => RefDoctor.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "DoctorId": doctorId,
        "DoctorName": doctorName,
      };
}
