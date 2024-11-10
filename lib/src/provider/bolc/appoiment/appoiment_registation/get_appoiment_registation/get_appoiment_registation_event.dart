part of 'get_appoiment_registation_bloc.dart';

@freezed
class GetAppoimentRegistationEvent with _$GetAppoimentRegistationEvent {
  const factory GetAppoimentRegistationEvent.started(String searchData) =
      _Started;
}
