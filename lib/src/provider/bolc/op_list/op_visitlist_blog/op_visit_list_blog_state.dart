part of 'op_visit_list_blog_bloc.dart';

@freezed
class OpVisitListBlogState with _$OpVisitListBlogState {
  const factory OpVisitListBlogState.initial() = _Initial;
  const factory OpVisitListBlogState.loading() = _Loading;
  const factory OpVisitListBlogState.success(List<OpDataList> opVisitData) =
      _Sucess;
  const factory OpVisitListBlogState.error(String message) = _Error;
}
