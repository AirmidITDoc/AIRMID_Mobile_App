part of 'get_department_name_bloc.dart';

@freezed
class GetDepartmentNameEvent with _$GetDepartmentNameEvent {
  const factory GetDepartmentNameEvent.started() = _Started;
}