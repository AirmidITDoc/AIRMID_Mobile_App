part of 'patient_type_bloc.dart';

@freezed
class PatientTypeState with _$PatientTypeState {
  const factory PatientTypeState.initial() = _Initial;
  const factory PatientTypeState.loading() = _Loading;
  const factory PatientTypeState.success(List<PatientType> patientType) =
      _Success;
  const factory PatientTypeState.error(String message) = _Error;
}
