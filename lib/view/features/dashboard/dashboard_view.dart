import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
    const Center(child: Text('Home')),
    const Center(child: Text('Services')),
    const Center(child: Text('Accounts')),
    const Center(child: Text('Profile')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: AppColors.kBlackColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
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
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: AppColors.kPrimaryColor,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            letterSpacing: 0,
            color: AppColors.kTextColor,
          ),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.homeIcon), label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.servicesIcon),
                label: 'Services'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.accountsIcon),
                label: 'Accounts'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.profileIcon), label: 'Profile')
          ],
        ),
      ),
    );
  }
}
