import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class SuccessBottomSheet extends StatelessWidget {
  final String? title, subtitle;
  final bool? isAddMoney;
  const SuccessBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    this.isAddMoney,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.success),
        16.0.height,
        BottomSheetTitle(
          title: title ?? 'Funds Added Successfully',
          subtitle: subtitle ??
              'Great job! You have successfully added ${500.amountWithCurrency('usd')} to your USD Account',
        ),
        40.0.height,
        MainButton(
          text: 'Back to Home',
          onPressed: () {
            context.pushReplacementNamed(DashboardView.path);
          },
        ),
        Visibility(
          visible: isAddMoney ?? true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.0.height,
              MainButton(
                text: 'See Transaction Receipt',
                color: AppColors.kWhiteColor,
                textColor: AppColors.kSecondaryColor,
                borderColor: AppColors.kBorderColor,
                onPressed: () {
                  context.pop();
                  context.pushNamed(AddMoneyTransactionDetails.path);
                },
              ),
            ],
          ),
        ),
        16.0.height
      ],
    );
  }
}
