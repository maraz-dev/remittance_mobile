import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class TransactionPinSheet extends StatelessWidget {
  final Function()? onPressed;
  const TransactionPinSheet({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: () => context.pop(),
            child: SvgPicture.asset(AppImages.boxBackArrow)),
        16.0.height,
        const BottomSheetTitle(
          title: 'Transaction PIN',
          subtitle: 'Enter your Transaction PIN',
        ),
        24.0.height,
        Center(
          child: Pinput(
            length: 4,
            obscureText: true,
            defaultPinTheme:
                defaultPinInputTheme.copyWith(height: 70.h, width: 70.w),
            focusedPinTheme:
                focusedPinInputTheme.copyWith(height: 70.h, width: 70.w),
          ),
        ),
        40.0.height,
        MainButton(
          text: 'Add Money',
          onPressed: onPressed,
        ),
        12.0.height
      ],
    );
  }
}
