// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/verify_transx_req.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/verify_transx_funding_vm.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/alert_dialog.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class UssdFundSheet extends ConsumerStatefulWidget {
  final String bank, ussdCode;
  final double amount;
  final int flwTransactionId;
  const UssdFundSheet({
    super.key,
    required this.bank,
    required this.ussdCode,
    required this.flwTransactionId,
    required this.amount,
  });

  @override
  ConsumerState<UssdFundSheet> createState() => _UssdFundSheetState();
}

class _UssdFundSheetState extends ConsumerState<UssdFundSheet> {
  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(verifyFundingTransxProvider).isLoading;

    ref.listen(verifyFundingTransxProvider, (_, next) {
      if (next is AsyncData) {
        context.pop();
        context.goNamed(DashboardView.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        8.0.height,

        // Heading
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeader(text: 'USSD Code'),
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
        16.0.height,

        // Description
        const Text('Fund Amount'),
        10.0.height,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kGrey200,
          ),
          child: Center(
            child: Text(
              '${widget.amount.formatDecimal()} ${accountInfo.value.currencyCode}',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.kGrey500),
            ),
          ),
        ),
        16.0.height,
        // Contents
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.kGrey100,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.ussdCode,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        8.0.height,
                        Text(widget.bank),
                      ],
                    ),
                  ),
                  8.0.width,
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: widget.ussdCode)).then((value) {
                        ShowAlertDialog.showAlertDialog(
                          context,
                          title: 'Success',
                          content: 'USSD Code Copied',
                          defaultActionText: 'Ok',
                        );
                      });
                    },
                    child: const CardIcon(
                      image: AppImages.copy,
                      padding: 8,
                      bgColor: AppColors.kWhiteColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        24.0.height,
        MainButton(
          isLoading: loading,
          text: "I've made this transfer",
          onPressed: () {
            ref.read(verifyFundingTransxProvider.notifier).verifyFundingTransxMethod(
                  VerifyFundingTransxReq(
                    flwTransactionId: widget.flwTransactionId,
                  ),
                );
          },
        ),
        16.0.height,
      ],
    );
  }
}

class AccountDetailsCard extends StatelessWidget {
  final String? title, value;
  final bool showCopy;
  const AccountDetailsCard({
    super.key,
    this.title,
    this.value,
    this.showCopy = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Account Name',
            ),
            Text(
              value ?? 'Peter Greene',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.kGrey700,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        if (showCopy) ...[
          const CardIcon(
            image: AppImages.copy,
            padding: 8,
            bgColor: AppColors.kGrey100,
          )
        ]
      ],
    );
  }
}
