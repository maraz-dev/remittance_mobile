import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const AuthTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        )
            .animate()
            .fadeIn(
              begin: 0,
              delay: 400.ms,
            )
            .slideX(begin: -.1, end: 0),
        8.0.height,
        Visibility(
          visible: subtitle != null,
          child: Text(
            subtitle ?? '',
          )
              .animate()
              .fadeIn(
                begin: 0,
                delay: 400.ms,
              )
              .slideX(begin: -.1, end: 0),
        ),
      ],
    );
  }
}
