import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/widgets/capture_info_widget.dart';
import 'package:remittance_mobile/view/utils/bottomsheets/kyc_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class MeansOfIdCaptureView extends StatefulWidget {
  static String path = "means-of-id-capture-view";
  const MeansOfIdCaptureView({super.key});

  @override
  State<MeansOfIdCaptureView> createState() => _MeansOfIdCaptureViewState();
}

class _MeansOfIdCaptureViewState extends State<MeansOfIdCaptureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Means of ID'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              20.0.height,
              const CaptureInfoWidget(),
              40.0.height,
              const CaptureInfoWidget(
                text: 'How to Capture Back ID',
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
