import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class TrxItems extends StatelessWidget {
  final String? title, description;
  const TrxItems({
    super.key,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? 'Buy'),
        Text(
          description ?? '1000 USD',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.kGrey700,
              ),
        ),
      ],
    );
  }
}
