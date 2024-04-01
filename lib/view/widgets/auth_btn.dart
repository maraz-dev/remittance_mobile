import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay_mobile/view/theme/app_colors.dart';

class AuthBtn extends StatelessWidget {
  final String image;
  const AuthBtn({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorderColor)),
        child: SvgPicture.asset(image),
      ),
    );
  }
}
