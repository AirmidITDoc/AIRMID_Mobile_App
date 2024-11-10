import 'dart:convert';

List<GetAdmissionDoctor> getAdmissionDoctorFromMap(String str) =>
    List<GetAdmissionDoctor>.from(
        json.decode(str).map((x) => GetAdmissionDoctor.fromMap(x)));

String getAdmissionDoctorToMap(List<GetAdmissionDoctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetAdmissionDoctor {
  int doctorId;
  String doctorName;

  GetAdmissionDoctor({
    required this.doctorId,
    required this.doctorName,
  });

  factory GetAdmissionDoctor.fromMap(Map<String, dynamic> json) =>
      GetAdmissionDoctor(
        doctorId: json["DoctorId"],
        doctorName: json["DoctorName"],
      );
  static List<GetAdmissionDoctor> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<GetAdmissionDoctor>.from(
      json.map(
        (v) => GetAdmissionDoctor.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "DoctorId": doctorId,
        "DoctorName": doctorName,
      };
}
