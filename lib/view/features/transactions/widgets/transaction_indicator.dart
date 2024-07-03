import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:timelines/timelines.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class TransactionIndicator extends StatelessWidget {
  final double? padding;
  final String? image;
  final Color? backColor, borderColor;
  const TransactionIndicator({
    super.key,
    this.padding,
    this.image,
    this.backColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return DotIndicator(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(padding ?? 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backColor ?? Colors.transparent,
          border: Border.all(color: borderColor ?? AppColors.kGrey200),
        ),
        child: SvgPicture.asset(
          image ?? AppImages.check,
          colorFilter: borderColor?.colorFilterMode(),
        ),
      ),
    );
  }
}
