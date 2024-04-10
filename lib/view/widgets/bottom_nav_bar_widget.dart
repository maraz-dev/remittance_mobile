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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      height: height ?? 140,
      decoration: BoxDecoration(
        color: AppColors.kBackgroundColor,
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
            mainAxisAlignment: MainAxisAlignment.center, children: children),
      ),
    );
  }
}
