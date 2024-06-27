import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class EnableBiometricsSheet extends ConsumerStatefulWidget {
  const EnableBiometricsSheet({
    super.key,
  });

  @override
  ConsumerState<EnableBiometricsSheet> createState() =>
      _EnableBiometricsSheetState();
}

class _EnableBiometricsSheetState extends ConsumerState<EnableBiometricsSheet> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.cancel_rounded),
            ),
          ),
          16.0.height,
          CardIcon(
            image: Theme.of(context).platform == TargetPlatform.iOS
                ? AppImages.faceID
                : AppImages.fingerprint,
            padding: 32,
            iconColor: AppColors.kPrimaryColor.colorFilterMode(),
            bgColor: AppColors.kGrey100,
            size: 56,
          ),
          16.0.height,
          const SectionHeader(text: 'Enable Biometrics'),
          5.0.height,
          Text(
            'Perform transactions swiftly using your fingerprint or facial recognition.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.kGrey500),
          ),
          24.0.height,
          BiometricsOptionCard(
            text: 'Account Login',
            image: AppImages.keyIcon,
            value: ref.watch(loginSwitchProvider),
            onChanged: (value) {
              ref.read(loginSwitchProvider.notifier).state = value;
            },
          ),
          16.0.height,
          BiometricsOptionCard(
            text: 'Transactions',
            image: AppImages.convertShapeIcon,
            value: ref.watch(transxSwitchProvider),
            onChanged: (value) {
              ref.read(transxSwitchProvider.notifier).state = value;
            },
          ),
          30.0.height,
        ],
      );
    });
  }
}

class BiometricsOptionCard extends StatelessWidget {
  final String text, image;
  final bool value;
  final Function(bool)? onChanged;
  const BiometricsOptionCard({
    super.key,
    required this.text,
    required this.image,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kGrey100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CardIcon(
            image: image,
            bgColor: AppColors.kGrey200,
          ),
          12.0.width,
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.kGrey700),
          ),
          const Spacer(),
          Switch(
            value: value,
            activeTrackColor: AppColors.kPrimaryColor,
            inactiveTrackColor: AppColors.kGrey300,
            inactiveThumbColor: AppColors.kWhiteColor,
            trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                return Colors.transparent;
              },
            ),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
