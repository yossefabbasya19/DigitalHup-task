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

  Future<void> loadData() async {
    // هنا بنجيب أخبار الcategory الأول
    await homeCubit.getNewsByCategory(Constant.newsCategory[0], 1);
    homeCubit.loadMoreData(); // هنا بنعمل تحميل لصفحات إضافية (infinite scroll)
  }

  Future<void> onRefresh() async {
    // دي عشان الـ Pull To Refresh
    int indexOfCategory = Constant.newsCategory.indexOf(homeCubit.category);
    homeCubit.articles.clear();
    homeCubit.pageNumber = 1;
    await homeCubit.getNewsByCategory(Constant.newsCategory[indexOfCategory], 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit, // بندي الكيوبت للبلوك بروفايدر
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("DigitalHub News"), // عنوان الأب بار
              actions: [
                IconButton(
                  icon: const Icon(Icons.search), // زرار البحث
                  onPressed: () {
                    Navigator.pushNamed(context, MyRouter.searchView); // يودينا على شاشة البحث
                  },
                ),
              ],
              bottom: CustomTabBar(
                onTap: (value) async {
                  // هنا لما تغير التاب نعمل تحميل داتا جديدة حسب الكاتيجوري
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
                  articles = state.articles; // لو جاب المقالات بنخزنها في الليست
                }
              },
              builder: (context, state) {
                if (state is GetNewsByCategoryFailure) {
                  return ErrorScreen(
                    message: state.errorMessage, // لو فيه خطأ نعرضه
                    onRefresh: onRefresh,
                  );
                }
                if (state is GetNewsByCategoryLoading && articles.isEmpty) {
                  return const LoadingScreen(); // لو لسه بيحمل من غير داتا نعرض لودنج
                }
                return RefreshIndicator(
                  onRefresh: onRefresh, // سحب لتحديث الداتا
                  child: CustomScrollView(
                    controller: homeCubit.scrollController, // عشان الـ pagination
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: articles.isEmpty ? 1 : articles.length,
                              (context, index) {
                            if (articles.isEmpty) {
                              return const EmptyArticlesWidget(); // لو مفيش مقالات نعرض empty widget
                            }
                            return NewsItemCard(articles: articles[index]); // كارت المقال
                          },
                        ),
                      ),
                      if (homeCubit.paginationLoading) ...[
                        // هنا لو بيحمل بيانات زيادة (صفحات إضافية)
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
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
