import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/add_money_view.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/latest_transaction_box.dart';
import 'package:remittance_mobile/view/widgets/account_options.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';

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
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  AppImages.accountViewImage,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.kCardColor,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Text(
                        'Balance',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.kWhiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    10.0.height,
                    Text(
                      500.21.amountWithCurrency('usd'),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.kWhiteColor,
                          fontSize: 40.sp),
                    ),
                    65.0.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AccountOptions(
                          text: 'Add',
                          image: AppImages.add,
                          onPressed: () => context.pushNamed(AddMoneyView.path),
                        ),
                        const AccountOptions(
                          text: 'Exchange',
                          image: AppImages.exchange,
                        ),
                        const AccountOptions(
                          text: 'Details',
                          image: AppImages.details,
                        ),
                        const AccountOptions(
                          text: 'Statement',
                          image: AppImages.statment,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            30.0.height,
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    /// Transactions
                    /// Transactions
                    12.0.height,
                    const LatestTransactionsBox(),
                    30.0.height,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
