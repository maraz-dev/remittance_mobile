import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/data/models/requests/verify_transx_req.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/validate_card_funding_vm.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/verify_transx_funding_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class CardOTPValidationSheet extends ConsumerStatefulWidget {
  const CardOTPValidationSheet({
    super.key,
    required this.description,
  });

  final String description;

  @override
  ConsumerState<CardOTPValidationSheet> createState() =>
      _CardOTPValidationState();
}

class _CardOTPValidationState extends ConsumerState<CardOTPValidationSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _otp = TextEditingController();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validateLoading = ref.watch(validateFundingProvider);
    final verifyLoading = ref.watch(verifyFundingTransxProvider);

    ref.listen(validateFundingProvider, (_, next) {
      if (next is AsyncData) {
        // SnackBarDialog.showSuccessFlushBarMessage(
        //     'Funding Successful', context);
        // context.goNamed(DashboardView.path);
        ref
            .read(verifyFundingTransxProvider.notifier)
            .verifyFundingTransxMethod(VerifyFundingTransxReq(
              flwTransactionId: next.value?.flwTransactionId,
              requestId: next.value?.requestId,
            ));
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    ref.listen(verifyFundingTransxProvider, (_, next) {
      if (next is AsyncData) {
        SnackBarDialog.showSuccessFlushBarMessage(
            'Funding Successful', context);
        context.goNamed(DashboardView.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return AbsorbPointer(
      absorbing: validateLoading.isLoading || verifyLoading.isLoading,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeader(text: 'Enter OTP'),
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
            Text(widget.description),
            32.0.height,
            Center(
              child: Pinput(
                controller: _otp,
                length: 5,
                obscureText: false,
                defaultPinTheme:
                    defaultPinInputTheme.copyWith(height: 55, width: 55),
                focusedPinTheme:
                    focusedPinInputTheme.copyWith(height: 55, width: 55),
                validator: validateGeneric,
              ),
            ),
            48.0.height,
            MainButton(
              isLoading: validateLoading.isLoading || verifyLoading.isLoading,
              text: 'Next',
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(validateFundingProvider.notifier)
                      .validateFundingMethod(_otp.text);
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
