import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class HomeImage extends StatelessWidget {
  const HomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.homeBannerImage,
          height: 95.h,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This is an ad banner placement',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.kWhiteColor),
              ),
              5.0.height,
              SizedBox(
                width: 261.w,
                child: Text(
                  'Description goes here. Description goes here. Description goes here. Description goes here. Description goes here. ',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 10.sp, color: AppColors.kWhiteColor),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        )
      ],
    );
  }
}
