part of 'add_register_appoinment_bloc.dart';

@freezed
class AddRegisterAppoinmentState with _$AddRegisterAppoinmentState {
  const factory AddRegisterAppoinmentState.initial() = _Initial;
  const factory AddRegisterAppoinmentState.loading() = _Loading;
  const factory AddRegisterAppoinmentState.success() = _Success;
  const factory AddRegisterAppoinmentState.error(String message) = _Error;
}
