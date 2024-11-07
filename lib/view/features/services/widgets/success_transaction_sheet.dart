import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class SuccessTranxSheet extends StatefulWidget {
  final String amount, accountDetails, requestId;
  const SuccessTranxSheet({
    super.key,
    required this.amount,
    required this.accountDetails,
    required this.requestId,
  });

  @override
  State<SuccessTranxSheet> createState() => _SuccessTranxSheetState();
}

class _SuccessTranxSheetState extends State<SuccessTranxSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.success),
        16.0.height,
        const BottomSheetTitle(
          title: 'Funds Transfer Successful',
        ),
        8.0.height,
        RichText(
          text: TextSpan(
              text: 'You have successfully sent ',
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: widget.amount,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.kGrey700,
                      ),
                ),
                TextSpan(
                  text: ' sent to ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: widget.accountDetails,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.kGrey700,
                      ),
                ),
              ]),
        ),
        40.0.height,
        MainButton(
          text: 'Back to Home',
          onPressed: () {
            context.goNamed(DashboardView.path);
          },
        ),
        12.0.height,
        MainButton(
          text: 'See Transaction Receipt',
          color: AppColors.kWhiteColor,
          borderColor: AppColors.kGrey300,
          textColor: AppColors.kGrey700,
          onPressed: () {
            // Set all the Value Notifiers to Default
            setState(() {
              sourceCorridor.value = CorridorsResponse();
              sourceCurrency.value = DestinationCountry();
              destinationCorridor.value = DestinationCountry();
              destinationCurrency.value = DestinationCurrency();
              showCharge.value = false;
            });
            context.pop();
            context.pushNamed(
              TransactionDetails.path,
              pathParameters: {
                "id": widget.requestId,
                "fromSend": "true",
              },
              extra: TransactionStatusUpdate.sent,
            );
          },
        ),
        16.0.height
      ],
    );
  }
}
