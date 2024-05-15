import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class TransxCatergoryDropdown extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const TransxCatergoryDropdown({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(32.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kBlackColor, fontWeight: FontWeight.w500),
            ),
            10.0.width,
            SvgPicture.asset(
              AppImages.arrowDown,
              colorFilter: const ColorFilter.mode(
                  AppColors.kBlackColor, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }
}
