import 'package:digital_hub_task/core/constant/constan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(int)?onTap;
  const CustomTabBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: Constant.newsCategory.length,
      child: TabBar(
        onTap: onTap,
        physics: ScrollPhysics(),
        isScrollable: true,
        tabs: Constant.newsCategory.map((e) => Tab(child: Text(e))).toList(),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
