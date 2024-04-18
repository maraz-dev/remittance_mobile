import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountOptions extends StatelessWidget {
  final Function()? onPressed;
  final String text, image;

  const AccountOptions({
    super.key,
    this.onPressed,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: AppColors.kWhiteColor, shape: BoxShape.circle),
            child: SvgPicture.asset(image),
          ),
        ),
        6.0.height,
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kWhiteColor,
                fontWeight: FontWeight.bold,
              ),
        )
      ],
    );
  }
}
