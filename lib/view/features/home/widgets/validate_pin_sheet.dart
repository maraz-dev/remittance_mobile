import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/view/features/auth/vm/create_account_vm/validate_pin_vm.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';

class ValidatePINSheet extends ConsumerStatefulWidget {
  const ValidatePINSheet({
    super.key,
  });

  @override
  ConsumerState<ValidatePINSheet> createState() => _ValidatePINSheet();
}

class _ValidatePINSheet extends ConsumerState<ValidatePINSheet> {
  // Key Variables
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Editing Controller for Fields
  final TextEditingController _pin = TextEditingController();
  final TextEditingController _confirmPin = TextEditingController();

  @override
  void dispose() {
    _pin.dispose();
    _confirmPin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyPINLoading = ref.watch(validatePINProvider).isLoading;

    // Set PIN SM
    ref.listen(validatePINProvider, (_, next) {
      if (next is AsyncData<String>) {
        context.pop(true);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return AbsorbPointer(
      absorbing: verifyPINLoading,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.security),
            16.0.height,
            const BottomSheetTitle(
              title: 'Transaction PIN',
              subtitle: 'Enter your transaction pin to complete your transaction.',
            ),
            24.0.height,
            Center(
              child: Pinput(
                controller: _pin,
                length: 4,
                obscureText: true,
                defaultPinTheme: defaultPinInputTheme.copyWith(height: 70, width: 70),
                focusedPinTheme: focusedPinInputTheme.copyWith(height: 70, width: 70),
                validator: validateGeneric,
              ),
            ),
            40.0.height,
            MainButton(
              isLoading: verifyPINLoading,
              text: 'Verify PIN',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(validatePINProvider.notifier).validatePINMethod(_pin.text);
                }
              },
            ),
            12.0.height
          ],
        ),
      ),
    );
  }
}
