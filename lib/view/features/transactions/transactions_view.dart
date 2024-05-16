import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/flow_card.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/latest_transaction_box.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_category_dropdown.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class TransactionsView extends StatefulWidget {
  static String path = '/transactions-view';
  const TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const SectionHeader(text: 'Transactions'),
        backgroundColor: AppColors.kWhiteColor,
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 1,
      ),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TransxCatergoryDropdown(
                    title: 'NGN Account',
                  ),
                  TransxCatergoryDropdown(
                    title: 'This Week',
                  ),
                ],
              ),
              24.0.height,

              // Inflow and Outflow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FlowCard(
                      text: 'Inflow',
                      icon: const CardIcon(image: AppImages.transactionInflow),
                      amount: 0.0.amountWithCurrency('ngn'),
                    ),
                  ),
                  16.0.width,
                  Expanded(
                    child: FlowCard(
                      text: 'Outflow',
                      icon: const CardIcon(
                        image: AppImages.transactionOutflow,
                        bgColor: AppColors.kWarningColor50,
                      ),
                      amount: 0.0.amountWithCurrency('ngn'),
                      textColor: AppColors.kWarningColor,
                    ),
                  ),
                ],
              ),
              16.0.height,

              // Latest Transactions
              const LatestTransactionsBox(),
              16.0.height,

              // Statements
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const CardIcon(
                      image: AppImages.transactionStatement,
                      bgColor: AppColors.kBrandColor,
                    ),
                    16.0.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Statements',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColors.kGrey700,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Download your Account Statements',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              32.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
