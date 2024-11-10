part of 'hospitalsummry_bloc.dart';

@freezed
class HospitalsummryState with _$HospitalsummryState {
  const factory HospitalsummryState.initial() = _Initial;
  const factory HospitalsummryState.loading() = _Loading;
  const factory HospitalsummryState.success(
      List<HospitalSummryModel> hospitalSummry) = _Success;
  const factory HospitalsummryState.error(String message) = _Error;
}
