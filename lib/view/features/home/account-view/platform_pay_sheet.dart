import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class PlatformPaySheet extends StatefulWidget {
  const PlatformPaySheet({
    super.key,
  });

  @override
  State<PlatformPaySheet> createState() => _PlatformPaySheetState();
}

class _PlatformPaySheetState extends State<PlatformPaySheet> {
  // Amount TextEditing Controller
  final TextEditingController _amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amount.text = '500';
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

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
            const SectionHeader(text: 'Apple Pay'),
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
        const Text(
          'Use the account details below to send money to you Borderpal account.',
        ),
        10.0.height,

        // Contents
        AmountInput(
          controller: _amount,
          readOnly: true,
          animate: false,
        ),

        100.0.height,
        MainButton(
          text: 'Pay',
          onPressed: () {},
        ),
      ],
    );
  }
}
