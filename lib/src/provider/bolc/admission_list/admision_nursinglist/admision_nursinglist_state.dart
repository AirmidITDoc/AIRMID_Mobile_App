part of 'admision_nursinglist_bloc.dart';

@freezed
class AdmiteedDataState with _$AdmiteedDataState {
  const factory AdmiteedDataState.initial() = _Initial;
  const factory AdmiteedDataState.loading() = _Loading;
  const factory AdmiteedDataState.success(List<AdmitListData> dashboardData) =
      _Success;
  const factory AdmiteedDataState.error(String message) = _Error;
}
