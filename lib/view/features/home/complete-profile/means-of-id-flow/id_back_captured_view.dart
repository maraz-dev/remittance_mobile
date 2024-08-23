// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/id_back_capture_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfle_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class IdBackCapturedView extends StatefulWidget {
  static String path = "id-back-captured-view";
  const IdBackCapturedView({
    super.key,
    required this.pressed,
    required this.controller,
  });
  final VoidCallback pressed;
  final PageController controller;

  @override
  State<IdBackCapturedView> createState() => _IdBackCapturedViewState();
}

class _IdBackCapturedViewState extends State<IdBackCapturedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScaffoldBody(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  20.0.height,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.kPrimaryColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        idBackImagePath.value.readAsBytesSync(),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  24.0.height,
                  Text(
                    'Back of ID Captured!',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.kBlackColor),
                  ),
                  16.0.height,
                  InkWell(
                    onTap: () {
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    splashColor: Colors.transparent,
                    child: Text(
                      'Remove Photo',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  40.0.height,
                  const RichTextWidget(
                    text: 'Click Continue Below to ',
                    hyperlink: 'Selfie',
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
              //isLoading: true,
              text: 'Continue',
              onPressed: () async {
                kycData.addAll({
                  'MeansOfIdDocBack': await MultipartFile.fromFile(
                    idBackImagePath.value.path,
                    filename: idBackImagePath.value.path.split('/').last,
                  )
                });
                context.pushNamed(SelfieView.path);
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
