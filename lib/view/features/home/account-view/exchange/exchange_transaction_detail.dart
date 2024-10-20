import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/services/widgets/swap_icon_card.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class ExchangeTransactionDetailView extends StatefulWidget {
  static const path = 'exchange-transaction-detail-view';
  const ExchangeTransactionDetailView({super.key});

  @override
  State<ExchangeTransactionDetailView> createState() =>
      _ExchangeTransactionDetailViewState();
}

class _ExchangeTransactionDetailViewState
    extends State<ExchangeTransactionDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Exchange'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.0.height,

              // Transaction Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(text: 'Transaction Details'),
                    16.0.height,
                    const TrxItems(
                      title: 'Buy',
                      description: '1000 USD',
                    ),
                    16.0.height,
                    const TrxItems(
                      title: 'At (rate)',
                      description: '1 USD - 1500 NGN',
                    ),
                    16.0.height,
                    const TrxItems(
                      title: 'Seller receives',
                      description: '1,500,000 NGN',
                    ),
                    16.0.height,
                    const TrxItems(
                      title: 'You pay',
                      description: '1,500,000 NGN',
                    ),
                  ],
                ),
              ),
              16.0.height,

              Stack(
                children: [
                  Column(
                    children: [
                      // Pay Via
                      const ExchangeTrxDetailsCard(
                        info: 'Cash Drop-off',
                        title: 'Samsung Office',
                        subtitle: 'Shop 1B, Ikeja City Mall',
                      ),
                      24.0.height,

                      // Receive Via
                      const ExchangeTrxDetailsCard(
                        heading: 'Receive via',
                        info: 'Cash Pick up',
                      ),
                    ],
                  ),
                  Positioned(
                    left: ScreenUtil.defaultSize.width * 0.4,
                    top: ScreenUtil.defaultSize.width * 0.3,
                    child: const SwapIconWidget(),
                  )
                ],
              ),
              16.0.height,

              // Receive Via
              const ExchangeTrxDetailsCard(
                heading: 'Seller',
                icon: AppImages.seller,
                title: 'GoPay llc',
                subtitle: 'Verified Merchant',
              ),
              16.0.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            text: 'Buy',
            onPressed: () {},
          )
              .animate()
              .fadeIn(begin: 0, delay: 500.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
        ],
      ),
    );
  }
}

class ExchangeTrxDetailsCard extends StatelessWidget {
  final String? heading, info, title, subtitle, icon;
  const ExchangeTrxDetailsCard({
    super.key,
    this.heading,
    this.info,
    this.title,
    this.subtitle,
    this.icon,
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kGrey700, fontWeight: FontWeight.w700),
                  ),
                  Text(subtitle ?? 'Civic towers, Victoria Island, Lagos'),
                  Text(
                    'Change',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.kPrimaryColor),
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

class TrxItems extends StatelessWidget {
  final String? title, description;
  const TrxItems({
    super.key,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? 'Buy'),
        Text(
          description ?? '1000 USD',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.kGrey700),
        ),
      ],
    );
  }
}
