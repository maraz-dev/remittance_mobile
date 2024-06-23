import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/bottomsheets/kyc_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class KycInfoCard extends ConsumerStatefulWidget {
  const KycInfoCard({
    super.key,
  });

  @override
  ConsumerState<KycInfoCard> createState() => _KycInfoCardState();
}

class _KycInfoCardState extends ConsumerState<KycInfoCard> {
  @override
  Widget build(BuildContext context) {
    // Get KYC Status
    final kycStatus = ref.watch(getKycStatusProvider);

    return kycStatus.maybeWhen(
        orElse: () => SkeletonLine(
              style: SkeletonLineStyle(
                height: 45,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
        data: (data) {
          switch (data.validationStatus) {
            case "Pending":
              return KYCInfo(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      kycBottomSheet(
                        context: context,
                        current: kycPosition.value,
                      );
                    },
                  );
                },
                text: "Profile Incomplete!",
                subText: 'Complete your profile to enjoy all our features',
                textColor: AppColors.kGrey700,
              );
            case "Initiated":
              return const KYCInfo(
                subText: 'Check Back Later...',
                showArrow: false,
              );
            case "Failed":
              return KYCInfo(
                bgColor: AppColors.kWarningColor700,
                text: "Profile Rejected!",
                subText: "${data.comment}",
                textColor: AppColors.kWarningColor50,
                arrowColor: AppColors.kWarningColor50,
              );
            default:
              return Container();
          }
        },
        error: (error, stackTrace) {
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.kErrorColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CardIcon(
                  padding: 8,
                  image: AppImages.timer,
                  iconColor: AppColors.kErrorColor.colorFilterMode(),
                  bgColor: AppColors.kWhiteColor,
                ),
                8.0.width,
                Expanded(
                  child: Text(
                    kDebugMode
                        ? error.toString()
                        : "Couldn't Fetch Profile Status",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.kErrorColor),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class KYCInfo extends StatelessWidget {
  final Function()? onPressed;
  final Color? bgColor, textColor, arrowColor;
  final ColorFilter? iconColor;
  final String? text, subText;
  final bool showArrow;

  const KYCInfo({
    super.key,
    this.iconColor,
    this.text,
    this.textColor,
    this.bgColor,
    this.onPressed,
    this.subText,
    this.showArrow = true,
    this.arrowColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.kWarningColor100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CardIcon(
              padding: 8,
              image: AppImages.timer,
              iconColor:
                  iconColor ?? AppColors.kWarningColor700.colorFilterMode(),
              bgColor: AppColors.kWhiteColor,
            ),
            8.0.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text ?? 'Your Profile is Pending Approval!',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: textColor ?? AppColors.kWarningColor700,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Visibility(
                    visible: subText != null,
                    child: Text(
                      subText ?? '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: textColor ?? AppColors.kWarningColor700,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showArrow,
              child: Icon(
                Icons.keyboard_arrow_right_sharp,
                color: arrowColor,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
