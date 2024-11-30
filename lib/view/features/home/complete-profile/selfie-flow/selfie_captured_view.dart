// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/proof-of-address-flow/proof_of_address_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfie_capture_view.dart';
import 'package:remittance_mobile/view/features/home/vm/upload_kyc_file.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SelfieCapturedView extends ConsumerStatefulWidget {
  static String path = 'selfie-captured-view';
  const SelfieCapturedView({super.key, required this.pressed, required this.controller});

  final VoidCallback pressed;
  final PageController controller;

  @override
  ConsumerState<SelfieCapturedView> createState() => _SelfieCapturedViewState();
}

class _SelfieCapturedViewState extends ConsumerState<SelfieCapturedView> {
  @override
  Widget build(BuildContext context) {
    final kycUploading = ref.watch(uploadKycDocProvider).isLoading;

    ref.listen(uploadKycDocProvider, (_, next) {
      if (next is AsyncData<String>) {
        kycData.addAll({'SelfiePath': next.value});
        context.pushNamed(ProofOfAddressView.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return Scaffold(
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                50.0.height,
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    selfiePath.value.readAsBytesSync(),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                24.0.height,
                Text(
                  'Selfie Captured!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, color: AppColors.kGrey700),
                ),
                8.0.height,
                InkWell(
                  onTap: () async {
                    widget.controller.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Text(
                    'Retake Photo',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500, color: AppColors.kPrimaryColor),
                  ),
                ),
                30.0.height,
                const RichTextWidget(
                  text: 'Click Continue Below to ',
                  hyperlink: 'Proof of Address',
                  hyperlinkColor: AppColors.kGrey700,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            isLoading: kycUploading,
            text: 'Continue',
            onPressed: () async {
              ref
                  .read(uploadKycDocProvider.notifier)
                  .uploadKycDocMethod(selfiePath.value, 'PHOTO_DOC');
            },
          )
              .animate()
              .fadeIn(begin: 0, delay: 500.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
        ],
      ),
    );
  }
}
