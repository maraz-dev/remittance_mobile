import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/data/models/responses/user_response.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class HomeAppBarWidget extends StatelessWidget {
  final UserResponse response;
  const HomeAppBarWidget({
    super.key,
    required this.response,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppImages.selfieImageTwo),
          ),
          8.0.width,
          RichText(
              text: TextSpan(
            text: 'Welcome ',
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(
                  text: response.firstName?.split(' ').first ?? '',
                  style: Theme.of(context).textTheme.displaySmall),
              TextSpan(
                  text: '👋', style: Theme.of(context).textTheme.displaySmall),
            ],
          )),
          const Spacer(),
          SvgPicture.asset(AppImages.notification)
        ],
      ),
    );
  }
}
