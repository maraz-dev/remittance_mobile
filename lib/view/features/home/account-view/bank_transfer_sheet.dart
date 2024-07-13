import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

enum TransferCountry { ngn, usd }

class BankTransferSheet extends StatefulWidget {
  final TransferCountry transferCountry;
  const BankTransferSheet({
    super.key,
    required this.transferCountry,
  });

  @override
  State<BankTransferSheet> createState() => _BankTransferSheetState();
}

class _BankTransferSheetState extends State<BankTransferSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        8.0.height,

        // Heading
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeader(text: 'Bank Transfer'),
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
        switch (widget.transferCountry) {
          TransferCountry.ngn => Text(
              '${1.05.amountWithCurrency('usd')} transaction fees. Your money will arrive in about 2 hours'),
          TransferCountry.usd => const Text(
              'Use the account details below to send money to you Borderpal account.'),
        },
        10.0.height,

        // Contents
        switch (widget.transferCountry) {
          TransferCountry.ngn => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.kGrey200),
              ),
              child: Column(
                children: [
                  const Text('Bank Account to Transfer to'),
                  16.0.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '78987890980',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          6.0.height,
                          const Text('Wema Bank PLC'),
                        ],
                      ),
                      const CardIcon(
                        image: AppImages.copy,
                        padding: 8,
                        bgColor: AppColors.kGrey100,
                      )
                    ],
                  )
                ],
              ),
            ),
          TransferCountry.usd => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.0.height,
                const AccountDetailsCard(
                  title: 'Account Name',
                  value: 'Peter Greene',
                ),
                24.0.height,
                const AccountDetailsCard(
                  title: 'Account Number/IBAN',
                  value: '357585735399',
                ),
                24.0.height,
                const AccountDetailsCard(
                  title: 'Sort Code',
                  value: '098-832-98',
                ),
              ],
            ),
        },
        32.0.height,

        // Transfer Information
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kGrey100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your money is processed by licensed banks'),
              10.0.height,
              const Text(
                  'Intermediary banks and payment processors may charge for this transfer'),
              10.0.height,
              const Text(
                  'Transfers might take up to 3 days for international payments')
            ],
          ),
        ),
        30.0.height,
      ],
    );
  }
}

class AccountDetailsCard extends StatelessWidget {
  final String? title, value;
  const AccountDetailsCard({
    super.key,
    this.title,
    this.value,
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
        const CardIcon(
          image: AppImages.copy,
          padding: 8,
          bgColor: AppColors.kGrey100,
        )
      ],
    );
  }
}
