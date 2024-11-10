part of 'dashboard_count_bloc.dart';

@freezed
class DashboardCountEvent with _$DashboardCountEvent {
  const factory DashboardCountEvent.started() = _Started;
}