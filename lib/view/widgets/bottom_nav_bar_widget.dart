import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class BottomNavBarWidget extends StatelessWidget {
  final double? height;
  final List<Widget> children;
  const BottomNavBarWidget({
    super.key,
    this.height,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      //height: height ?? 80.h,
      decoration: BoxDecoration(
        color: AppColors.kGrey50,
        boxShadow: [
          BoxShadow(
            color: AppColors.kBoxShadowColor,
            blurRadius: 2,
            offset: const Offset(0, -1),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children),
      ),
    );
  }
}
