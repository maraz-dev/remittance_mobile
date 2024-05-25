import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.kPinInputColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.kPrimaryColor),
      ),
      child: SvgPicture.asset(
        AppImages.dot,
        colorFilter: AppColors.kPrimaryColor.colorFilterMode(),
      ),
    );
  }
}
