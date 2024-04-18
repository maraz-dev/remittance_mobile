import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class CurrentBalanceWidget extends StatelessWidget {
  const CurrentBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Current USD Balance',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          500.50.amountWithCurrency('usd'),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
        )
      ],
    );
  }
}
