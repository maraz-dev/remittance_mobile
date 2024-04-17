import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_image.dart';
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
            Text(
              'Accounts',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            8.0.height,
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
            Text(
              'Services',
              style: Theme.of(context).textTheme.displaySmall,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.kTextBorderColor,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Text(
                    'See All',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
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

class AccountsCard extends StatelessWidget {
  const AccountsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 50),
      decoration: BoxDecoration(
          color: AppColors.kCardColor,
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundImage: const AssetImage(AppImages.us),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$500.21',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.kWhiteColor, fontWeight: FontWeight.bold),
              ),
              Text(
                'USD',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.kWhiteColor, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AddNewAccountCard extends StatelessWidget {
  const AddNewAccountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.kPrimaryColor,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: const [10, 10],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.kTextBorderColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppImages.homeViewAdd),
            Text(
              'Add New \t',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kSecondaryColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          SvgPicture.asset(AppImages.debit),
          12.0.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Peter Greene',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.kSecondaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const Text('Send money . 12:21pm'),
            ],
          ),
          const Spacer(),
          Text(
            '₦1,500.00',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.kErrorColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class HomeServiceCard extends StatelessWidget {
  final String? image, title;
  final Function()? onTap;

  const HomeServiceCard({
    super.key,
    this.image,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.kBorderColor)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image ?? AppImages.sendMoney),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title ?? 'Send Money',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.kSecondaryColor),
            ),
          )
        ],
      ),
    );
  }
}
