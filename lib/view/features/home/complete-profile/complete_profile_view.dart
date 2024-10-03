import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/kyc_options.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/ssn_and_bvn_view.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class CompleteProfileView extends StatelessWidget {
  static String path = '/complete-profile-view';
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Complete Your Profile'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              16.0.height,
              Text(
                'We will be asking you to provide the information below to complete your account.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.kGrey700),
              ),
              24.0.height,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var value = kycOptionList[index];
                  return Row(
                    children: [
                      CardIcon(
                        image: value.imagePath,
                        bgColor: AppColors.kBrandColor,
                      ),
                      12.0.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.kGrey700,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          5.0.height,
                          Text(
                            value.subtitle,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.kGrey500,
                                    ),
                          ),
                        ],
                      )
                    ],
                  ).animate().fadeIn().slideY(begin: -1, end: 0);
                },
                separatorBuilder: (context, index) => 24.0.height,
                itemCount: kycOptionList.length,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Start',
            onPressed: () {
              context.pushNamed(SsnAndBvnView.path);
            },
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
