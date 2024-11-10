part of 'dashboard_count_bloc.dart';

@freezed
class DashboardCountState with _$DashboardCountState {
  const factory DashboardCountState.initial() = _Initial;
  const factory DashboardCountState.loading() = _Loading;
  const factory DashboardCountState.success(
      List<DashboardCount> dashboardData) = _Success;
  const factory DashboardCountState.error(String message) = _Error;
}
