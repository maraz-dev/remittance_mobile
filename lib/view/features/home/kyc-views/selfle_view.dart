import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/bottomsheets/kyc_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SelfieView extends StatefulWidget {
  static String path = '/selfie-view';
  const SelfieView({super.key});

  @override
  State<SelfieView> createState() => _SelfieViewState();
}

class _SelfieViewState extends State<SelfieView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Selfie'),
      body: ScaffoldBody(
        body: Column(
          children: [
            16.0.height,
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 50,
                right: 50,
              ),
              child: Image.asset(AppImages.selfieImage),
            ),
            24.0.height,
            Text(
              'Selfie Captured!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.kGrey700),
            ),
            8.0.height,
            const RichTextWidget(
              text: 'Continue to ',
              hyperlink: 'Proof of Address',
              hyperlinkColor: AppColors.kGrey700,
            ),
            50.0.height,
            Text(
              'Retake Photo',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.kPrimaryColor),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Continue',
            onPressed: () {
              context.pop();
              kycPosition.value += 1;
              kycBottomSheet(
                context: context,
                current: kycPosition.value,
              );
            },
          )
              .animate()
              .fadeIn(begin: 0, delay: 1000.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
        ],
      ),
    );
  }
}
