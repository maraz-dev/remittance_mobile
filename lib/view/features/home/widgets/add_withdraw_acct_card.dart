import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AddWithdrawalBankAccountCard extends StatelessWidget {
  final Function()? onPressed;
  const AddWithdrawalBankAccountCard({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 8, 14, 8),
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const CardIcon(
              padding: 8,
              image: AppImages.accountDetails,
              bgColor: AppColors.kGrey200,
            ),
            8.0.width,
            Text(
              'Add Withdrawal Bank Account',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kGrey700, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            SvgPicture.asset(AppImages.add)
          ],
        ),
      ),
    );
  }
}
