import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class SwapIconWidget extends StatelessWidget {
  final double? padding;
  const SwapIconWidget({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.kGrey100,
        shape: BoxShape.circle,
      ),
      child: CardIcon(
        padding: padding,
        image: AppImages.swapAlt,
        bgColor: AppColors.kGrey700,
      ),
    );
  }
}
