part of 'get_gender_bloc.dart';

@freezed
class GetGenderEvent with _$GetGenderEvent {
  const factory GetGenderEvent.started({
    required Map<String, dynamic> reqBody,
  }) = _Started;
}