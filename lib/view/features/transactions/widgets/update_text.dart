import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class UpdateText extends StatelessWidget {
  final String? date, time, desc;
  final Color? textColor;

  const UpdateText({
    super.key,
    this.date,
    this.time,
    this.desc,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date ?? '15th Feb',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.kGrey700,
                    ),
              ),
              8.0.width,
              Text(
                time ?? '09:00 AM',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          Text(
            desc ?? 'You started a Transfer',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
