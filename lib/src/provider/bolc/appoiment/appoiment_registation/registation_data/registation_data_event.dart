part of 'registation_data_bloc.dart';

@freezed
class RegistationDataEvent with _$RegistationDataEvent {
  const factory RegistationDataEvent.started(String searchData) = _Started;
}
