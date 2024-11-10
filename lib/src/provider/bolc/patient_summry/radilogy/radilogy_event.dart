part of 'radilogy_bloc.dart';

@freezed
class RadilogyEvent with _$RadilogyEvent {
  const factory RadilogyEvent.started(
    int opIdtype,
    int opdIpdType,
  ) = _Started;
}
