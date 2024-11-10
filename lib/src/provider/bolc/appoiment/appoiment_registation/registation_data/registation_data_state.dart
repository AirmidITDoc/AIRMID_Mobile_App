part of 'registation_data_bloc.dart';

@freezed
class RegistationDataState with _$RegistationDataState {
  const factory RegistationDataState.initial() = _Initial;
  const factory RegistationDataState.loading() = _Loading;
  const factory RegistationDataState.success(GetPatientList getPatientList) =
      _Success;
  const factory RegistationDataState.error(String message) = _Error;
}
