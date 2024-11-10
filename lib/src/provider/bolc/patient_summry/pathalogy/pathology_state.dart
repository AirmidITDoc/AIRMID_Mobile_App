part of 'pathology_bloc.dart';

@freezed
class PathologyState with _$PathologyState {
  const factory PathologyState.initial() = _Initial;
  const factory PathologyState.loading() = _Loading;
  const factory PathologyState.success(List<PathalogyModel> patienSummryData) = _Success;
  const factory PathologyState.error(String error) = _Error;
}
