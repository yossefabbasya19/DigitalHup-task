import 'package:digital_hub_task/feature/home/data/model/Articles.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/error_screen.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/loading_widget.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/news_item_card.dart';
import 'package:digital_hub_task/feature/search/data/repo/search_repo_imp.dart';
import 'package:digital_hub_task/feature/search/presentation/view_model/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  List<Articles> articles = [];
  late SearchCubit searchCubit;

  @override
  void initState() {
    focusNode.requestFocus();
    searchCubit = SearchCubit(SearchRepoImp());
    loadData();
    super.initState();
  }

  loadData() async {
    await searchCubit.loadMoreData(); // تحميل بيانات اكتر للـ Pagination
  }

  FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>.value(
      value: searchCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text("Search")),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    focusNode:focusNode,
                    decoration: InputDecoration(
                      hintText: "Search articles...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    onSubmitted: (value) async {
                      if (value.isEmpty) {
                        articles.clear();
                        setState(() {});
                        return;
                      }
                      articles.clear();
                      searchQuery = value;
                      searchCubit.searchKey = value;
                      await searchCubit.searchByKeyword(value, 1);
                    },
                  ),
                ),
                Expanded(
                  child: BlocConsumer<SearchCubit, SearchState>(
                    listener: (context, state) {
                      if (state is SearchByKeywordSuccess) {
                        // لو البحث نجح، ضيف النتايج في الليستة
                        articles.addAll(state.newsResponse.articles!);
                      }
                    },
                    builder: (context, state) {
                      if (state is SearchByKeywordFailure) {
                        // لو فيه Error
                        return ErrorScreen(
                          message: state.errorMessage,
                          onRefresh: () async {
                            articles.clear();
                            await searchCubit.searchByKeyword(searchQuery, 1);
                          },
                        );
                      }

                      if (state is SearchByKeywordLoading && articles.isEmpty) {
                        // لو بيحمل لأول مرة
                        return const LoadingScreen();
                      }

                      if (articles.isEmpty) {
                        // لو لسه مفيش بحث
                        return const Center(
                          child: Text(
                            "Start typing to search articles",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }

                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // الليستة اللي بتعرض المقالات
                          ListView.builder(
                            controller: searchCubit.scrollController,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return NewsItemCard(articles: articles[index]);
                            },
                          ),
                          // لو فيه Pagination شغالة اعرض Loading indicator
                          searchCubit.paginationLoading
                              ? const CircularProgressIndicator()
                              : const SizedBox()
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
