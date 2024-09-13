import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/bank_transfer_sheet.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';

class ConfirmCreateAccountView extends StatefulWidget {
  final AccountModel accountDetails;
  static String path = 'confirm-create-account';
  const ConfirmCreateAccountView({
    super.key,
    required this.accountDetails,
  });

  @override
  State<ConfirmCreateAccountView> createState() =>
      _ConfirmCreateAccountViewState();
}

class _ConfirmCreateAccountViewState extends State<ConfirmCreateAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: innerAppBar(title: '${widget.accountDetails.currency} Account'),
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
                          widget.accountDetails.currency ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 36.sp),
                        ),
                      ),
                      24.0.height,
                      const Divider(),
                      24.0.height,
                      AccountDetailsCard(
                        title: 'Account Name',
                        value: widget.accountDetails.accountName,
                        showCopy: false,
                      ),
                      24.0.height,
                      AccountDetailsCard(
                        title: 'Account Number/IBAN',
                        value: widget.accountDetails.accountNumber,
                        showCopy: false,
                      ),
                      if (widget.accountDetails.currency == "USD") ...[
                        24.0.height,
                        const AccountDetailsCard(
                          title: 'Sort Code',
                          value: '357585735399',
                          showCopy: false,
                        ),
                      ]
                    ],
                  ),
                ),
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
                        const Text(
                            'American USD Accounts are balances with the items below'),
                        12.0.height,
                        const Text('Wire routing number'),
                        12.0.height,
                        const Text('Bank code (SWIFT/BIC)'),
                        12.0.height,
                        const Text('Routing number (ACH / ABA)'),
                        12.0.height,
                        const Text(
                            'NB* Account details will be generated in your name'),
                      ],
                    )),

                // Currency Information
                30.0.height,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              //isLoading: true,
              text: 'Proceed',
              onPressed: () {
                context.pushNamed(
                  CurrencyAccountView.path,
                  extra: widget.accountDetails,
                );
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0),
            10.0.height,
          ],
        ));
  }
}
