part of 'get_department_name_bloc.dart';

@freezed
class GetDepartmentNameState with _$GetDepartmentNameState {
  const factory GetDepartmentNameState.initial() = _Initial;
  const factory GetDepartmentNameState.loading() = _Loading;
  const factory GetDepartmentNameState.success(
      List<DepartmentName> departmentList) = _Success;
  const factory GetDepartmentNameState.error(String message) = _Error;
}
