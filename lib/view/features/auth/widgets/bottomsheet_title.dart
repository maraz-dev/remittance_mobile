import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class BottomSheetTitle extends StatelessWidget {
  final String title, subtitle;
  const BottomSheetTitle({
    super.key,
    required this.title,
    required this.subtitle,
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
        8.0.height,
        Text(
          subtitle,
        )
      ],
    );
  }
}
