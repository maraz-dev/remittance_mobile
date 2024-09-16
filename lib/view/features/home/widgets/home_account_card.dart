import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountsCard extends StatelessWidget {
  final Function()? onPressed;
  final String accountImage;
  final double balance;
  final String accountCurrency;
  final bool onclicked;
  const AccountsCard({
    super.key,
    this.onPressed,
    required this.accountImage,
    required this.balance,
    required this.accountCurrency,
    required this.onclicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 20),
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            border: null,
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 125,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundImage: AssetImage(accountImage),
                  ),
                  // Visibility(
                  //   visible: false,
                  //   child: const CustomRadioButton(),
                  // )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    balance.amountWithCurrency(accountCurrency.toLowerCase()),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kGrey800, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  accountCurrency,
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
