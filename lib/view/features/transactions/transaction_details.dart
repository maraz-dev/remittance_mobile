import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/td_tab_bar.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_details_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

enum TransactionStatusUpdate { sent, sending }

class TransactionDetails extends StatefulWidget {
  static String path = 'transaction-details';
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Transaction Details'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              20.0.height,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.kWhiteColor,
                ),
                child: Column(
                  children: [
                    16.0.height,
                    // Basic Details
                    const CardIcon(
                      image: AppImages.timer,
                      bgColor: AppColors.kGrey200,
                    ),
                    16.0.height,
                    Text(
                      50000.amountWithCurrency('ngn'),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    5.0.height,
                    RichTextWidget(
                      text:
                          '${TransactionStatusUpdate.sending.name.toUpperCase()} to',
                      hyperlink: ' Olivia Triye',
                      hyperlinkColor: AppColors.kGrey700,
                    ),
                    16.0.height,

                    // Tab Bar
                    const Divider(color: AppColors.kGrey200, height: 0),
                    TDTabBar(tabController: _tabController),
                    32.0.height,

                    /// Details
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 21),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kBorderColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TUpdateCard(
                            title: 'Sender Name',
                            text: 'Peter Greene',
                          ),
                          24.0.height,
                          const TUpdateCard(
                            title: 'Transaction Type',
                            text: 'Send Money',
                          ),
                          24.0.height,
                          const TUpdateCard(
                            title: 'Recipient Name',
                            text: 'Paul Blu',
                          ),
                          24.0.height,
                          const TUpdateCard(
                            title: 'Recipient Bank',
                            text: 'First Bank Nigeria',
                          ),
                          24.0.height,
                          const TUpdateCard(
                            title: 'Recipient Account Number',
                            text: '982377362',
                          ),
                          24.0.height,
                          TUpdateCard(
                            title: 'Additional Fees',
                            text: 2.52.amountWithCurrency('usd'),
                          ),
                          24.0.height,
                          const TUpdateCard(
                            title: 'Transaction ID',
                            text: '9837982372838',
                          ),
                          24.0.height,
                          const TUpdateCard(
                            title: 'Account Name',
                            text: 'USD Account',
                          ),
                        ],
                      ),
                    ),
                    30.0.height
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
