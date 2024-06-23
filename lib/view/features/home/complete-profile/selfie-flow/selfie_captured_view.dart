import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/prood-of-address-flow/proof_of_address_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfie_capture_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SelfieCapturedView extends StatefulWidget {
  static String path = 'selfie-captured-view';
  const SelfieCapturedView({super.key, required this.pressed});

  final VoidCallback pressed;

  @override
  State<SelfieCapturedView> createState() => _SelfieCapturedViewState();
}

class _SelfieCapturedViewState extends State<SelfieCapturedView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            16.0.height,
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 50,
                right: 50,
              ),
              child: Image.memory(
                selfiePath.value.readAsBytesSync(),
                width: 200,
                height: 200,
              ),
            ),
            24.0.height,
            Text(
              'Selfie Captured!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.kGrey700),
            ),
            8.0.height,
            Text(
              'Retake Photo',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.kPrimaryColor),
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
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Continue',
            onPressed: () {
              context.pushNamed(ProofOfAddressView.path);
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
