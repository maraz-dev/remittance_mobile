import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class SendTrxDetailsCard extends StatelessWidget {
  final String? heading, info, title, subtitle, icon;
  final Function()? onPressed;
  const SendTrxDetailsCard({
    super.key,
    this.heading,
    this.info,
    this.title,
    this.subtitle,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionHeader(text: heading ?? 'Pay via'),
              Visibility(
                visible: info != null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kTealColor100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    info ?? 'Cash Drop-off',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.kTealColor200),
                  ),
                ),
              )
            ],
          ),
          8.0.height,
          Row(
            children: [
              CardIcon(
                image: icon ?? AppImages.location,
                bgColor: AppColors.kGrey100,
              ),
              16.0.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'Plot 10',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.w700),
                  ),
                  Text(subtitle ?? 'Civic towers, Victoria Island, Lagos'),
                  InkWell(
                    onTap: onPressed,
                    child: Text(
                      'Change',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.kPrimaryColor),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
