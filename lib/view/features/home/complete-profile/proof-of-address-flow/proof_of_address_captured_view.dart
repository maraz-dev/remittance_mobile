import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/kyc_submission_model.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/proof-of-address-flow/proof_of_address_upload_view.dart';
import 'package:remittance_mobile/view/features/home/vm/initiate_kyc_vm.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
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
  ConsumerState<ProofOfAddressCapturedView> createState() =>
      _ProofOfAddressCapturedViewState();
}

class _ProofOfAddressCapturedViewState
    extends ConsumerState<ProofOfAddressCapturedView> {
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
    final loading = ref.watch(initiateKycProvider);
    ref.listen(initiateKycProvider, (_, next) {
      if (next is AsyncData<KycSubmission>) {
        context.pushNamed(DashboardView.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return loading.isLoading
        ? ScaffoldBody(
            body: Center(
              child: Column(
                children: [
                  50.0.height,
                  const CardIcon(
                    image: AppImages.uploadingIcon,
                    size: 56,
                    padding: 32,
                    bgColor: AppColors.kGrey100,
                  ),
                  24.0.height,
                  Text(
                    'Uploading...',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.kGrey700,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
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
                  //isLoading: true,
                  text: 'Complete Verification',
                  onPressed: () async {
                    kycData.addAll({
                      'ProofOfAddressDoc': await MultipartFile.fromFile(
                        proofOfAddressDoc.value.path,
                        filename: proofOfAddressDoc.value.path.split('/').last,
                      )
                    });
                    ref.read(initiateKycProvider.notifier).initiateKycMethod();
                  },
                )
                    .animate()
                    .fadeIn(begin: 0, delay: 500.ms)
                    // .then(delay: 200.ms)
                    .slideY(begin: .1, end: 0),
              ],
            ));
  }
}
