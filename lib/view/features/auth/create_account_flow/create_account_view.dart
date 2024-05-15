import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/choose_country_view.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_form_view.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_password_form.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/otp_verification_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart' as spi;

class CreateAccountView extends ConsumerStatefulWidget {
  static String path = "/create-account-view";
  const CreateAccountView({super.key});

  @override
  ConsumerState<CreateAccountView> createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends ConsumerState<CreateAccountView> {
  /// Controllers
  final PageController _pageController =
      PageController(viewportFraction: 1.0, keepPage: true);
  final PageStorageKey<String> _pageStorageKey =
      const PageStorageKey<String>('myPageViewKey');

  int pageCount = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: spi.SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  axisDirection: Axis.horizontal,
                  effect: spi.SlideEffect(
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
              16.0.height,
              Expanded(
                child: PageStorage(
                  bucket: PageStorageBucket(),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    key: _pageStorageKey,
                    onPageChanged: (value) {
                      setState(() => pageCount = value);
                    },
                    children: [
                      ChooseCountryView(
                        pressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                      ),
                      CreateAccountFormView(
                        pressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                      ),
                      OTPVerificationView(
                        pressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                      ),
                      CreateAccountPasswordFormView(
                        pressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
