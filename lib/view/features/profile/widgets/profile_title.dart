import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

class ProfileTitle extends StatelessWidget {
  final String title;
  const ProfileTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.kSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
