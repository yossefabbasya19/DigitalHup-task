import 'package:digital_hub_task/core/app_color/app_color.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: AppBarTheme(centerTitle: true,color: AppColor.white),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColor.gary),
      contentPadding: EdgeInsets.all(16),
      constraints: BoxConstraints(maxHeight: 100),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.gary, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.gary, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.red, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.red, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      prefixIconColor: AppColor.gary,
      suffixIconColor: AppColor.gary,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColor.black,
      labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
      indicatorColor: AppColor.black,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerHeight: 0,
      tabAlignment: TabAlignment.start,
    ),
  );
}
