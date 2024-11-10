part of 'hospital_pharmacy_summry_bloc.dart';

@freezed
class HospitalPharmacySummryEvent with _$HospitalPharmacySummryEvent {
  const factory HospitalPharmacySummryEvent.started(
      String dateRange, String StoreId) = _Started;
}
