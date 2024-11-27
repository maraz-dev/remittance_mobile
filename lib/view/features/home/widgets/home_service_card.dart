import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/complete_profile_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/airtime_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/services/virtual-cards/virtual_cards_empty_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class HomeServiceCard extends StatelessWidget {
  final String? image, title;
  final String? onTap;

  const HomeServiceCard({
    super.key,
    this.image,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => SharedPrefManager.isKycComplete
          ? context.pushNamed(onTap ?? SendMoneyHowMuchView.path)
          : context.pushNamed(CompleteProfileView.path),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(image ?? AppImages.sendMoney),
            8.0.width,
            Text(
              title ?? 'Send Money',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.kGrey700),
            )
          ],
        ),
      ),
    );
  }
}

List homeServiceCardList = [
  const HomeServiceCard(
    title: 'Send Money',
    image: AppImages.sendMoney,
    onTap: SendMoneyFromView.path,
  ),
  HomeServiceCard(
    title: 'Add Card',
    image: AppImages.addCard,
    onTap: VirtualCardEmptyView.path,
  ),
  HomeServiceCard(
    title: 'Pay Bills',
    image: AppImages.payBills,
    onTap: AirtimeView.path,
  ),
];
