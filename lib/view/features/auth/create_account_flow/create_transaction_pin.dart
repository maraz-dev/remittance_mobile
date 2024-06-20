import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/requests/set_pin_req.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_form_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/create_account_vm/set_pin_vm.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/auth/widgets/successful_pin_created.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';

class CreateTransactionPINSheet extends ConsumerStatefulWidget {
  final bool fromHomeView;
  const CreateTransactionPINSheet({
    super.key,
    this.fromHomeView = false,
  });

  @override
  ConsumerState<CreateTransactionPINSheet> createState() =>
      _CreateTransactionPINSheetState();
}

class _CreateTransactionPINSheetState
    extends ConsumerState<CreateTransactionPINSheet> {
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
    final loading = ref.watch(setPINProvider);

    // Set PIN SM
    ref.listen<AsyncValue<String>>(setPINProvider, (previous, next) {
      next.when(
        data: (value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (widget.fromHomeView) {
              context.pop();
              SnackBarDialog.showSuccessFlushBarMessage(
                'PIN Created Successfully',
                context,
              );
            } else {
              context.pop();
              AppBottomSheet.showBottomSheet(
                context,
                enableDrag: false,
                isDismissible: false,
                widget: const SuccessfulPinCreated(),
              );
            }
          });
        },
        loading: () {},
        error: (error, stack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SnackBarDialog.showErrorFlushBarMessage(error.toString(), context);
          });
        },
      );
    });

    return StatefulBuilder(builder: (context, setState) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.security),
            16.0.height,
            const BottomSheetTitle(
              title: 'Create Transaction PIN',
              subtitle: 'Enter your desired Transaction PIN',
            ),
            24.0.height,
            Center(
              child: Pinput(
                controller: _pin,
                length: 4,
                obscureText: true,
                defaultPinTheme:
                    defaultPinInputTheme.copyWith(height: 70, width: 70),
                focusedPinTheme:
                    focusedPinInputTheme.copyWith(height: 70, width: 70),
                validator: validateGeneric,
              ),
            ),
            16.0.height,
            Text(
              'Confirm Transaction PIN',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
            ),
            16.0.height,
            Center(
              child: Pinput(
                controller: _confirmPin,
                length: 4,
                obscureText: true,
                defaultPinTheme:
                    defaultPinInputTheme.copyWith(height: 70, width: 70),
                focusedPinTheme:
                    focusedPinInputTheme.copyWith(height: 70, width: 70),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field cannot be empty';
                  } else if (value != _pin.text) {
                    return "PIN doesn't match";
                  }
                  return null;
                },
              ),
            ),
            40.0.height,
            MainButton(
              isLoading: loading.isLoading,
              text: 'Create PIN',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(setPINProvider.notifier).setPINMethod(
                        SetPinReq(
                          emailAddress: widget.fromHomeView
                              ? SharedPrefManager.email
                              : successfulCreatedEmail.value,
                          pin: _pin.text,
                          confirmPin: _confirmPin.text,
                        ),
                      );
                }
              },
            ),
            12.0.height
          ],
        ),
      );
    });
  }
}
