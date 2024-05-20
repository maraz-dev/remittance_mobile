import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class AccountsTitle extends StatelessWidget {
  final bool isCardListEmpty;
  const AccountsTitle({
    super.key,
    required this.isCardListEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SectionHeader(text: 'Accounts'),

        // Swap and Add Currency Button
        Visibility(
            visible: isCardListEmpty,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.kWhiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.kGrey300),
                  ),
                  child: SvgPicture.asset(AppImages.swap),
                ),
                8.0.width,
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Add',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.kWhiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SvgPicture.asset(
                        AppImages.add,
                        colorFilter: AppColors.kWhiteColor.colorFilterMode(),
                      ),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
