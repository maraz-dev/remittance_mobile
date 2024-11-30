import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class RichTextWidget extends StatelessWidget {
  final String text, hyperlink;
  final Function()? onTap;
  final Color? hyperlinkColor;

  const RichTextWidget({
    super.key,
    required this.text,
    required this.hyperlink,
    this.onTap,
    this.hyperlinkColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: hyperlink,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: hyperlinkColor ?? AppColors.kPrimaryColor,
                ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
