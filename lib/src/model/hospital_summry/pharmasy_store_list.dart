import 'dart:convert';

List<PharmacyStore> pharmacyStoreFromMap(String str) =>
    List<PharmacyStore>.from(
        json.decode(str).map((x) => PharmacyStore.fromMap(x)));

String pharmacyStoreToMap(List<PharmacyStore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PharmacyStore {
  int storeId;
  String storeName;

  PharmacyStore({
    required this.storeId,
    required this.storeName,
  });

  factory PharmacyStore.fromMap(Map<String, dynamic> json) => PharmacyStore(
        storeId: json["StoreId"],
        storeName: json["StoreName"],
      );
  static List<PharmacyStore> fromMapList(List? json) {
    if (json == null) {
      return [];
    }
    return List<PharmacyStore>.from(
      json.map(
        (v) => PharmacyStore.fromMap(v),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "StoreId": storeId,
        "StoreName": storeName,
      };
}
