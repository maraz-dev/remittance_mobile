import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          SvgPicture.asset(AppImages.debit),
          12.0.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Peter Greene',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.kSecondaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const Text('Send money . 12:21pm'),
            ],
          ),
          const Spacer(),
          Text(
            1500.00.amountWithCurrency('ngn'),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.kErrorColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
