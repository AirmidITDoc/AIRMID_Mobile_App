part of 'get_doctor_name_bloc.dart';

@freezed
class GetDoctorNameState with _$GetDoctorNameState {
  const factory GetDoctorNameState.initial() = _Initial;
  const factory GetDoctorNameState.loading() = _Loading;
  const factory GetDoctorNameState.success(List<GetDoctorName> getDoctorName) =
      _Sucess;
  const factory GetDoctorNameState.error(String message) = _Error;
}
