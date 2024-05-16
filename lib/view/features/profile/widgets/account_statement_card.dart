import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountStatementCard extends StatelessWidget {
  const AccountStatementCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kTextBorderColor,
            ),
            child: SvgPicture.asset(
              AppImages.documentText,
              colorFilter: const ColorFilter.mode(
                  AppColors.kPrimaryColor, BlendMode.srcIn),
            ),
          ),
          12.0.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statement for Apr.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.kGrey700, fontWeight: FontWeight.bold),
              ),
              const Text('12:21pm'),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.kGrey100,
              borderRadius: BorderRadius.circular(36.r),
            ),
            child: Row(
              children: [
                Text(
                  'Export',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.kGrey700,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_sharp,
                  size: 14,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
