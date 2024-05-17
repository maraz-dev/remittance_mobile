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
  final String? title, subtitle, buttonText;
  final bool? isAddMoney;
  final Function()? action;
  const SuccessBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    this.isAddMoney,
    this.action,
    this.buttonText,
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
          text: buttonText ?? 'Back to Home',
          onPressed: action ??
              () {
                context.pushReplacementNamed(DashboardView.path);
              },
        ),
        Visibility(
          visible: isAddMoney ?? false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.0.height,
              MainButton(
                text: 'See Transaction Receipt',
                color: AppColors.kWhiteColor,
                textColor: AppColors.kGrey700,
                borderColor: AppColors.kGrey300,
                onPressed: () {
                  context.pop();
                  context.pushNamed(TransactionDetails.path);
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
