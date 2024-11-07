import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdraw_money_view.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class DeactivateSheet extends StatelessWidget {
  const DeactivateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(text: 'Deactivate'),
        50.0.height,
        const Center(
          child: CardIcon(
            image: AppImages.deactivate,
            bgColor: AppColors.kGrey100,
            padding: 30,
          ),
        ),
        24.0.height,
        Text(
          'Are you sure you want to deactivate this account?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.kGrey700,
              ),
        ),
        32.0.height,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kWarningColor100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deactivating an account means you will no longer be able to use it.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.kGrey700),
              ),
              10.0.height,
              Text(
                'All currently held funds will be automatically sent to one of your preferred added withdrawal bank accounts.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.kGrey700),
              ),
            ],
          ),
        ),
        50.0.height,
        MainButton(
            text: 'Deactivate Account',
            onPressed: () {
              context.pop();
              context.pushNamed(WithdrawMoneyView.path);
            })
      ],
    );
  }
}
