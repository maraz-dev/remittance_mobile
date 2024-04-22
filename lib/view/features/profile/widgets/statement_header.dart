import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class StatementYearHeader extends StatelessWidget {
  final String? text;
  const StatementYearHeader({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '2024',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w900, color: AppColors.kSecondaryColor),
    );
  }
}
