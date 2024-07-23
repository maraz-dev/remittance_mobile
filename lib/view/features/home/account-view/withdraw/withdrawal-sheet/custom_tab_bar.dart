import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required TabController tabController,
    required this.tabs,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: AppColors.kGrey200, borderRadius: BorderRadius.circular(32)),
      child: TabBar(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500, color: AppColors.kGrey700),
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500),
        indicatorPadding: const EdgeInsets.all(5),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColors.kWhiteColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.kBoxShadowColor,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ]),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => AppColors.kBlackColor,
        ),
        tabs: tabs,
      ),
    );
  }
}
