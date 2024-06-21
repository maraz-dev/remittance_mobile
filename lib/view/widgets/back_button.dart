import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class BackArrowButton extends StatelessWidget {
  final Function()? backOnPressed;
  const BackArrowButton({
    super.key,
    this.backOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      radius: 0,
      onTap: backOnPressed ?? () => context.pop(),
      child: SvgPicture.asset(
        AppImages.backArrow,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
