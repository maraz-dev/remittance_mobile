import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class FromButton extends ConsumerWidget {
  final String image, code;
  final Function()? onPressed;
  const FromButton({
    super.key,
    required this.image,
    required this.code,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          8.0.width,
          Text(
            code,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          8.0.width,
          SvgPicture.asset(AppImages.arrowDown),
        ],
      ),
    );
  }
}

class ToButton extends StatelessWidget {
  final String image, code;
  final Function()? onPressed;
  const ToButton({
    super.key,
    required this.image,
    required this.code,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          8.0.width,
          Text(
            code,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          8.0.width,
          SvgPicture.asset(AppImages.arrowDown),
        ],
      ),
    );
  }
}
