import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
                      kycBottomSheet(context);
                    },
                  );
                },
                bgColor: AppColors.kGrey200,
                iconColor: AppColors.kGrey700.colorFilterMode(),
                text: "Submit Your KYC",
                textColor: AppColors.kGrey700,
              );
            case "Initiated":
              return const KYCInfo();
            case "Rejected":
              return KYCInfo(
                bgColor: AppColors.kErrorColor.withOpacity(0.2),
                iconColor: AppColors.kErrorColor.colorFilterMode(),
                text: "KYC Rejected. ${data.comment}",
                textColor: AppColors.kErrorColor,
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
                    kDebugMode ? error.toString() : "Couldn't fetch KYC Status",
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
  final Color? bgColor;
  final ColorFilter? iconColor;
  final String? text;
  final Color? textColor;
  const KYCInfo({
    super.key,
    this.iconColor,
    this.text,
    this.textColor,
    this.bgColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.kWarningColor50,
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
              child: Text(
                text ?? 'Your Profile is Pending Approval.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: textColor ?? AppColors.kWarningColor700,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
