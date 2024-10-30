import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class KycCard extends StatelessWidget {
  final String? title, subtitle;
  final int current, listener;
  final Function()? onPressed;
  const KycCard({
    super.key,
    this.title,
    this.subtitle,
    this.onPressed,
    required this.current,
    required this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: current <= listener ? AppColors.kGrey50 : AppColors.kBrandColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          current == listener
              ? CardIcon(
                  image: AppImages.kycCurrent,
                  padding: 8,
                  bgColor: AppColors.kCardColor,
                )
              : current < listener
                  ? const CardIcon(
                      image: AppImages.kycAwaiting,
                      padding: 8,
                      bgColor: AppColors.kGrey100,
                    )
                  : CardIcon(
                      image: AppImages.kycDone,
                      padding: 8,
                      bgColor: AppColors.kCardColor,
                    ),
          12.0.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? 'Social Security Number/BVN',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: AppColors.kGrey700),
              ),
              5.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(subtitle ?? 'Provide your social security number or BVN'),
                  ),
                  Visibility(
                    visible: current == listener,
                    child: InkWell(
                      onTap: () {
                        context.pop();
                        onPressed!();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(16.r)),
                        child: Text(
                          'Verify',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: AppColors.kWhiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
