part of 'add_appoiment_bloc.dart';

@freezed
class AddAppoimentState with _$AddAppoimentState {
  const factory AddAppoimentState.initial() = _Initial;
  const factory AddAppoimentState.lpading() = _Loading;
  const factory AddAppoimentState.success() = _Success;
  const factory AddAppoimentState.error(String message) = _Error;
}
