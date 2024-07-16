import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';

class InternationalBankForm extends StatefulWidget {
  const InternationalBankForm({
    super.key,
  });

  @override
  State<InternationalBankForm> createState() => _InternationalBankFormState();
}

class _InternationalBankFormState extends State<InternationalBankForm> {
  // Global Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _accountNo = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _sortCode = TextEditingController();
  final TextEditingController _swiftCode = TextEditingController();

  @override
  void dispose() {
    _accountNo.dispose();
    _bank.dispose();
    _sortCode.dispose();
    _swiftCode.dispose();
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
            hint: 'Select',
            inputType: TextInputType.text,
            validator: validateGeneric,
            readOnly: true,
            animate: false,
            suffixIcon: SvgPicture.asset(
              AppImages.arrowDown,
              fit: BoxFit.scaleDown,
            ),
          ),
          24.0.height,
          TextInput(
            animate: false,
            header: 'Sort Code',
            controller: _sortCode,
            hint: 'Sort Code',
            inputType: TextInputType.name,
            validator: validateGeneric,
          ),
          24.0.height,
          TextInput(
            animate: false,
            header: 'Swift Code',
            controller: _swiftCode,
            hint: 'Swift Code',
            inputType: TextInputType.name,
            validator: validateGeneric,
          ),
          60.0.height,
          MainButton(text: 'Add Bank Account', onPressed: () {})
        ],
      ),
    );
  }
}
