part of 'biling_bloc_bloc.dart';

@freezed
class BilingBlocState with _$BilingBlocState {
  const factory BilingBlocState.initial() = _Initial;
  const factory BilingBlocState.loading() = _Loading;
  const factory BilingBlocState.success(List<BilingData> bilingBlogData) =
      _Sucess;
  const factory BilingBlocState.error(String message) = _Error;
}
