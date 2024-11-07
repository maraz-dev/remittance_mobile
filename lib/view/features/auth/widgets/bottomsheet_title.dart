import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class BottomSheetTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const BottomSheetTitle({
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
          style: Theme.of(context).textTheme.displayMedium,
        ),
        if (subtitle != null) ...[
          8.0.height,
          Text(
            subtitle!,
          )
        ]
      ],
    );
  }
}
