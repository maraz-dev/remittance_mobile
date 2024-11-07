import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class SheetOptionCard extends StatelessWidget {
  final String? image, icon;
  final String text, subtitle;
  final bool? hasRadio;
  const SheetOptionCard({
    super.key,
    this.image,
    this.icon,
    required this.text,
    required this.subtitle,
    this.hasRadio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.kGrey50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          image != null
              ? SvgPicture.asset(image!)
              : icon != null
                  ? const CardIcon(
                      image: AppImages.accountDetails,
                      bgColor: AppColors.kGrey100,
                      padding: 8,
                    )
                  : const SizedBox.shrink(),
          12.0.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700, color: AppColors.kGrey700),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          const Spacer(),
          Visibility(
            visible: hasRadio ?? false,
            child: Radio(
              value: 'value',
              groupValue: 'groupValue',
              onChanged: (value) {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
