import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';

class ChooseCountryView extends ConsumerStatefulWidget {
  final VoidCallback pressed;

  const ChooseCountryView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<ChooseCountryView> createState() => _ChooseCountryViewState();
}

class _ChooseCountryViewState extends ConsumerState<ChooseCountryView> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.height,
              const BackArrowButton(),
              18.0.height,
              Text(
                'Sign Up',
                style: Theme.of(context).textTheme.displayLarge,
              )
                  .animate()
                  .fadeIn(
                    begin: 0,
                    delay: 400.ms,
                  )
                  .slideY(begin: -.5, end: 0),
              8.0.height,
              RichTextWidget(
                text: 'Already have an Account?',
                hyperlink: ' Log In',
                onTap: () => context.pop(),
              )
                  .animate()
                  .fadeIn(
                    begin: 0,
                    delay: 400.ms,
                  )
                  .slideX(begin: -.1, end: 0),
              32.0.height,
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          height: 120.h,
          children: [
            const RichTextWidget(
              text: "By continuing, you’ve accepted our ",
              hyperlink: 'terms and conditions.',
              onTap: null,
            ),
            12.0.height,
            MainButton(
              //isLoading: true,
              text: 'Continue',
              onPressed: () {
                widget.pressed();
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0),
          ],
        ),
      ),
    );
  }
}
