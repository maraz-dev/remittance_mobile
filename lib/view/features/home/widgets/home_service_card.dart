import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/airtime_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_initial.dart';
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
      onTap: () => context.pushNamed(onTap ?? SendMoneyInitialView.path),
      child: Container(
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
      ),
    );
  }
}

List homeServiceCardList = [
  HomeServiceCard(
    title: 'Send Money',
    image: AppImages.sendMoney,
    onTap: SendMoneyInitialView.path,
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
