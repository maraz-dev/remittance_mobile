import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remittance_mobile/view/features/home/widgets/capture_info_widget.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class IdFrontCaptureView extends StatefulWidget {
  static String path = "id-front-capture-view";
  const IdFrontCaptureView({super.key, required this.pressed});
  final VoidCallback pressed;

  @override
  State<IdFrontCaptureView> createState() => _IdFrontCaptureViewState();
}

class _IdFrontCaptureViewState extends State<IdFrontCaptureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              20.0.height,
              const CaptureInfoWidget(),
              24.0.height,
              Text(
                'OR',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
              ),
              16.0.height,
              InkWell(
                onTap: () {},
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
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Continue',
            onPressed: () {
              widget.pressed;
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