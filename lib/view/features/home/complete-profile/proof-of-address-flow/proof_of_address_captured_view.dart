import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/kyc_submission_model.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/proof-of-address-flow/proof_of_address_upload_view.dart';
import 'package:remittance_mobile/view/features/home/vm/initiate_kyc_vm.dart';
import 'package:remittance_mobile/view/features/home/vm/upload_kyc_file.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/overlay_animation.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ProofOfAddressCapturedView extends ConsumerStatefulWidget {
  static String path = 'proof-of-address-captured-view';
  const ProofOfAddressCapturedView({
    super.key,
    required this.pressed,
    required this.controller,
  });

  final VoidCallback pressed;
  final PageController controller;

  @override
  ConsumerState<ProofOfAddressCapturedView> createState() => _ProofOfAddressCapturedViewState();
}

class _ProofOfAddressCapturedViewState extends ConsumerState<ProofOfAddressCapturedView> {
  String fileSize = '';
  Future<String> calculateFileSize(String filePath) async {
    try {
      final file = File(filePath);
      int size = await file.length();
      return size.formatBytes();
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<void> getFileSize() async {
    final size = await calculateFileSize(proofOfAddressDoc.value.path);
    setState(() {
      fileSize = size;
    });
  }

  @override
  void initState() {
    super.initState();
    getFileSize();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(initiateKycProvider).isLoading;
    final kycUploading = ref.watch(uploadKycFileProvider).isLoading;

    ref.listen(uploadKycFileProvider, (_, next) {
      if (next is AsyncData<String>) {
        kycData.addAll({'ProofOfAddressDocPath': next.value});
        ref.read(initiateKycProvider.notifier).initiateKycMethod();
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    ref.listen(initiateKycProvider, (_, next) {
      if (next is AsyncData<KycSubmission>) {
        SnackBarDialog.showSuccessFlushBarMessage('KYC Submitted Successfully!', context);

        context.goNamed(DashboardView.path);
      }
      if (next is AsyncError) {
        //Navigator.popUntil(context, ModalRoute.withName(CompleteProfileView.path));
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return AbsorbPointer(
      absorbing: kycUploading || loading,
      child: OverlayLoadingIndicator(
        isLoading: loading,
        text: 'Uploading KYC...',
        child: Scaffold(
            body: ScaffoldBody(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const CardIcon(
                          image: AppImages.documentUploadIcon,
                          padding: 8,
                          bgColor: AppColors.kGrey200,
                        ),
                        12.0.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 210,
                              child: Text(
                                proofOfAddressDoc.value.path.split('/').last,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kGrey700,
                                    ),
                              ),
                            ),
                            Text(fileSize),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            widget.controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          icon: const Icon(Icons.cancel),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavBarWidget(
              children: [
                MainButton(
                  isLoading: kycUploading || loading,
                  text: 'Complete Verification',
                  onPressed: () async {
                    ref
                        .read(uploadKycFileProvider.notifier)
                        .uploadKycFileMethod(proofOfAddressDoc.value, 'ADDRESS_PROOF_DOC');
                  },
                )
                    .animate()
                    .fadeIn(begin: 0, delay: 500.ms)
                    // .then(delay: 200.ms)
                    .slideY(begin: .1, end: 0),
              ],
            )),
      ),
    );
  }
}
