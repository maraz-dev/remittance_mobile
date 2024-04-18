import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class TDTabBar extends StatelessWidget {
  const TDTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.kTextfieldColor,
          border: Border.all(color: AppColors.kBorderColor)),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.kBlueColor,
        dividerColor: Colors.transparent,
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        indicator: BoxDecoration(
            color: AppColors.kPurpleColor,
            borderRadius: BorderRadius.circular(30.r)),
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => Colors.transparent,
        ),
        tabs: const [
          Tab(text: 'Details'),
          Tab(text: 'Updates'),
        ],
      ),
    );
  }
}
