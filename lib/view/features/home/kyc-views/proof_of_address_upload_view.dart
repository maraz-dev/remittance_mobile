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

class ProofOfAddressUploadView extends StatefulWidget {
  static String path = "proof-of-address-upload-view";
  const ProofOfAddressUploadView({super.key});

  @override
  State<ProofOfAddressUploadView> createState() =>
      _ProofOfAddressUploadViewState();
}

class _ProofOfAddressUploadViewState extends State<ProofOfAddressUploadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Proof Of Address'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              20.0.height,
              const CaptureInfoWidget(
                text: 'Upload Document',
                subtitle: 'Click the button below to add document to upload',
                buttonText: 'Choose Document',
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
