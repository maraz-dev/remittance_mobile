import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            16.0.height,
            Center(
              child: Image.asset(
                AppImages.remittanceLogo,
                width: 90.w,
              ),
            ),
            24.0.height,
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 4,
                axisDirection: Axis.horizontal,
                effect: SlideEffect(
                  spacing: 8.0,
                  radius: 10.0,
                  dotWidth: 75.w,
                  dotHeight: 4.5,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey.shade300,
                  activeDotColor: AppColors.kPrimaryColor,
                ),
              ),
            ),
            32.0.height,
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
                      40.0.height,
                      Image.asset(value.image)
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
              Row(
                children: [
                  Expanded(
                    child: MainButton(
                      text: "Sign In",
                      textColor: AppColors.kPrimaryColor,
                      borderColor: AppColors.kPrimaryColor,
                      color: Colors.white,
                      onPressed: () => context.pushNamed(LoginScreen.path),
                    ),
                  ),
                  10.0.width,
                  Expanded(
                    child: MainButton(
                      text: "Get Started",
                      onPressed: () =>
                          context.pushNamed(CreateAccountView.path),
                    ),
                  ),
                ],
              ),
              16.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
