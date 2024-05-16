import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class ProfileCard extends StatelessWidget {
  final String? image;
  final String? text;
  final Color? color;
  final Widget? trailing;
  final Function()? onPressed;
  const ProfileCard({
    super.key,
    this.image,
    this.text,
    this.color,
    this.trailing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              image ?? '',
              colorFilter: ColorFilter.mode(
                color ?? AppColors.kGrey700,
                BlendMode.srcIn,
              ),
            ),
            12.0.width,
            Text(
              text ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: color ?? AppColors.kGrey700,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            trailing ?? Container()
          ],
        ),
      ),
    );
  }
}
