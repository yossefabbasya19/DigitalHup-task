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
    searchCubit = SearchCubit(SearchRepoImp());
    loadData();
    super.initState();
  }

  loadData() async{
    await searchCubit.loadMoreData();
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
                        articles.addAll(state.newsResponse.articles!);
                        print("article len${articles.length}");
                      }
                    },
                    builder: (context, state) {
                      if (state is SearchByKeywordFailure) {
                        return ErrorScreen(
                          message: state.errorMessage,
                          onRefresh: () async {
                            articles.clear();
                            await searchCubit.searchByKeyword(searchQuery, 1);
                          },
                        );
                      }

                      if (state is SearchByKeywordLoading&& articles.isEmpty) {
                        return const LoadingScreen();
                      }

                      if (articles.isEmpty) {
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
                          ListView.builder(
                            controller: searchCubit.scrollController,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return NewsItemCard(articles: articles[index]);
                            },
                          ),
                          searchCubit.paginationLoading == true?CircularProgressIndicator():SizedBox()
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
