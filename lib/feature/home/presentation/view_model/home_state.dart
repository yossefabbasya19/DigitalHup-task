part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetNewsByCategorySuccess extends HomeState {
  final List<Articles> articles;

  GetNewsByCategorySuccess({required this.articles});
}

final class GetNewsByCategoryLoading extends HomeState {}

final class GetNewsByCategoryFailure extends HomeState {
  final String errorMessage;

  GetNewsByCategoryFailure({required this.errorMessage});
}
