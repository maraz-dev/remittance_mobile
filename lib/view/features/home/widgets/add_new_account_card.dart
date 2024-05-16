import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class AddNewAccountCard extends StatelessWidget {
  const AddNewAccountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.kPrimaryColor,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: const [10, 10],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.kTextBorderColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppImages.homeViewAdd),
            Text(
              'Add New \t',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kGrey700, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
