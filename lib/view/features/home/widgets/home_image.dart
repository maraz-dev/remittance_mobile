import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class HomeImage extends StatelessWidget {
  final String? title, description, image;
  const HomeImage({
    super.key,
    this.title,
    this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.asset(
            image ?? AppImages.forYouOne,
            width: 240.w,
            fit: BoxFit.cover,
            color: AppColors.kGrey800.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  title ?? 'Refer a Friend',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, color: AppColors.kWhiteColor),
                ),
              ),
              3.0.height,
              SizedBox(
                width: 200.w,
                height: 50,
                child: Text(
                  description ?? 'Virtual card services are provided by Mastercard Inc',
                  style:
                      Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.kWhiteColor),
                ),
              ),
              20.0.height
            ],
          ),
        )
      ],
    );
  }
}

List forYouList = [
  const HomeImage(
    title: 'Fund Conveniently',
    description: 'Enhance connections with loved ones, Fund and transfer money effortlessly.',
    image: AppImages.forYouOne,
  ),
  const HomeImage(
    title: 'Send Money Easily!',
    description: 'Send Money Anytime, Anywhere — We\'ve Got You Covered!',
    image: AppImages.forYouTwo,
  ),
];
