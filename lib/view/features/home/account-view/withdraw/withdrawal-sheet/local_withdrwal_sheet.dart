import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class AddBankAccountSheet extends StatefulWidget {
  const AddBankAccountSheet({
    super.key,
  });

  @override
  State<AddBankAccountSheet> createState() => _AddBankAccountSheetState();
}

class _AddBankAccountSheetState extends State<AddBankAccountSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.0.height,

        // Heading
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeader(text: 'Add Withdrawal Bank Account'),
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

        // Tab Controller
        24.0.height,

        // Form
        // TextInput(
        //   animate: false,
        //   header: 'Name on Card',
        //   controller: _cardholderName,
        //   hint: 'Card Holder Name',
        //   inputType: TextInputType.name,
        //   validator: validateGeneric,
        // ),
        24.0.height,
      ],
    );
  }
}
