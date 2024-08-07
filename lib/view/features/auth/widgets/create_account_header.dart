import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class CreateAccountHeader extends StatelessWidget {
  const CreateAccountHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Create a ",
        style: Theme.of(context).textTheme.displayLarge,
        children: [
          TextSpan(
            text: "Smartpay\n",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.kGrey700),
          ),
          TextSpan(
            text: "account",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}
