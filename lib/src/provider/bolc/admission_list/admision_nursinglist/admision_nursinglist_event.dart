part of 'admision_nursinglist_bloc.dart';

@freezed
class AdmittedPatientDataEvent with _$AdmittedPatientDataEvent {
  const factory AdmittedPatientDataEvent.started(
      {int? wardId, String? doctorId}) = _Started;
}
