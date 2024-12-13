import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/core/utils/app_func_utils.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/share_receipt_item.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_indicator.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/update_text.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/button_with_icon.dart';
import 'package:remittance_mobile/view/widgets/receipt_image.dart';
import 'package:remittance_mobile/view/widgets/receipt_pdf.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';
import 'package:timelines/timelines.dart';

class TransactionUpdatesTab extends StatelessWidget {
  const TransactionUpdatesTab({
    super.key,
    required this.length,
    required this.widget,
    required this.transxUpdates,
    required this.transxDetail,
  });

  final int length;
  final TransactionDetails widget;
  final List<TransxUpdate> transxUpdates;
  final TransxDetail transxDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            transxUpdates.isEmpty
                ? const Center(
                    child: Text('No Update for this Transaction'),
                  )
                : FixedTimeline.tileBuilder(
                    mainAxisSize: MainAxisSize.min,
                    theme: TimelineThemeData(
                      nodePosition: 0,
                      indicatorPosition: 0,
                      connectorTheme: const ConnectorThemeData(
                        indent: 7,
                        color: AppColors.kGrey200,
                        thickness: 1,
                      ),
                    ),
                    builder: TimelineTileBuilder.connected(
                      contentsAlign: ContentsAlign.basic,
                      contentsBuilder: (context, index) {
                        final conditionOne = index == length - 1;
                        final conditionTwo = widget.status == TransactionStatusUpdate.sending;
                        final bothConditions = conditionOne && conditionTwo;
                        var value = transxUpdates[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: conditionOne ? 0 : 30,
                          ),
                          child: Column(
                            children: [
                              UpdateText(
                                date: value.dateCreated?.toFormattedDate(),
                                time: value.dateCreated?.to12HourFormat(),
                                desc: value.comment,
                                textColor: bothConditions ? AppColors.kWarningColor500 : null,
                              ),

                              // Show Query Transaction Button
                              if (bothConditions) ...[
                                8.0.height,
                                Padding(
                                  padding: const EdgeInsets.only(right: 120),
                                  child: MainButton(
                                    text: "Requery Transaction",
                                    textColor: AppColors.kPrimaryColor,
                                    borderColor: AppColors.kPrimaryColor,
                                    color: Colors.white,
                                    borderRadius: 32,
                                    fontSize: 12,
                                    padding: 8,
                                    onPressed: () {},
                                  ),
                                )
                              ]
                            ],
                          ),
                        );
                      },
                      connectorBuilder: (context, index, type) {
                        return const SolidLineConnector(
                          color: AppColors.kGrey200,
                        );
                      },
                      indicatorBuilder: (context, index) {
                        if (index != length - 1) {
                          return const TransactionIndicator();
                        } else {
                          switch (widget.status) {
                            case TransactionStatusUpdate.sent:
                              return const TransactionIndicator(
                                padding: 6,
                                backColor: AppColors.kBrandColor,
                                image: AppImages.dot,
                                borderColor: AppColors.kPrimaryColor,
                              );
                            case TransactionStatusUpdate.sending:
                              return const TransactionIndicator(
                                image: AppImages.closeIcon,
                                borderColor: AppColors.kWarningColor500,
                              );
                          }
                        }
                      },
                      itemCount: length,
                    ),
                  ),

            // Show Share Receipt Button
            if (widget.status == TransactionStatusUpdate.sent) ...[
              24.0.height,
              GestureDetector(
                onTap: () {
                  AppBottomSheet.showBottomSheet(
                    context,
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionHeader(text: 'Share Receipt'),
                            InkWell(
                              onTap: () => context.pop(),
                              child: SvgPicture.asset(
                                AppImages.closeIcon,
                                colorFilter: AppColors.kGrey700.colorFilterMode(),
                                width: 24,
                                height: 24,
                              ),
                            )
                          ],
                        ),
                        32.0.height,
                        ShareReceiptItem(
                          image: AppImages.documentUploadIcon,
                          text: 'PDF',
                          onPressed: () async {
                            context.pop();
                            final result = await SharePDF.pdfTransxReceipt(details: transxDetail);
                            await AppUtils.shareFile(result);
                          },
                        ),
                        16.0.height,
                        ShareReceiptItem(
                          image: AppImages.imageUploadIcon,
                          text: 'Image',
                          onPressed: () async {
                            context.pop();
                            final result = await ShareImage.imgTransxReceipt(details: transxDetail);
                            await AppUtils.shareFile(result);
                          },
                        ),
                        16.0.height,
                      ],
                    ),
                  );
                },
                child: const ButtonWithIcon(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
