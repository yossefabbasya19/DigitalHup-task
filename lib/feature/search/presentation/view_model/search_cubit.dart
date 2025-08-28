import 'package:bloc/bloc.dart';
import 'package:digital_hub_task/feature/home/data/model/New_post.dart';
import 'package:digital_hub_task/feature/search/data/repo/search_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;
  ScrollController scrollController = ScrollController();
  late NewsResponse newsResponse;
  int defaultPageSize = 20;
  int pageNumber = 1;
  String searchKey = '';

  Future<void> searchByKeyword(String keyword, int pageNumber) async {
    emit(SearchByKeywordLoading());
    var result = await searchRepo.searchByKeyword(keyword, pageNumber);
    result.fold(
      (failure) {
        emit(SearchByKeywordFailure(errorMessage: failure.errorMessage));
      },
      (newsResponse) {
        this.newsResponse = newsResponse;
        emit(SearchByKeywordSuccess(newsResponse: newsResponse));
      },
    );
  }

  int calculateMaxPage() {
    var result = (newsResponse.totalResults! / defaultPageSize);
    return result.ceil();
  }

  bool paginationLoading = false;

  Future<void> loadMoreData() async{
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) return;
        if (pageNumber >= calculateMaxPage()) return;
        paginationLoading = true;
        pageNumber++;
        await searchByKeyword(searchKey, pageNumber);
        paginationLoading = false;
      }
    });
  }
}
