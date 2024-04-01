import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay_mobile/view/theme/app_colors.dart';
import 'package:smart_pay_mobile/view/utils/app_images.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      radius: 0,
      onTap: () => context.pop(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.kBorderColor)),
        child: SvgPicture.asset(
          AppImages.backArrow,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
