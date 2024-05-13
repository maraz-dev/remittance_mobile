import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/recent_transaction_header.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class LatestTransactionsBox extends StatelessWidget {
  const LatestTransactionsBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const RecentTransactionHeader(),
          24.0.height,
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => const TransactionCard(),
            separatorBuilder: (context, index) => 24.0.height,
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
