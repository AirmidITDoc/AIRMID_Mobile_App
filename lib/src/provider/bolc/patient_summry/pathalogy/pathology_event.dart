part of 'pathology_bloc.dart';

@freezed
class PathologyEvent with _$PathologyEvent {
  const factory PathologyEvent.started(
    int opIdtype,
    int opdIpdType,
  ) = _Started;
}
