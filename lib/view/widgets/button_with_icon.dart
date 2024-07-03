import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.kGrey300,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppImages.accountsIcon,
            colorFilter: AppColors.kGrey700.colorFilterMode(),
          ),
          8.0.width,
          Text(
            'Share Receipt',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kGrey700,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }
}
