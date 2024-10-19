import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class BalanceWidget extends StatelessWidget {
  final String balance;
  final double? fontSize;
  const BalanceWidget({
    super.key,
    required this.balance,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Balance:',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: AppColors.kGrey500,
                fontSize: fontSize,
              ),
        ),
        4.0.width,
        Text(
          balance,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: fontSize,
              ),
        ),
      ],
    );
  }
}
