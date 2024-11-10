import 'dart:convert';

HospitalPharmacySummry hospitalPharmacySummryFromMap(String str) =>
    HospitalPharmacySummry.fromMap(json.decode(str));

String hospitalPharmacySummryToMap(HospitalPharmacySummry data) =>
    json.encode(data.toMap());

class HospitalPharmacySummry {
  String? today;
  double? collectionAmount;
  double? refundAmount;
  double? netCollectionAmount;
  double? cashPay;
  double? chequePay;
  double? onlinePay;

  HospitalPharmacySummry({
    required this.today,
    required this.collectionAmount,
    required this.refundAmount,
    required this.netCollectionAmount,
    required this.cashPay,
    required this.chequePay,
    required this.onlinePay,
  });

  factory HospitalPharmacySummry.fromMap(Map<String, dynamic> json) =>
      HospitalPharmacySummry(
        today: json["Today"],
        collectionAmount: json["CollectionAmount"],
        refundAmount: json["RefundAmount"],
        netCollectionAmount: json["NetCollectionAmount"],
        cashPay: json["CashPay"],
        chequePay: json["ChequePay"],
        onlinePay: json["OnlinePay"],
      );
  static List<HospitalPharmacySummry> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<HospitalPharmacySummry>.from(
      json.map(
        (v) => HospitalPharmacySummry.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "Today": today,
        "CollectionAmount": collectionAmount,
        "RefundAmount": refundAmount,
        "NetCollectionAmount": netCollectionAmount,
        "CashPay": cashPay,
        "ChequePay": chequePay,
        "OnlinePay": onlinePay,
      };
}
