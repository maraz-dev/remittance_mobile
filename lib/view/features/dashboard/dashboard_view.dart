import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/home/home_view.dart';
import 'package:remittance_mobile/view/features/profile/profile_view.dart';
import 'package:remittance_mobile/view/features/services/services_view.dart';
import 'package:remittance_mobile/view/features/transactions/transactions_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class DashboardView extends StatefulWidget {
  static String path = '/dashboard-view';
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int currentIndex = 0;
  List<Widget> pageList = [
    const HomeView(),
    const ServicesView(),
    const TransactionsView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            border: Border.all(color: const Color(0xffEAECF0)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r)),
            boxShadow: [
              BoxShadow(
                color: AppColors.kBoxShadowColor,
                blurRadius: 2,
                offset: const Offset(0, -1),
              )
            ]),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.kWhiteColor,
            currentIndex: currentIndex,
            elevation: 0,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            iconSize: 18,
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppColors.kBlackColor,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
              letterSpacing: 0,
              color: AppColors.kTextColor,
            ),
            items: [
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppImages.activeHomeIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kPrimaryColor, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(
                    AppImages.homeIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kSecondaryColorTwo, BlendMode.srcIn),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppImages.activeServicesIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kPrimaryColor, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(
                    AppImages.servicesIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kSecondaryColorTwo, BlendMode.srcIn),
                  ),
                  label: 'Services'),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppImages.activeAccountsIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kPrimaryColor, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(
                    AppImages.accountsIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kSecondaryColorTwo, BlendMode.srcIn),
                  ),
                  label: 'Transactions'),
              BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    AppImages.activeProfileIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kPrimaryColor, BlendMode.srcIn),
                  ),
                  icon: SvgPicture.asset(
                    AppImages.profileIcon,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kSecondaryColorTwo, BlendMode.srcIn),
                  ),
                  label: 'Profile')
            ],
          ),
        ),
      ),
    );
  }
}
