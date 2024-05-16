import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    const TDLine(),
                    TDTabBar(tabController: _tabController),
                    20.0.height,

                    // Tab Body
                    SizedBox(
                      height: 100,
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          Text('Updates'),
                          Text('Details'),
                        ],
                      ),
                    ),
                    20.0.height
                  ],
                ),
              ),
              24.0.height,
              MainButton(
                text: 'Cancel Transaction',
                color: AppColors.kBrandColor,
                textColor: AppColors.kPrimaryColor,
                onPressed: () {},
              ),
            ],
          ),
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
