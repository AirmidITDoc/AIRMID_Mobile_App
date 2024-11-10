part of 'get_ward_id_bloc.dart';

@freezed
class GetWardIdState with _$GetWardIdState {
  const factory GetWardIdState.initial() = _Initial;
  const factory GetWardIdState.loading() = _Loading;
  const factory GetWardIdState.success(List<GetWardId> getWardId) = _Success;
  const factory GetWardIdState.error(String message) = _Error;
}
