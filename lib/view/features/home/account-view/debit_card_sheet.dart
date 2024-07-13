import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart' as input;
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class DebitCardSheet extends StatefulWidget {
  const DebitCardSheet({
    super.key,
  });

  @override
  State<DebitCardSheet> createState() => _DebitCardSheetState();
}

class _DebitCardSheetState extends State<DebitCardSheet> {
  // Key for FormState
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controller
  final TextEditingController _cardholderName = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _expiryDate = TextEditingController();
  final TextEditingController _cvv = TextEditingController();

  final ValueNotifier<String> _cardTypeNotifier =
      ValueNotifier<String>('Unknown');

  @override
  void initState() {
    super.initState();
    _cardNumber.addListener(() {
      _cardTypeNotifier.value = identifyCardType(_cardNumber.text);
    });
  }

  @override
  void dispose() {
    _cardNumber.removeListener(() {
      _cardTypeNotifier.value = identifyCardType(_cardNumber.text);
    });
    _cardholderName.dispose();
    _cardNumber.dispose();
    _expiryDate.dispose();
    _cvv.dispose();
    super.dispose();
  }

  // Method to Identify the card Type by the first Number
  String identifyCardType(String cardNumber) {
    if (cardNumber.isEmpty) {
      return 'Unknown';
    }

    // Verve card prefixes
    List<String> vervePrefixes = ['506', '507', '650', '651', '652'];

    // MasterCard Range
    bool isMasterCard = (cardNumber.startsWith(RegExp(r'^5[1-5]'))) ||
        (cardNumber
            .startsWith(RegExp(r'^2(?:22[1-9]|2[3-9]|[3-6][0-9]|7[01])'))) ||
        (cardNumber.startsWith('2720'));

    // Card Type Conditions
    if (cardNumber.startsWith('4')) {
      return 'Visa';
    } else if (isMasterCard) {
      return 'MasterCard';
    } else if (vervePrefixes.any((prefix) => cardNumber.startsWith(prefix))) {
      return 'Verve';
    } else if (cardNumber.startsWith('3')) {
      return 'American Express';
    } else {
      return 'Unknown';
    }
  }

  // Method to Change the Prefix Icon
  Widget _getPrefixIcon(String cardType) {
    return switch (cardType) {
      'Visa' => SvgPicture.asset(
          AppImages.mastercard,
          fit: BoxFit.scaleDown,
        ),
      'MasterCard' => SvgPicture.asset(
          AppImages.mastercard,
          fit: BoxFit.scaleDown,
        ),
      'Verve' => SvgPicture.asset(
          AppImages.mastercard,
          fit: BoxFit.scaleDown,
        ),
      'American Express' => SvgPicture.asset(
          AppImages.mastercard,
          fit: BoxFit.scaleDown,
        ),
      _ => const SizedBox.shrink()
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          5.0.height,

          // Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(text: 'Debit Card'),
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

          // CardHolder Name
          input.TextInput(
            animate: false,
            header: 'Name on Card',
            controller: _cardholderName,
            hint: 'Card Holder Name',
            inputType: TextInputType.name,
            validator: validateGeneric,
          ),
          24.0.height,

          // Card Number
          ValueListenableBuilder(
            valueListenable: _cardTypeNotifier,
            builder: (context, cardType, child) {
              return input.TextInput(
                animate: false,
                header: 'Card Number',
                controller: _cardNumber,
                prefixIcon: _getPrefixIcon(cardType),
                hint: '0000 0000 0000 0000',
                inputType: TextInputType.number,
                validator: validateGeneric,
              );
            },
          ),
          24.0.height,

          // Expiry Date and CVV
          Row(
            children: [
              // CardHolder Name
              Expanded(
                flex: 11,
                child: input.TextInput(
                  animate: false,
                  header: 'Expiry Date',
                  controller: _expiryDate,
                  hint: 'MM/YY',
                  inputType: TextInputType.number,
                  validator: validateGeneric,
                ),
              ),
              16.0.width,
              // CardHolder Name
              Expanded(
                flex: 10,
                child: input.TextInput(
                  animate: false,
                  header: 'CVV',
                  controller: _cvv,
                  hint: '***',
                  inputType: TextInputType.number,
                  validator: validateGeneric,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                ),
              ),
            ],
          ),
          24.0.height,
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
                side: const BorderSide(
                  width: 1,
                  color: AppColors.kGrey300,
                ),
              ),
              const Text('Save Card Details'),
            ],
          ),
          100.0.height,
          MainButton(text: 'Next', onPressed: () {})
        ],
      ),
    );
  }
}
