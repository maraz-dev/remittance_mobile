import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/login_view.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountCreateSuccess extends StatelessWidget {
  const AccountCreateSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.accountCreated),
        16.0.height,
        const BottomSheetTitle(
          title: 'Account Created',
          subtitle: 'Welcome to $APP_NAME. Let’s shake the world!',
        ),
        40.0.height,
        MainButton(
          text: 'Go To Login',
          onPressed: () {
            context.pop();
            context.goNamed(LoginScreen.path);
          },
        ),
        12.0.height
      ],
    );
  }
}
