import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class AccountsCard extends StatelessWidget {
  final Function()? onPressed;
  const AccountsCard({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 50),
        decoration: BoxDecoration(
            color: AppColors.kCardColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundImage: const AssetImage(AppImages.us),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$500.21',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.kWhiteColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'USD',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.kWhiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
