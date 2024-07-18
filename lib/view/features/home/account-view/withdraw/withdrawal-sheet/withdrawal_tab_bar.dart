import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class WithdrawalTabBar extends StatelessWidget {
  const WithdrawalTabBar({
    super.key,
    required TabController bankOptionTabController,
  }) : _bankOptionTabController = bankOptionTabController;

  final TabController _bankOptionTabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: AppColors.kGrey100, borderRadius: BorderRadius.circular(32)),
      child: TabBar(
        controller: _bankOptionTabController,
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
        tabs: const [
          Tab(text: 'Local'),
          Tab(text: 'International'),
        ],
      ),
    );
  }
}
