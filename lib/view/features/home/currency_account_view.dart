import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/add_money_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_initial_view.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/latest_transaction_box.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/widgets/account_options.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class CurrencyAccountView extends StatefulWidget {
  static String path = 'currency-account-screen';
  const CurrencyAccountView({super.key});

  @override
  State<CurrencyAccountView> createState() => _CurrencyAccountViewState();
}

class _CurrencyAccountViewState extends State<CurrencyAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'USD Account'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              20.0.height,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Balance'),
                        Image.asset(AppImages.us, width: 32, height: 32)
                      ],
                    ),
                    10.0.height,
                    SizedBox(
                      width: 300,
                      child: Text(
                        5000000.21.amountWithCurrency('usd'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 36.sp),
                      ),
                    ),
                    24.0.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AccountOptions(
                          text: 'Add Money',
                          image: AppImages.add,
                          onPressed: () => context.pushNamed(AddMoneyView.path),
                        ),
                        16.0.width,
                        AccountOptions(
                          text: 'Exchange',
                          image: AppImages.exchange,
                          onPressed: () =>
                              context.pushNamed(ExchangeInitialView.path),
                        ),
                        16.0.width,
                        AccountOptions(
                          text: 'More',
                          image: AppImages.more,
                          onPressed: () {
                            AppBottomSheet.showBottomSheet(context,
                                widget: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionHeader(text: 'More'),
                                    24.0.height,
                                    ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return currencyAccountList[index];
                                      },
                                      separatorBuilder: (context, index) =>
                                          24.0.height,
                                      itemCount: currencyAccountList.length,
                                    )
                                  ],
                                ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              20.0.height,

              // Latest Transactions
              const LatestTransactionsBox(),
              30.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
