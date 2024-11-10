part of 'radilogy_bloc.dart';

@freezed
class RadilogyState with _$RadilogyState {
  const factory RadilogyState.initial() = _Initial;
  const factory RadilogyState.loading() = _Loading;
  const factory RadilogyState.success(List<RadiologyList> radiologySummryData) =
      _Success;
  const factory RadilogyState.error(String message) = _Error;
}
