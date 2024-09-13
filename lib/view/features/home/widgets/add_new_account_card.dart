import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/features/home/account-view/create_account_sheet.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AddNewAccountCard extends StatelessWidget {
  const AddNewAccountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppBottomSheet.showBottomSheet(
          context,
          widget: const CreateCustomerAccountSheet(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.kGrey300)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardIcon(
              image: AppImages.add,
              bgColor: AppColors.kPrimaryColor,
              padding: 5,
              iconColor: AppColors.kWhiteColor.colorFilterMode(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(
                    'Add New',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kGrey800, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '50+ Currencies',
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
