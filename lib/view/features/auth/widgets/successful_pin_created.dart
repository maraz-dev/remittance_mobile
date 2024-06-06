import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/login_view.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class SuccessfulPinCreated extends StatelessWidget {
  const SuccessfulPinCreated({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.success),
        16.0.height,
        const BottomSheetTitle(
          title: 'Transaction PIN Created',
          subtitle:
              'Great job! You have successfully created your Transaction PIN',
        ),
        40.0.height,
        MainButton(
          text: 'Start Transacting',
          onPressed: () {
            context.pushReplacementNamed(LoginScreen.path);
          },
        ),
        12.0.height
      ],
    );
  }
}
