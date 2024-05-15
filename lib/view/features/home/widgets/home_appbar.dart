import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: const AssetImage(AppImages.tempProfileImage),
        ),
        8.0.width,
        RichText(
            text: TextSpan(
          text: 'Welcome ',
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(
                text: 'Ella', style: Theme.of(context).textTheme.displaySmall),
            TextSpan(
                text: '👋', style: Theme.of(context).textTheme.displaySmall),
          ],
        )),
        const Spacer(),
        SvgPicture.asset(AppImages.notification)
      ],
    );
  }
}
