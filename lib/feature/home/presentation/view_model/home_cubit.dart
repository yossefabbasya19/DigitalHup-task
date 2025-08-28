import 'package:bloc/bloc.dart';
import 'package:digital_hub_task/core/constant/constan.dart';
import 'package:digital_hub_task/feature/home/data/model/Articles.dart';
import 'package:digital_hub_task/feature/home/data/model/New_post.dart';
import 'package:digital_hub_task/feature/home/data/repo/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;
  int pageNumber = 1;
  String category = Constant.newsCategory[0];
  int defaultPageSize = 15;
  List<Articles> articles = [];


  late NewsResponse newsResponse;
  ScrollController scrollController = ScrollController();

  Future<void> getNewsByCategory(String category, int pageNumber) async {
      emit(GetNewsByCategoryLoading());

    var result = await homeRepo.getNewsByCategory(category, pageNumber);
    result.fold(
      (failure) {
        emit(GetNewsByCategoryFailure(errorMessage: failure.errorMessage));
      },
      (newsResponse) {
        this.newsResponse = newsResponse;
        articles.addAll(newsResponse.articles!);
        emit(GetNewsByCategorySuccess(articles: articles));
      },
    );
  }

  int calculateMaxPage() {
    var result = (newsResponse.totalResults! / defaultPageSize);
    return result.ceil();
  }

  bool paginationLoading = false;

  void loadMoreData() {
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) return;
        if (pageNumber >= calculateMaxPage()) return;
        paginationLoading = true;
        pageNumber++;
        await getNewsByCategory(category, pageNumber);
        paginationLoading = false;
      }
    });
  }
}
