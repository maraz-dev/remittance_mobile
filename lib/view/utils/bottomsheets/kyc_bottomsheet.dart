import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/kyc_options.dart';
import 'package:remittance_mobile/view/features/home/widgets/kyc_card.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

kycBottomSheet(BuildContext context) {
  AppBottomSheet.showBottomSheet(
    context,
    widget: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppImages.kycShield),
          16.0.height,
          const BottomSheetTitle(
            title: 'Account Created',
            subtitle: 'Welcome to BorderPal. Let’s shake the world!',
          ),
          24.0.height,
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var value = kycOptionList[index];
                return KycCard(
                  title: value.title,
                  subtitle: value.subtitle,
                  onPressed: () => context.pushNamed(value.optionPath),
                );
              },
              separatorBuilder: (context, index) => 5.0.height,
              itemCount: kycOptionList.length)
        ],
      ),
    ),
  );
}
