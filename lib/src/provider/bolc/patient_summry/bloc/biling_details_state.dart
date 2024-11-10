part of 'biling_details_bloc.dart';

@freezed
class BilingDetailsState with _$BilingDetailsState {
  const factory BilingDetailsState.initial() = _Initial;
  const factory BilingDetailsState.loading() = _Loading;
  const factory BilingDetailsState.success(
      List<BilingDetailsModel> bilingDetails) = _Success;
  const factory BilingDetailsState.error(String message) = _Error;
}
