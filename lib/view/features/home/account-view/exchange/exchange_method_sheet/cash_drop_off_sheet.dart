import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_transaction_detail.dart';
import 'package:remittance_mobile/view/features/home/widgets/sheet_option_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class CashDropOffSheet extends StatefulWidget {
  const CashDropOffSheet({
    super.key,
  });

  @override
  State<CashDropOffSheet> createState() => _CashDropOffSheetState();
}

class _CashDropOffSheetState extends State<CashDropOffSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        5.0.height,

        // Heading
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeader(text: 'Cash Drop Off Locations'),
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
        const SheetOptionCard(
          text: 'Samsung Office',
          subtitle: 'Shop 1B, Ikeja City Mall',
        ),

        100.0.height,
        MainButton(
          text: 'Next',
          onPressed: () {
            context.pop();
            context.pushNamed(ExchangeTransactionDetailView.path);
          },
        )
      ],
    );
  }
}
