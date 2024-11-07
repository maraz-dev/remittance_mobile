import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/box_decoration.dart';

class ContactCard extends StatelessWidget {
  final String? text, subtitle, image;
  final Function()? onPressed;
  const ContactCard({
    super.key,
    this.text,
    this.subtitle,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: whiteCardDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text ?? ''),
                Text(
                  subtitle ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kBlueColor500),
                ),
              ],
            ),
            SvgPicture.asset(image ?? AppImages.whatsAppButton)
          ],
        ),
      ),
    );
  }
}
