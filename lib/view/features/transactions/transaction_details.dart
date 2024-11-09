import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_update_tab.dart';
import 'package:remittance_mobile/view/features/transactions/transactions_details_tab.dart';
import 'package:remittance_mobile/view/features/transactions/vm/transactions_vm.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/td_tab_bar.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

enum TransactionStatusUpdate { sent, sending }

class TransactionDetails extends ConsumerStatefulWidget {
  static String path = 'transaction-details/:id/:fromSend';
  const TransactionDetails({
    super.key,
    required this.status,
    required this.requestId,
    this.fromSend = "false",
  });

  final String requestId, fromSend;
  final TransactionStatusUpdate status;
  @override
  ConsumerState<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends ConsumerState<TransactionDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final int length = 10;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final transxDetails = ref.watch(getTransactionDetailProvider(widget.requestId));

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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.kWhiteColor,
                      ),
                      child: transxDetails.maybeWhen(
                        data: (data) {
                          return Column(
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
                                data.detail?.trxAmount
                                        .amountWithCurrency(data.detail?.currency?.symbol ?? '') ??
                                    0.0.amountWithCurrency('\$'),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 20),
                              ),
                              5.0.height,
                              RichTextWidget(
                                text: '${widget.status.name.toUpperCase()} to ',
                                hyperlink: data.detail?.beneficiary!.split('|')[1] ?? "",
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
                                    // Details Tab
                                    TransactionDetailsTab(
                                      transxDetail: data.detail ?? TransxDetail(),
                                    ),

                                    // Updates Tab
                                    TransactionUpdatesTab(
                                      length: data.updates?.length ?? 0,
                                      widget: widget,
                                      transxUpdates: data.updates ?? [],
                                    ),
                                  ],
                                ),
                              ),
                              20.0.height,
                            ],
                          );
                        },
                        orElse: () => const Center(
                          child: SpinKitRing(
                            color: AppColors.kPrimaryColor,
                            size: 100,
                            lineWidth: 3,
                          ),
                        ),
                        error: (error, stackTrace) => kDebugMode
                            ? Center(
                                child: Text(error.toString()),
                              )
                            : const Center(
                                child: Text('An Error Occured'),
                              ),
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
      bottomNavigationBar: widget.fromSend != "false"
          ? BottomNavBarWidget(
              children: [
                MainButton(
                  text: 'Done',
                  onPressed: () {
                    context.goNamed(DashboardView.path);
                  },
                )
                    .animate()
                    .fadeIn(begin: 0, delay: 1000.ms)
                    // .then(delay: 200.ms)
                    .slideY(begin: .1, end: 0)
              ],
            )
          : null,
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
