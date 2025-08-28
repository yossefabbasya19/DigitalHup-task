part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchByKeywordSuccess extends SearchState {
  final NewsResponse newsResponse;

  SearchByKeywordSuccess({required this.newsResponse});
}

final class SearchByKeywordLoading extends SearchState {}

final class SearchByKeywordFailure extends SearchState {
  final String errorMessage;

  SearchByKeywordFailure({required this.errorMessage});
}
