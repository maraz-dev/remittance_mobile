import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_view.dart';
import 'package:remittance_mobile/view/features/auth/login_screen.dart';
import 'package:remittance_mobile/view/features/onboarding/widgets/onboarding_list.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static String path = '/onboarding-view';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: ScaffoldBody(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.splashImage,
            ),
            16.0.height,
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                dotColor: AppColors.kBorderColor,
                dotWidth: 8.w,
                dotHeight: 8.h,
              ),
            ),
            16.0.height,
            Expanded(
              child: PageView(
                controller: _pageController,
                children: List.generate(onboardingScreenList.length, (index) {
                  var value = onboardingScreenList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      8.0.height,
                      Text(
                        value.subtitle,
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainButton(
                text: "Get Started",
                onPressed: () => context.pushNamed(CreateAccountView.path),
              ),
              10.0.height,
              MainButton(
                text: "Sign In",
                textColor: AppColors.kPrimaryColor,
                borderColor: AppColors.kPrimaryColor,
                color: Colors.white,
                onPressed: () => context.pushNamed(LoginScreen.path),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
