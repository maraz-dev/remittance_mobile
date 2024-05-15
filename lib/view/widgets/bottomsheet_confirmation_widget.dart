import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/home/widgets/bottom_sheet_amount_card.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/success_bottomsheet.dart';
import 'package:remittance_mobile/view/widgets/transaction_pin_sheet.dart';

class BottomSheetConfirmationWidget extends StatefulWidget {
  final String? title, subtitle, text, buttonText;
  const BottomSheetConfirmationWidget({
    super.key,
    this.title,
    this.subtitle,
    this.text,
    this.buttonText,
  });

  @override
  State<BottomSheetConfirmationWidget> createState() =>
      _BottomSheetConfirmationWidgetState();
}

class _BottomSheetConfirmationWidgetState
    extends State<BottomSheetConfirmationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: () => context.pop(),
            child: SvgPicture.asset(AppImages.boxBackArrow)),
        16.0.height,
        BottomSheetTitle(
          title: widget.title ?? 'Add Money',
          subtitle: widget.subtitle ??
              'The amount below will be added into your USD account',
        ),
        widget.text == null ? 0.0.height : 24.0.height,
        Text(widget.text ?? ''),
        24.0.height,
        const BSAmountCard(),
        5.0.height,
        const AdditionalFeeText(),
        40.0.height,
        MainButton(
            text: widget.buttonText ?? 'Add Money',
            onPressed: () {
              context.pop();
              AppBottomSheet.showBottomSheet(
                context,
                isDismissible: false,
                widget: TransactionPinSheet(
                  onPressed: () {
                    AppBottomSheet.showBottomSheet(
                      context,
                      isDismissible: false,
                      widget: const SuccessBottomSheet(),
                    );
                    if (mounted) {
                      //context.pop();
                      AppBottomSheet.showBottomSheet(
                        context,
                        isDismissible: false,
                        widget: const SuccessBottomSheet(),
                      );
                    }
                  },
                ),
              );
            }),
        12.0.height
      ],
    );
  }
}
