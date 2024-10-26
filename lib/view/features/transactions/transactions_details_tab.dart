import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_transaction_detail.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class TransactionDetailsTab extends StatelessWidget {
  final TransxDetail transxDetail;
  const TransactionDetailsTab({
    super.key,
    required this.transxDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            text: 'Transfer Details',
            fontSize: 14,
          ),
          16.0.height,
          TrxItems(
            fontSize: 12,
            title: 'You are sending',
            description: '${transxDetail.trxAmount.amountInt()} ${transxDetail.currency}',
          ),
          12.0.height,
          TrxItems(
            fontSize: 12,
            descFontSize: 12,
            title: 'Total Fees',
            description: '${transxDetail.trxFee.amountInt()} ${transxDetail.currency}',
          ),
          12.0.height,
          TrxItems(
            fontSize: 12,
            descFontSize: 12,
            title: 'Transaction Type',
            description: '${transxDetail.postingType}',
          ),
          12.0.height,
          TrxItems(
            fontSize: 12,
            descFontSize: 12,
            title: 'Reference',
            description: '${transxDetail.reference}',
          ),
          12.0.height,
          TrxItems(
            fontSize: 12,
            descFontSize: 12,
            title: 'Narration',
            description: '${transxDetail.narration}'.truncate(25),
          ),
          12.0.height,
          TrxItems(
            fontSize: 12,
            descFontSize: 12,
            title: 'Date/Time',
            description: '${transxDetail.transactionDate?.transactionDate()}',
          ),
          12.0.height,
          const Divider(color: AppColors.kGrey200),
          12.0.height,
          const SectionHeader(
            text: 'Recipients Details',
            fontSize: 14,
          ),
          16.0.height,
          TrxItems(
            fontSize: 12,
            title: 'Name',
            description: '${transxDetail.beneficiary?.split('|')[1]}',
          ),
          12.0.height,
          TrxItems(
            fontSize: 12,
            descFontSize: 12,
            title: 'Service Type',
            description: '${transxDetail.serviceTypeChannel}',
          ),
          12.0.height,
          TrxItems(
            fontSize: 12,
            descFontSize: 12,
            title: 'Account Number',
            description: '${transxDetail.beneficiary?.split('|')[2]}',
          ),
          12.0.height,
        ],
      ),
    );
  }
}
