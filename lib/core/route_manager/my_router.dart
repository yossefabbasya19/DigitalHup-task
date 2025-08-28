import 'package:digital_hub_task/feature/articles_details/presentation/views/articales_details_view.dart';
import 'package:digital_hub_task/feature/home/data/model/Articles.dart';
import 'package:digital_hub_task/feature/home/presentation/view/home_view.dart';
import 'package:digital_hub_task/feature/search/presentation/view/search_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static const String homeView = 'homeView';
  static const String articlesDetails = 'articlesDetails';
  static const String searchView = 'searchView';

  static Route<WidgetBuilder>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeView:
        return MaterialPageRoute(builder: (context) => HomeView());
      case articlesDetails:
        return MaterialPageRoute(
          builder: (context) =>
              ArticleDetailScreen(article: settings.arguments as Articles),
        );
      case searchView:
        return MaterialPageRoute(
          builder: (context) =>
             SearchScreen(),
        );
    }
    return null;
  }
}
