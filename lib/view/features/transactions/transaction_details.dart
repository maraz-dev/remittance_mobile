import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_update_tab.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/td_tab_bar.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

enum TransactionStatusUpdate { sent, sending }

class TransactionDetails extends StatefulWidget {
  static String path = 'transaction-details';
  const TransactionDetails({super.key, required this.status});

  final TransactionStatusUpdate status;
  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final int length = 5;

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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.0.height,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.kWhiteColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 20),
                          ),
                          5.0.height,
                          RichTextWidget(
                            text: '${widget.status.name.toUpperCase()} to',
                            hyperlink: ' Olivia Triye',
                            hyperlinkColor: AppColors.kGrey700,
                          ),
                          16.0.height,

                          // Tab Bar
                          const TDLine(),
                          TDTabBar(tabController: _tabController),
                          20.0.height,

                          // Tab Body
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                // Updates Tab
                                TransactionUpdatesTab(
                                  length: length,
                                  widget: widget,
                                ),

                                // Details Tab
                                const Text('Details'),
                              ],
                            ),
                          ),
                          20.0.height,
                        ],
                      ),
                    ),
                  ),
                  24.0.height,
                  Visibility(
                    visible: widget.status == TransactionStatusUpdate.sending,
                    child: MainButton(
                      text: 'Cancel Transaction',
                      color: AppColors.kBrandColor,
                      textColor: AppColors.kPrimaryColor,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TDLine extends StatelessWidget {
  const TDLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.kGrey200, height: 0);
  }
}
