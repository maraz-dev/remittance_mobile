import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/add_money_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/avs_authorization_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/pin_authorization_sheet.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/fund_with_card_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart' as input;
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

ValueNotifier<InitiateCardFundingReq> cardFundingRes =
    ValueNotifier(InitiateCardFundingReq());

class DebitCardSheet extends ConsumerStatefulWidget {
  static String path = 'debit-card-sheet';
  const DebitCardSheet({
    super.key,
  });

  @override
  ConsumerState<DebitCardSheet> createState() => _DebitCardSheetState();
}

class _DebitCardSheetState extends ConsumerState<DebitCardSheet> {
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
          AppImages.visa,
          fit: BoxFit.scaleDown,
        ),
      'MasterCard' => SvgPicture.asset(
          AppImages.mastercard,
          fit: BoxFit.scaleDown,
        ),
      'Verve' => SvgPicture.asset(
          AppImages.verve,
          fit: BoxFit.scaleDown,
        ),
      'American Express' => SvgPicture.asset(
          AppImages.amex,
          fit: BoxFit.scaleDown,
        ),
      _ => const SizedBox.shrink()
    };
  }

  @override
  Widget build(BuildContext context) {
    final cardLoading = ref.watch(fundWithCardProvider).isLoading;

    ref.listen(fundWithCardProvider, (_, next) {
      if (next is AsyncData) {
        if (next.value?.mode == "pin") {
          AppBottomSheet.showBottomSheet(
            context,
            widget: const PinAuthorizationSheet(),
          );
        } else if (next.value?.mode == "avs_noauth") {
          context.pushNamed(AvsAuthorizationSheet.path);
        } else if (next.value?.mode == "redirect") {}
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return AbsorbPointer(
      absorbing: cardLoading,
      child: Scaffold(
        body: ScaffoldBody(
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                20.0.height,
                Expanded(
                  child: Column(
                    children: [
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
                      24.0.height,

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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                              onChanged: (value) {
                                if (value.length == 2 &&
                                    !_expiryDate.text.endsWith('/')) {
                                  _expiryDate.value = TextEditingValue(
                                    text: '$value/',
                                    selection: const TextSelection.collapsed(
                                        offset: 3),
                                  );
                                }
                              },
                              inputType: TextInputType.number,
                              validator: validateGeneric,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5)
                              ],
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3)
                              ],
                            ),
                          ),
                        ],
                      ),
                      // 24.0.height,
                      Visibility(
                        visible: false,
                        child: Row(
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
                      ),
                      65.0.height,
                    ],
                  ),
                ),
                MainButton(
                  isLoading: cardLoading,
                  text: 'Next',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      List<String> expiryDateSeparated =
                          _expiryDate.text.split('/');
                      ref
                          .read(fundWithCardProvider.notifier)
                          .fundWithCardMethod(
                            InitiateCardFundingReq(
                              cardNumber: _cardNumber.text.trim(),
                              cvv: _cvv.text,
                              amount: double.parse(
                                  addMoneyAmount.value.replaceAll(',', '')),
                              expiryMonth: expiryDateSeparated[0],
                              expiryYear: expiryDateSeparated[1],
                              currency: "NGN",
                              charge: 0,
                              redirectUrl: "",
                            ),
                          );

                      // Keep the Value for the PIN and AVS Authentication
                      cardFundingRes.value = InitiateCardFundingReq(
                        cardNumber: _cardNumber.text.trim(),
                        cvv: _cvv.text,
                        amount: double.parse(
                            addMoneyAmount.value.replaceAll(',', '')),
                        expiryMonth: expiryDateSeparated[0],
                        expiryYear: expiryDateSeparated[1],
                        currency: "NGN",
                        charge: 0,
                        redirectUrl: "",
                      );
                    }
                  },
                ),
                10.0.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
