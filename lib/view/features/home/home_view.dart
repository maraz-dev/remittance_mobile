import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_card.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/widgets/add_new_account_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_account_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_appbar.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_image.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_service_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/rates_card.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/recent_transaction_header.dart';
import 'package:remittance_mobile/view/utils/box_decoration.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class HomeView extends StatefulWidget {
  static String path = '/home-view';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundColor,
        automaticallyImplyLeading: false,
        title: const HomeAppBarWidget(),
      ),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Acounts
            const SectionHeader(text: 'Accounts'),
            12.0.height,
            SizedBox(
              height: 135.h,
              child: Row(
                children: [
                  const AddNewAccountCard(),
                  10.0.width,
                  AccountsCard(
                    onPressed: () =>
                        context.pushNamed(CurrencyAccountView.path),
                  )
                ],
              ),
            ),
            10.0.height,

            /// Rates
            const RatesCard(),
            36.0.height,

            /// Services
            const SectionHeader(text: 'Services'),
            8.0.height,
            const HomeServiceCard(),
            36.0.height,

            /// Banner
            SizedBox(
              height: 120.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const HomeImage();
                },
                separatorBuilder: (context, index) => 12.0.width,
                itemCount: 2,
              ),
            ),
            16.0.height,

            /// Transactions
            const RecentTransactionHeader(),
            12.0.height,
            Container(
              decoration: whiteCardDecoration(),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => const TransactionCard(),
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: AppColors.kCountryDropDownColor,
                    height: 0,
                  );
                },
                itemCount: 5,
              ),
            ),
            30.0.height,
          ],
        ),
      )),
    );
  }
}
