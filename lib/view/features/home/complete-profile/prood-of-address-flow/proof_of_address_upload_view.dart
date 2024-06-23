import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/widgets/capture_info_widget.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ProofOfAddressUploadView extends StatefulWidget {
  static String path = "proof-of-address-upload-view";
  const ProofOfAddressUploadView({super.key, required this.pressed});

  final VoidCallback pressed;

  @override
  State<ProofOfAddressUploadView> createState() =>
      _ProofOfAddressUploadViewState();
}

class _ProofOfAddressUploadViewState extends State<ProofOfAddressUploadView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBody(
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
    );
  }
}
