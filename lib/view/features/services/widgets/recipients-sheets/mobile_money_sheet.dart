import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class MobileMoneySheet extends ConsumerStatefulWidget {
  const MobileMoneySheet({
    super.key,
  });

  @override
  ConsumerState<MobileMoneySheet> createState() => _MobileMoneySheetState();
}

class _MobileMoneySheetState extends ConsumerState<MobileMoneySheet> {
  // Global Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _accountName = TextEditingController();
  final TextEditingController _serviceProvider = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

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
            const SectionHeader(text: 'Mobile Money'),
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
        24.0.height,
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInput(
                header: 'Service Provider',
                controller: _serviceProvider,
                hint: 'Select',
                inputType: TextInputType.text,
                validator: validateGeneric,
                readOnly: true,
                animate: false,
                suffixIcon: SvgPicture.asset(
                  AppImages.arrowDown,
                  fit: BoxFit.scaleDown,
                ),
                onPressed: () async {},
              ),
              24.0.height,
              TextInput(
                animate: false,
                header: 'Phone Number',
                controller: _phoneNo,
                hint: '2348012345678',
                inputType: TextInputType.number,
                validator: validateGeneric,
              ),
              24.0.height,
              TextInput(
                animate: false,
                header: 'Account Name',
                controller: _accountName,
                hint: 'Recipient',
                inputType: TextInputType.name,
                validator: validateGeneric,
              ),
              24.0.height,
              MainButton(text: 'Continue', onPressed: () {})
            ],
          ),
        ),

        24.0.height,
      ],
    );
  }
}
