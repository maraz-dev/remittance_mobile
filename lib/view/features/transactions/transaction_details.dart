import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/td_tab_bar.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/update_text.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:timelines/timelines.dart';

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

                          20.0.height,
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FixedTimeline.tileBuilder(
                                        mainAxisSize: MainAxisSize.min,
                                        theme: TimelineThemeData(
                                          nodePosition: 0,
                                          indicatorPosition: 0,
                                          connectorTheme:
                                              const ConnectorThemeData(
                                            indent: 7,
                                            color: AppColors.kGrey200,
                                            thickness: 1,
                                          ),
                                        ),
                                        builder: TimelineTileBuilder.connected(
                                          contentsAlign: ContentsAlign.basic,
                                          contentsBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: index == 2 ? 0 : 30,
                                              ),
                                              child: const UpdateText(),
                                            );
                                          },
                                          connectorBuilder:
                                              (context, index, type) {
                                            return const SolidLineConnector(
                                              color: AppColors.kGrey200,
                                            );
                                          },
                                          indicatorBuilder: (context, index) {
                                            if (index != 2) {
                                              return const TransactionIndicator();
                                            } else {
                                              switch (widget.status) {
                                                case TransactionStatusUpdate
                                                      .sent:
                                                  return const TransactionIndicator(
                                                    padding: 6,
                                                    backColor:
                                                        AppColors.kBrandColor,
                                                    image: AppImages.dot,
                                                    borderColor:
                                                        AppColors.kPrimaryColor,
                                                  );
                                                case TransactionStatusUpdate
                                                      .sending:
                                                  return const TransactionIndicator(
                                                    image: AppImages.closeIcon,
                                                    borderColor: AppColors
                                                        .kWarningColor500,
                                                  );
                                              }
                                            }
                                          },
                                          itemCount: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text('Details'),
                              ],
                            ),
                          ),
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

class TransactionIndicator extends StatelessWidget {
  final double? padding;
  final String? image;
  final Color? backColor, borderColor;
  const TransactionIndicator({
    super.key,
    this.padding,
    this.image,
    this.backColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return DotIndicator(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(padding ?? 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backColor ?? Colors.transparent,
          border: Border.all(color: borderColor ?? AppColors.kGrey200),
        ),
        child: SvgPicture.asset(
          image ?? AppImages.check,
          colorFilter: borderColor?.colorFilterMode(),
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
