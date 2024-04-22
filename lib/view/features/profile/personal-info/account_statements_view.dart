import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/features/profile/profile_options.dart';
import 'package:remittance_mobile/view/features/profile/widgets/profile_card.dart';
import 'package:remittance_mobile/view/features/profile/widgets/statement_header.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/box_decoration.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class AccountStatementView extends StatefulWidget {
  static String path = 'account-statement-view';
  const AccountStatementView({super.key});

  @override
  State<AccountStatementView> createState() => _AccountStatementViewState();
}

class _AccountStatementViewState extends State<AccountStatementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Account Statements'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.height,
              const StatementYearHeader(text: '2024'),
              8.0.height,
              Container(
                decoration: whiteCardDecoration(),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.kTextBorderColor,
                            ),
                            child: SvgPicture.asset(
                              AppImages.documentText,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.kPrimaryColor, BlendMode.srcIn),
                            ),
                          ),
                          12.0.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Statement for Apr.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.kSecondaryColor,
                                        fontWeight: FontWeight.bold),
                              ),
                              const Text('12:21pm'),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.kCountryDropDownColor,
                              borderRadius: BorderRadius.circular(36.r),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Export',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.kSecondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 14,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      color: AppColors.kCountryDropDownColor,
                    );
                  },
                  itemCount: profileMoreItems.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
