import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AddBeneficiaryWidget extends StatelessWidget {
  const AddBeneficiaryWidget({
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
          title: 'Beneficiary Added Successfully',
          subtitle:
              'Great job! You have successfully added Peter Greene to your beneficiary list.',
        ),
        40.0.height,
        MainButton(
          text: 'Back to Home',
          onPressed: () {
            context.pushReplacementNamed(DashboardView.path);
          },
        ),
        12.0.height
      ],
    );
  }
}
