import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/card_otp_validation_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/debit_card_sheet.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/authorize_card_funding_vm.dart';
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

class AvsAuthorizationSheet extends ConsumerStatefulWidget {
  static String path = 'avs-authorization-sheet';
  const AvsAuthorizationSheet({
    super.key,
  });

  @override
  ConsumerState<AvsAuthorizationSheet> createState() =>
      _AvsAuthorizationSheetState();
}

class _AvsAuthorizationSheetState extends ConsumerState<AvsAuthorizationSheet> {
  // Key for FormState
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controller
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _city.dispose();
    _state.dispose();
    _address.dispose();
    _country.dispose();
    _zipCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardLoading = ref.watch(authorizeCardAvsProvider).isLoading;

    ref.listen(authorizeCardAvsProvider, (_, next) {
      if (next is AsyncData) {
        AppBottomSheet.showBottomSheet(
          context,
          widget: CardOTPValidationSheet(
            description: next.value ?? "",
          ),
        );
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SectionHeader(text: 'Address Verfication'),
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
                      header: 'Address',
                      controller: _address,
                      hint: 'Enter your Address',
                      inputType: TextInputType.name,
                      validator: validateGeneric,
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
                            header: 'City',
                            controller: _city,
                            hint: 'Enter City',
                            inputType: TextInputType.text,
                            validator: validateGeneric,
                          ),
                        ),
                        16.0.width,
                        // CardHolder Name
                        Expanded(
                          flex: 10,
                          child: input.TextInput(
                            animate: false,
                            header: 'State',
                            controller: _state,
                            hint: 'Enter State',
                            inputType: TextInputType.text,
                            validator: validateGeneric,
                          ),
                        ),
                      ],
                    ),
                    24.0.height,

                    //
                    Row(
                      children: [
                        // CardHolder Name
                        Expanded(
                          flex: 11,
                          child: input.TextInput(
                            animate: false,
                            header: 'Country',
                            controller: _country,
                            hint: 'Enter Country',
                            inputType: TextInputType.text,
                            validator: validateGeneric,
                          ),
                        ),
                        16.0.width,
                        // CardHolder Name
                        Expanded(
                          flex: 10,
                          child: input.TextInput(
                            animate: false,
                            header: 'ZIP Code',
                            controller: _zipCode,
                            hint: 'Enter Zip Code',
                            inputType: TextInputType.text,
                            validator: validateGeneric,
                          ),
                        ),
                      ],
                    ),

                    65.0.height,
                  ],
                ),
                MainButton(
                  isLoading: cardLoading,
                  text: 'Next',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authorizeCardAvsProvider.notifier)
                          .authorizeCardAvsMethod(
                            AvsAuthorizationReq(
                              cardNumber: cardFundingRes.value.cardNumber,
                              expiryMonth: cardFundingRes.value.expiryMonth,
                              expiryYear: cardFundingRes.value.expiryYear,
                              cvv: cardFundingRes.value.cvv,
                              email: SharedPrefManager.email,
                              authorization: AvsModeAuthorization(
                                mode: 'avs_noauth',
                                city: _city.text.trim(),
                                address: _address.text.trim(),
                                state: _state.text.trim(),
                                country: _country.text.trim(),
                                zipcode: _zipCode.text.trim(),
                              ),
                            ),
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
