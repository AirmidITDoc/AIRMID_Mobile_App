part of 'hospital_pharmacy_summry_bloc.dart';

@freezed
class HospitalPharmacySummryState with _$HospitalPharmacySummryState {
  const factory HospitalPharmacySummryState.initial() = _Initial;
  const factory HospitalPharmacySummryState.loading() = _Loading;
  const factory HospitalPharmacySummryState.success(
      List<HospitalPharmacySummry> hospitalPharmacySummry) = _Success;
  const factory HospitalPharmacySummryState.error(String message) = _Error;
}
