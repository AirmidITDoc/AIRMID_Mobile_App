part of 'get_doctor_name_bloc.dart';

@freezed
class GetDoctorNameEvent with _$GetDoctorNameEvent {
  const factory GetDoctorNameEvent.started(Map<String, dynamic> reqBody) =
      _Started;
}
