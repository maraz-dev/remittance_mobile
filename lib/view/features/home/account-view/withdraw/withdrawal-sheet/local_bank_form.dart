import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/view/features/services/transfers/bank_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';

class LocalBankForm extends ConsumerStatefulWidget {
  const LocalBankForm({
    super.key,
  });

  @override
  ConsumerState<LocalBankForm> createState() => _LocalBankFormState();
}

class _LocalBankFormState extends ConsumerState<LocalBankForm> {
  // Global Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _accountNo = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _bank = TextEditingController();

  @override
  void dispose() {
    _accountNo.dispose();
    _recipientName.dispose();
    _bank.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInput(
            animate: false,
            header: 'Account Number/IBAN',
            controller: _accountNo,
            hint: 'Enter your Account Number/IBAN',
            inputType: TextInputType.name,
            validator: validateGeneric,
          ),
          24.0.height,
          TextInput(
            header: 'Bank',
            controller: _bank,
            hint: 'Select Bank',
            inputType: TextInputType.text,
            validator: validateGeneric,
            readOnly: true,
            animate: false,
            suffixIcon: SvgPicture.asset(
              AppImages.arrowDown,
              fit: BoxFit.scaleDown,
            ),
            onPressed: () async {
              BanksModel? result = await AppBottomSheet.showBottomSheet(
                context,
                widget: BanksSheet(
                  country: "NG",
                ),
              );
            },
          ),
          24.0.height,
          TextInput(
            animate: false,
            header: 'Recipient Name',
            controller: _recipientName,
            hint: 'Recipient Name',
            inputType: TextInputType.name,
            validator: validateGeneric,
          ),
          24.0.height,
          MainButton(
              text: 'Add Bank Account',
              onPressed: () {
                context.pushNamed(SendMoneyDetailsView.path);
              })
        ],
      ),
    );
  }
}
