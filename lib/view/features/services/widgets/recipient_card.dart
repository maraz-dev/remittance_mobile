import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class AddNewRecipientWidget extends StatelessWidget {
  final Function()? onPressed;
  const AddNewRecipientWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 100),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CardIcon(
            padding: 30,
            size: 40,
            bgColor: AppColors.kGrey200,
            image: AppImages.recipient,
          ),
          16.0.height,
          const SectionHeader(
            text: 'No Recipients',
            fontSize: 14,
          ),
          16.0.height,
          GestureDetector(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.add,
                  colorFilter: AppColors.kPrimaryColor.colorFilterMode(),
                ),
                5.0.width,
                Text(
                  'Add Recipient',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.kPrimaryColor,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddNewRecipientAlt extends StatelessWidget {
  final Function()? onPressed;
  const AddNewRecipientAlt({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CardIcon(
            image: AppImages.recipient,
            padding: 8,
            bgColor: AppColors.kGrey100,
          ),
          12.0.width,
          Text(
            "New Recipient",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.kGrey700,
                ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onPressed,
            child: SvgPicture.asset(AppImages.arrowRight),
          ),
        ],
      ),
    );
  }
}

class RecipientsCard extends StatelessWidget {
  final String? image, channel, name, accNumber;
  const RecipientsCard({
    super.key,
    this.image,
    this.channel,
    this.name,
    this.accNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(image ?? ""),
        ),
        12.0.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.kGrey700,
                  ),
            ),
            Text("$accNumber · $channel")
          ],
        ),
        const Spacer(),
        SvgPicture.asset(AppImages.arrowRight),
      ],
    );
  }
}
