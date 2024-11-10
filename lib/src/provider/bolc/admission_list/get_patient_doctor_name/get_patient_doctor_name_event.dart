part of 'get_patient_doctor_name_bloc.dart';

@freezed
class GetPatientDoctorNameEvent with _$GetPatientDoctorNameEvent {
  const factory GetPatientDoctorNameEvent.started() = _Started;
}