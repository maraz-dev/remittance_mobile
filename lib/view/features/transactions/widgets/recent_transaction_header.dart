import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_history_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class RecentTransactionHeader extends StatelessWidget {
  const RecentTransactionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Latest Transactions',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        InkWell(
          onTap: () => context.pushNamed(TransactionHistoryView.path),
          child: Text(
            'See All',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
