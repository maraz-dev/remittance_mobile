import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class CaptureInfoWidget extends StatelessWidget {
  final String? image, text, subtitle, buttonText;
  final Function()? onPressed;

  const CaptureInfoWidget({
    super.key,
    this.image,
    this.text,
    this.subtitle,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardIcon(
          image: image ?? AppImages.uploadIdIcon,
          padding: 32,
          bgColor: AppColors.kGrey100,
        ),
        16.0.height,
        Text(
          text ?? 'How to Capture Front ID',
          style:
              Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
        5.0.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            subtitle ??
                'Place your ID on a flat surface and Avoid taking blurry photos',
            textAlign: TextAlign.center,
          ),
        ),
        24.0.height,
        MainButton(
          text: buttonText ?? 'Capture ID Photo',
          onPressed: onPressed,
        ),
      ],
    );
  }
}
