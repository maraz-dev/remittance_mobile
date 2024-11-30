import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class ShareReceiptItem extends StatelessWidget {
  const ShareReceiptItem({
    super.key,
    required this.image,
    required this.text,
    this.onPressed,
  });

  final String image, text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kGrey100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CardIcon(
              image: image,
              bgColor: AppColors.kGrey200,
            ),
            12.0.width,
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.kGrey700,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
