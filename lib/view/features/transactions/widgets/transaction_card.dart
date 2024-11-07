import 'package:flutter/material.dart';
import 'package:remittance_mobile/data/models/responses/customer_transaction_model.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

enum TransactionType { send, receive, billPayment, cardFund }

class TransactionCard extends StatelessWidget {
  final Function()? onPressed;
  final TransactionsRes transxItem;
  const TransactionCard({
    super.key,
    this.onPressed,
    required this.transxItem,
  });

  Widget transxIcon() {
    if (transxItem.postingType == "Cr" && transxItem.narration!.contains('Card')) {
      return const CardIcon(
        image: AppImages.transactionCardFund,
        bgColor: AppColors.kSuccessColor50,
        padding: 8,
      );
    } else if (transxItem.postingType == "Cr") {
      return const CardIcon(
        image: AppImages.transactionReceiveMoney,
        bgColor: AppColors.kSuccessColor50,
        padding: 8,
      );
    } else if (transxItem.postingType == "Dr") {
      return const CardIcon(
        image: AppImages.transactionSendMoney,
        bgColor: AppColors.kWarningColor50,
        padding: 8,
      );
    } else {
      return const CardIcon(
        image: AppImages.transactionSendMoney,
        bgColor: AppColors.kWarningColor50,
        padding: 8,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          transxIcon(),
          12.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transxItem.postingType == "Cr" && transxItem.narration!.contains('Card')
                          ? 'Card Fund'
                          : transxItem.beneficiary!.split('|')[1].truncate(20),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      transxItem.trxAmount?.amountWithCurrency(transxItem.currency?.symbol ?? "") ??
                          0.0.amountWithCurrency(""),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.kBlackColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                    '${transxItem.narration!.split('|').first} | ${transxItem.transactionDate?.to12HourFormat()}'
                        .truncate(30)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
