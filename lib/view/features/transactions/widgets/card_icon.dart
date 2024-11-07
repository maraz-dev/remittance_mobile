import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class CardIcon extends StatelessWidget {
  final String image;
  final double? padding;
  final Color? bgColor;
  final ColorFilter? iconColor;
  final double? size;
  const CardIcon({
    super.key,
    required this.image,
    this.padding,
    this.bgColor,
    this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor ?? AppColors.kSuccessColor50,
      ),
      child: SvgPicture.asset(
        image,
        width: size,
        height: size,
        colorFilter: iconColor,
      ),
    );
  }
}
