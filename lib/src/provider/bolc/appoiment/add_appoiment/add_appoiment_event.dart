part of 'add_appoiment_bloc.dart';

@freezed
class AddAppoimentEvent with _$AddAppoimentEvent {
  const factory AddAppoimentEvent.started(
    Map<String, dynamic> reqBody,
  ) = _Started;
}
