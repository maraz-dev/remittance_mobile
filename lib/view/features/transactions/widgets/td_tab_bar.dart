import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class TDTabBar extends StatelessWidget {
  const TDTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.kPrimaryColor,
      dividerColor: AppColors.kGrey200,
      labelStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.bold),
      indicatorColor: AppColors.kPrimaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (states) => Colors.transparent,
      ),
      tabs: const [
        Tab(text: 'Updates'),
        Tab(text: 'Details'),
      ],
    );
  }
}
