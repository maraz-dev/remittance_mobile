import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

enum TransactionType { send, receive, billPayment, cardFund }

class TransactionCard extends StatelessWidget {
  final Function()? onPressed;
  const TransactionCard({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          const CardIcon(
            image: AppImages.transactionSendMoney,
            bgColor: AppColors.kWarningColor50,
            padding: 8,
          ),
          12.0.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Peter Greene',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.kSecondaryColor,
                    fontWeight: FontWeight.w500),
              ),
              const Text('Send money . 12:21pm'),
            ],
          ),
          const Spacer(),
          Text(
            1500.00.amountWithCurrency('ngn'),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kBlackColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
