part of 'get_gender_bloc.dart';

@freezed
class GetGenderState with _$GetGenderState {
  const factory GetGenderState.initial() = _Initial;
  const factory GetGenderState.loading() = _Loading;
  const factory GetGenderState.success(List<Gender> genderList) = _Success;
  const factory GetGenderState.error(String message) = _Error;
}
