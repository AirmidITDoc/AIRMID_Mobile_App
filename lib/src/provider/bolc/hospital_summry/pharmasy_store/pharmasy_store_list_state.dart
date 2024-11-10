part of 'pharmasy_store_list_bloc.dart';

@freezed
class PharmasyStoreListState with _$PharmasyStoreListState {
  const factory PharmasyStoreListState.initial() = _Initial;
  const factory PharmasyStoreListState.loading() = _Loading;
  const factory PharmasyStoreListState.success(
      List<PharmacyStore> pharmacyStore) = _Success;
  const factory PharmasyStoreListState.error(String message) = _Error;
}
