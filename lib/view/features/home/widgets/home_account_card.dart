import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountsCard extends StatelessWidget {
  final Function()? onPressed;
  final String accountImage;
  final double balance;
  final String accountType;
  final bool onclicked;
  const AccountsCard({
    super.key,
    this.onPressed,
    required this.accountImage,
    required this.balance,
    required this.accountType,
    required this.onclicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 30),
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            border: onclicked
                ? Border.all(color: AppColors.kPrimaryColor, width: 2)
                : Border.all(color: AppColors.kGrey300),
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 16.r,
                  backgroundImage: AssetImage(accountImage),
                ),
                Visibility(
                  visible: onclicked,
                  child: Container(
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
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    balance.amountWithCurrency(accountType.toLowerCase()),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kGrey800, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  accountType,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.kGrey800),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
