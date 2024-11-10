part of 'get_patient_doctor_name_bloc.dart';

@freezed
class GetPatientDoctorNameState with _$GetPatientDoctorNameState {
  const factory GetPatientDoctorNameState.initial() = _Initial;
  const factory GetPatientDoctorNameState.loading() = _Loading;
  const factory GetPatientDoctorNameState.success(
      List<GetAdmissionDoctor> getDoctorName) = _Success;
  const factory GetPatientDoctorNameState.error(String message) = _Error;
}
