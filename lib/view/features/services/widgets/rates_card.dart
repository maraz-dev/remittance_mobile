import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class RatesCard extends StatelessWidget {
  final String image, description;
  final String? text;
  final Function()? onTapped;
  const RatesCard({
    super.key,
    required this.image,
    this.text,
    required this.description,
    this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardIcon(
          image: image,
          padding: 4,
          bgColor: AppColors.kGrey200,
        ),
        8.0.width,
        if (text != null) ...[
          Text(
            text ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.kGrey700,
                ),
          ),
          const Spacer(),
        ],
        InkWell(
          onTap: onTapped,
          child: Text(
            description,
            style: description.contains('Fees')
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.kPrimaryColor,
                    )
                : null,
          ),
        ),
        if (description.contains('Fees')) ...[
          text != null ? 9.0.width : const Spacer(),
          InkWell(
            onTap: onTapped,
            child: SvgPicture.asset(AppImages.arrowDown),
          ),
        ]
      ],
    );
  }
}
