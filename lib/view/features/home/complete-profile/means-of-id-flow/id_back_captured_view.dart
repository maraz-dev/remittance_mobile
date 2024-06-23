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
  });
  final VoidCallback pressed;

  @override
  State<IdBackCapturedView> createState() => _IdBackCapturedViewState();
}

class _IdBackCapturedViewState extends State<IdBackCapturedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScaffoldBody(
          body: SingleChildScrollView(
            child: Column(
              children: [
                20.0.height,
                Image.memory(
                  idBackImagePath.value.readAsBytesSync(),
                  width: 340,
                  height: 210,
                ),
                24.0.height,
                Text(
                  'Front ID Captured!',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kBlackColor),
                ),
                16.0.height,
                InkWell(
                  onTap: () {},
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
                  hyperlink: 'Proof of Address',
                  hyperlinkColor: AppColors.kGrey700,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              //isLoading: true,
              text: 'Continue',
              onPressed: () {
                kycData.addAll({'MeansOfIdDocBack': idBackImagePath.value});
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
