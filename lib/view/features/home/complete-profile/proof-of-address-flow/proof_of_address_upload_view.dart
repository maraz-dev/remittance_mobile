import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/widgets/capture_info_widget.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/file_and_image_picker.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

ValueNotifier<File> proofOfAddressDoc = ValueNotifier(File(''));

class ProofOfAddressUploadView extends StatefulWidget {
  static String path = "proof-of-address-upload-view";
  const ProofOfAddressUploadView({super.key, required this.pressed});

  final VoidCallback pressed;

  @override
  State<ProofOfAddressUploadView> createState() => _ProofOfAddressUploadViewState();
}

class _ProofOfAddressUploadViewState extends State<ProofOfAddressUploadView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBody(
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.0.height,
            CaptureInfoWidget(
              image: AppImages.documentUploadIcon,
              text: 'Upload Document',
              subtitle: 'Click the button below to add document to upload',
              buttonText: 'Choose Document',
              onPressed: () async {
                proofOfAddressDoc.value = await pickFileFromPlatform();
                widget.pressed();
              },
            ),
            16.0.height,
            InkWell(
              onTap: () async {
                proofOfAddressDoc.value = await pickImageFromGallery();
                widget.pressed();
              },
              child: Text(
                'Upload From Gallery Instead',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
