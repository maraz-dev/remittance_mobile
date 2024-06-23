import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/widgets/capture_info_widget.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/file_and_image_picker.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

ValueNotifier<File> idBackImagePath = ValueNotifier(File(''));

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
              CaptureInfoWidget(
                text: 'How to Capture Back of ID',
                buttonText: 'Capture Back of ID Photo',
                onPressed: () async {
                  idBackImagePath.value = await pickImageFromCamera();
                  widget.pressed();
                },
              ),
              24.0.height,
              Text(
                'OR',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
              ),
              16.0.height,
              InkWell(
                onTap: () async {
                  idBackImagePath.value = await pickImageFromGallery();
                  widget.pressed();
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
