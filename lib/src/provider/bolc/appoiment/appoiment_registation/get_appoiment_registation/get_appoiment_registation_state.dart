part of 'get_appoiment_registation_bloc.dart';

@freezed
class GetAppoimentRegistationState with _$GetAppoimentRegistationState {
  const factory GetAppoimentRegistationState.initial() = _Initial;
  const factory GetAppoimentRegistationState.loading() = _Loading;
  const factory GetAppoimentRegistationState.success(
      List<GetPatientList> getPatientList) = _Success;
  const factory GetAppoimentRegistationState.error(String message) = _Error;
}
