import 'dart:convert';

List<HospitalSummryModel> hospitalSummryFromMap(String str) =>
    List<HospitalSummryModel>.from(
        json.decode(str).map((x) => HospitalSummryModel.fromMap(x)));

String hospitalSummryToMap(List<HospitalSummryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class HospitalSummryModel {
  double todayCollection;
  double todaysRefund;
  double netCollection;
  double opCollection;
  double ipCollection;
  double opRefund;
  double ipRefund;
  double cashPay;
  double chequePay;
  double online;

  HospitalSummryModel({
    required this.todayCollection,
    required this.todaysRefund,
    required this.netCollection,
    required this.opCollection,
    required this.ipCollection,
    required this.opRefund,
    required this.ipRefund,
    required this.cashPay,
    required this.chequePay,
    required this.online,
  });

  factory HospitalSummryModel.fromMap(Map<String, dynamic> json) =>
      HospitalSummryModel(
        todayCollection: json["TodayCollection"],
        todaysRefund: json["TodaysRefund"],
        netCollection: json["NetCollection"],
        opCollection: json["OP_Collection"],
        ipCollection: json["IP_Collection"],
        opRefund: json["OP_Refund"],
        ipRefund: json["IP_Refund"],
        cashPay: json["CashPay"],
        chequePay: json["ChequePay"],
        online: json["Online"],
      );
  static List<HospitalSummryModel> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<HospitalSummryModel>.from(
      json.map(
        (v) => HospitalSummryModel.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "TodayCollection": todayCollection,
        "TodaysRefund": todaysRefund,
        "NetCollection": netCollection,
        "OP_Collection": opCollection,
        "IP_Collection": ipCollection,
        "OP_Refund": opRefund,
        "IP_Refund": ipRefund,
        "CashPay": cashPay,
        "ChequePay": chequePay,
        "Online": online,
      };
}
