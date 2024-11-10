part of 'biling_details_bloc.dart';

@freezed
class BilingDetailsEvent with _$BilingDetailsEvent {
  const factory BilingDetailsEvent.started(int bilingId) = _Started;
}
