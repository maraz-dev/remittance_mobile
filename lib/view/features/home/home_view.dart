import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/accounts/widgets/transaction_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/add_new_account_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_account_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_image.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_service_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/recent_transaction_header.dart';
import 'package:remittance_mobile/view/features/home/widgets/section_header.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class HomeView extends StatefulWidget {
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
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: const AssetImage(AppImages.tempProfileImage),
            ),
            8.0.width,
            RichText(
                text: TextSpan(
              text: 'Welcome ',
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                    text: 'Ella',
                    style: Theme.of(context).textTheme.displaySmall),
                TextSpan(
                    text: '👋',
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            )),
            const Spacer(),
            SvgPicture.asset(AppImages.notification)
          ],
        ),
      ),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Acounts
            const SectionHeader(
              text: 'Accounts',
            ),
            12.0.height,
            SizedBox(
              height: 135.h,
              child: Row(
                children: [
                  const AddNewAccountCard(),
                  10.0.width,
                  const AccountsCard()
                ],
              ),
            ),
            36.0.height,

            /// Services
            const SectionHeader(
              text: 'Services',
            ),
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
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.kBorderColor),
              ),
              child: Expanded(
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => const TransactionCard(),
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: AppColors.kBorderColor,
                      );
                    },
                    itemCount: 5),
              ),
            ),
            30.0.height,
          ],
        ),
      )),
    );
  }
}
