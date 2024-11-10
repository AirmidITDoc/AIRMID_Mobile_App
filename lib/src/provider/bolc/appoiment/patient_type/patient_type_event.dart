part of 'patient_type_bloc.dart';

@freezed
class PatientTypeEvent with _$PatientTypeEvent {
  const factory PatientTypeEvent.started() = _Started;
}