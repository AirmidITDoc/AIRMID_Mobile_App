part of 'add_register_appoinment_bloc.dart';

@freezed
class AddRegisterAppoinmentEvent with _$AddRegisterAppoinmentEvent {
  const factory AddRegisterAppoinmentEvent.started(
    Map<String, dynamic> reqBody,
  ) = _Started;
}
