import 'package:digital_hub_task/core/route_manager/my_router.dart';
import 'package:digital_hub_task/core/theme/my_theme.dart';
import 'package:digital_hub_task/feature/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';

class DigitalHubApp extends StatelessWidget {
  const DigitalHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme,
      home: HomeView(),
    );
  }
}
