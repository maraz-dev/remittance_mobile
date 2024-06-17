import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/add_money_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountOptions extends StatelessWidget {
  final Function()? onPressed;
  final String text, image;

  const AccountOptions({
    super.key,
    this.onPressed,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: AppColors.kGrey100, shape: BoxShape.circle),
            child: SvgPicture.asset(image),
          ),
        ),
        6.0.height,
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kGrey700,
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }
}

class AccountOptionsAlt extends StatelessWidget {
  final String? onPressed;
  final String text, image;

  const AccountOptionsAlt({
    super.key,
    this.onPressed,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(onPressed ?? '');
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: AppColors.kGrey100, shape: BoxShape.circle),
            child: SvgPicture.asset(image),
          ),
          16.0.width,
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kGrey700,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }
}

// List of More Options for Currency Account Page
List<AccountOptionsAlt> currencyAccountList = [
  AccountOptionsAlt(
    text: 'Add Money',
    image: AppImages.add,
    onPressed: AddMoneyView.path,
  ),
  const AccountOptionsAlt(text: 'Exchange', image: AppImages.exchange),
  const AccountOptionsAlt(text: 'Withdraw', image: AppImages.withdraw),
  const AccountOptionsAlt(
      text: 'Account Statement', image: AppImages.accountStatement),
  const AccountOptionsAlt(
      text: 'Account Details', image: AppImages.accountDetails),
  const AccountOptionsAlt(text: 'Deactivate', image: AppImages.deactivate),
];
