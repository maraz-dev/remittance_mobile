import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_indicator.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/update_text.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/button_with_icon.dart';
import 'package:timelines/timelines.dart';

class TransactionUpdatesTab extends StatelessWidget {
  const TransactionUpdatesTab({
    super.key,
    required this.length,
    required this.widget,
  });

  final int length;
  final TransactionDetails widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FixedTimeline.tileBuilder(
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
                  final conditionTwo =
                      widget.status == TransactionStatusUpdate.sending;
                  final bothConditions = conditionOne && conditionTwo;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: conditionOne ? 0 : 30,
                    ),
                    child: Column(
                      children: [
                        UpdateText(
                          textColor: bothConditions
                              ? AppColors.kWarningColor500
                              : null,
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
                onTap: () {},
                child: const ButtonWithIcon(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
