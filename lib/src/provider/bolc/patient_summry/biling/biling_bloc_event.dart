part of 'biling_bloc_bloc.dart';

@freezed
class BilingBlocEvent with _$BilingBlocEvent {
  const factory BilingBlocEvent.started(
    int opIdtype,
    int opdIpdType,
  ) = _Started;
}
