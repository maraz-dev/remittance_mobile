import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class HomeServiceCard extends StatelessWidget {
  final String? image, title;
  final Function()? onTap;

  const HomeServiceCard({
    super.key,
    this.image,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.kGrey300)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image ?? AppImages.sendMoney),
          8.0.width,
          Text(
            title ?? 'Send Money',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.kGrey700),
          )
        ],
      ),
    );
  }
}

List homeServiceCardList = [
  const HomeServiceCard(
    title: 'Send Money',
    image: AppImages.sendMoney,
  ),
  const HomeServiceCard(
    title: 'Add Card',
    image: AppImages.addCard,
  ),
  const HomeServiceCard(
    title: 'Pay Bills',
    image: AppImages.payBills,
  ),
];
