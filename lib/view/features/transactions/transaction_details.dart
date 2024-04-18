import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class AddMoneyTransactionDetails extends StatefulWidget {
  static String path = 'add-money-transaction-details';
  const AddMoneyTransactionDetails({super.key});

  @override
  State<AddMoneyTransactionDetails> createState() =>
      _AddMoneyTransactionDetailsState();
}

class _AddMoneyTransactionDetailsState extends State<AddMoneyTransactionDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SectionHeader(text: 'Transaction Details'),
      ),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: AppColors.kTextfieldColor,
                  border: Border.all(color: AppColors.kBorderColor)),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.kBlueColor,
                dividerColor: Colors.transparent,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
                indicator: BoxDecoration(
                    color: AppColors.kPurpleColor,
                    borderRadius: BorderRadius.circular(30.r)),
                indicatorSize: TabBarIndicatorSize.tab,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (states) => Colors.transparent,
                ),
                tabs: const [
                  Tab(text: 'Details'),
                  Tab(text: 'Updates'),
                ],
              ),
            ),
            32.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppImages.success),
                InkWell(
                  onTap: () {
                    AppBottomSheet.showBottomSheet(
                      context,
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppImages.success),
                          16.0.height,
                          const BottomSheetTitle(
                            title: 'Beneficiary Added Successfully',
                            subtitle:
                                'Great job! You have successfully added Peter Greene to your beneficiary list.',
                          ),
                          40.0.height,
                          MainButton(
                            text: 'Back to Home',
                            onPressed: () {
                              context.pushReplacementNamed(DashboardView.path);
                            },
                          ),
                          12.0.height
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Add To Beneficiary',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.kPrimaryColor),
                  ),
                )
              ],
            ),
            12.0.height,

            /// Amount Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kBorderColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    12.31.amountWithCurrency('usd'),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 40.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.kLightSuccessColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      'Successful',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.kSuccessColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            16.0.height,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kBorderColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TDetailsCard(
                    title: 'Sender Name',
                    text: 'Peter Greene',
                  ),
                  24.0.height,
                  const TDetailsCard(
                    title: 'Transaction Type',
                    text: 'Send Money',
                  ),
                  24.0.height,
                  const TDetailsCard(
                    title: 'Recipient Name',
                    text: 'Paul Blu',
                  ),
                  24.0.height,
                  const TDetailsCard(
                    title: 'Recipient Bank',
                    text: 'First Bank Nigeria',
                  ),
                  24.0.height,
                  const TDetailsCard(
                    title: 'Recipient Account Number',
                    text: '982377362',
                  ),
                  24.0.height,
                  TDetailsCard(
                    title: 'Additional Fees',
                    text: 2.52.amountWithCurrency('usd'),
                  ),
                  24.0.height,
                  const TDetailsCard(
                    title: 'Transaction ID',
                    text: '9837982372838',
                  ),
                  24.0.height,
                  const TDetailsCard(
                    title: 'Account Name',
                    text: 'USD Account',
                  ),
                ],
              ),
            ),
            30.0.height
          ],
        ),
      )),
      bottomNavigationBar: BottomNavBarWidget(children: [
        MainButton(
          text: 'Share Receipt',
          onPressed: () {},
        ),
        8.0.height,
        MainButton(
          text: 'Back to Home',
          color: AppColors.kWhiteColor,
          textColor: AppColors.kSecondaryColor,
          borderColor: AppColors.kBorderColor,
          onPressed: () {
            context.pushReplacementNamed(DashboardView.path);
          },
        ),
      ]),
    );
  }
}

class TDetailsCard extends StatelessWidget {
  final String? title, text;
  const TDetailsCard({
    super.key,
    this.title,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? 'Sender Name'),
        Text(
          text ?? 'Peter Greene',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
