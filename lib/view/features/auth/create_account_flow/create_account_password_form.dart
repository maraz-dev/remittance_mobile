import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';

class CreateAccountPasswordFormView extends ConsumerStatefulWidget {
  final VoidCallback pressed;
  const CreateAccountPasswordFormView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<CreateAccountPasswordFormView> createState() =>
      _CreateAccountPasswordFormViewState();
}

class _CreateAccountPasswordFormViewState
    extends ConsumerState<CreateAccountPasswordFormView> {
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
              const AuthTitle(
                  title: 'Create Password',
                  subtitle: 'Create a password for your account.'),
              32.0.height,
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              //isLoading: true,
              text: 'Continue',
              onPressed: () {
                context.pop();
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
