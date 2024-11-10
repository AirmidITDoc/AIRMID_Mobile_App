part of 'prefix_list_bloc.dart';

@freezed
class PrefixListState with _$PrefixListState {
  const factory PrefixListState.initial() = _Initial;
  const factory PrefixListState.loading() = _Loading;
  const factory PrefixListState.success(List<PreFixList> preFixListData) =
      _Success;
  const factory PrefixListState.error(String message) = _Error;
}
