import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/debit_card_sheet.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/authorize_card_funding_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class PinAuthorizationSheet extends ConsumerStatefulWidget {
  static String path = 'pin-authorization-sheet';
  const PinAuthorizationSheet({
    super.key,
  });

  @override
  ConsumerState<PinAuthorizationSheet> createState() =>
      _PinAuthorizationSheetState();
}

class _PinAuthorizationSheetState extends ConsumerState<PinAuthorizationSheet> {
  // Key for FormState
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controller
  final TextEditingController _pin = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardLoading = ref.watch(authorizeCardPinProvider).isLoading;

    ref.listen(authorizeCardPinProvider, (_, next) {
      if (next is AsyncData) {}
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return AbsorbPointer(
      absorbing: cardLoading,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.0.height,
            Column(
              children: [
                // Heading
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SectionHeader(text: 'PIN Authentication'),
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
                48.0.height,

                // CardHolder Pin
                Pinput(
                  controller: _pin,
                  length: 4,
                  obscureText: true,
                  defaultPinTheme:
                      defaultPinInputTheme.copyWith(height: 70, width: 70),
                  focusedPinTheme:
                      focusedPinInputTheme.copyWith(height: 70, width: 70),
                  validator: validateGeneric,
                ),
                48.0.height,
              ],
            ),
            MainButton(
              isLoading: cardLoading,
              text: 'Next',
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(authorizeCardPinProvider.notifier)
                      .authorizeCardPinMethod(
                        PinAuthorizationReq(
                          cardNumber: cardFundingRes.value.cardNumber,
                          expiryMonth: cardFundingRes.value.expiryMonth,
                          expiryYear: cardFundingRes.value.expiryYear,
                          cvv: cardFundingRes.value.cvv,
                          email: SharedPrefManager.email,
                          authorization: PinModeAuthorization(
                            mode: 'pin',
                            pin: _pin.text,
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
    );
  }
}
