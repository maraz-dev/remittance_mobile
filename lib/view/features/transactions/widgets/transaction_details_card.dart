import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class TUpdateCard extends StatelessWidget {
  final String? title, text;
  const TUpdateCard({
    super.key,
    this.title,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? 'Sender Name'),
        Text(
          text ?? 'Peter Greene',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kGrey700,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
