import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfle_view.dart';
import 'package:remittance_mobile/view/features/home/widgets/capture_info_widget.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class IdBackCaptureView extends StatefulWidget {
  static String path = "id-back-capture-view";
  const IdBackCaptureView({super.key, required this.pressed});
  final VoidCallback pressed;

  @override
  State<IdBackCaptureView> createState() => _IdBackCaptureViewState();
}

class _IdBackCaptureViewState extends State<IdBackCaptureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              20.0.height,
              const CaptureInfoWidget(
                text: 'How to Capture Back of ID',
                buttonText: 'Capture Back of ID Photo',
              ),
              24.0.height,
              Text(
                'OR',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
              ),
              16.0.height,
              InkWell(
                onTap: () {
                  context.pushNamed(SelfieView.path);
                },
                child: Text(
                  'Upload From Gallery',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
