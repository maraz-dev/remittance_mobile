import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/widgets/capture_info_widget.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/file_and_image_picker.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

ValueNotifier<File> selfiePath = ValueNotifier(File(''));

class SelfieCaptureView extends StatefulWidget {
  static String path = "selfie-capture-view";
  const SelfieCaptureView({super.key, required this.pressed});
  final VoidCallback pressed;

  @override
  State<SelfieCaptureView> createState() => _SelfieCaptureViewState();
}

class _SelfieCaptureViewState extends State<SelfieCaptureView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBody(
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.0.height,
            CaptureInfoWidget(
              image: AppImages.selfieIcon,
              text: 'Take a Selfie',
              buttonText: 'Capture Selfie',
              onPressed: () async {
                selfiePath.value = await pickImageFromCamera();
                widget.pressed();
              },
            ),
            24.0.height,
          ],
        ),
      ),
    );
  }
}
