part of 'ref_doctor_bloc.dart';

@freezed
class RefDoctorState with _$RefDoctorState {
  const factory RefDoctorState.initial() = _Initial;
  const factory RefDoctorState.loading() = _Loading;
  const factory RefDoctorState.success(List<RefDoctor> refDoctor) = _Success;
  const factory RefDoctorState.error(String message) = _Error;
}
