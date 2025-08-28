import 'package:digital_hub_task/core/app_color/app_color.dart';
import 'package:digital_hub_task/core/constant/constan.dart';
import 'package:digital_hub_task/core/route_manager/my_router.dart';
import 'package:digital_hub_task/feature/home/data/model/Articles.dart';
import 'package:digital_hub_task/feature/home/data/repo/home_repo_imple.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/custom_tab_bar.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/empty_from_article.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/error_screen.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/loading_widget.dart';
import 'package:digital_hub_task/feature/home/presentation/view/widgets/news_item_card.dart';
import 'package:digital_hub_task/feature/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeCubit homeCubit;
  String category = Constant.newsCategory[0];
  List<Articles> articles = [];

  @override
  void initState() {
    homeCubit = HomeCubit(HomeRepoImple());
    loadData();
    super.initState();
  }

  loadData() async {
    await homeCubit.getNewsByCategory(Constant.newsCategory[0], 1);
    homeCubit.loadMoreData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              actionsPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.03,
              ),
              title: Text("DigitalHup New"),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRouter.searchView);
                  },
                ),
              ],
              bottom: CustomTabBar(
                onTap: (value) async {
                  homeCubit.category = Constant.newsCategory[value];
                  homeCubit.articles.clear();
                  homeCubit.pageNumber = 1;
                  await homeCubit.getNewsByCategory(
                    Constant.newsCategory[value],
                    1,
                  );
                },
              ),
            ),
            body: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is GetNewsByCategorySuccess) {
                  articles = state.articles;
                }
              },
              builder: (context, state) {
                if (state is GetNewsByCategoryFailure) {
                  return ErrorScreen(
                    message: state.errorMessage,
                    onRefresh: () async {
                      int indexOfCategory = Constant.newsCategory.indexOf(
                        homeCubit.category,
                      );
                      setState(() {});
                      homeCubit.articles.clear();
                      homeCubit.pageNumber = 1;
                      await homeCubit.getNewsByCategory(
                        Constant.newsCategory[indexOfCategory],
                        1,
                      );
                    },
                  );
                }
                if (state is GetNewsByCategoryLoading && articles.isEmpty) {
                  return LoadingScreen();
                }
                return CustomScrollView(
                  controller: homeCubit.scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: articles.isEmpty ? 1 : articles.length,
                        (context, index) {
                          if (articles.isEmpty) {
                            return EmptyArticlesWidget();
                          }
                          return NewsItemCard(articles: articles[index]);
                        },
                      ),
                    ),
                    if (homeCubit.paginationLoading) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.sizeOf(context).height * 0.05,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
