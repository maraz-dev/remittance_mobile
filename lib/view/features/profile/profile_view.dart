import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/utils/constants.dart';
import 'package:remittance_mobile/data/local/user_data_impl.dart';
import 'package:remittance_mobile/view/features/profile/profile_options.dart';
import 'package:remittance_mobile/view/features/profile/widgets/biometrics_sheet.dart';
import 'package:remittance_mobile/view/features/profile/widgets/profile_card.dart';
import 'package:remittance_mobile/view/features/profile/widgets/profile_title.dart';
import 'package:remittance_mobile/view/features/webview/app_webview.dart';
import 'package:remittance_mobile/view/route/current_user_notifier.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/box_decoration.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class ProfileView extends ConsumerStatefulWidget {
  static String path = '/profile-view';
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(localUserProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const SectionHeader(text: 'Profile'),
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          80.0.height,
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                AppImages.profileBackground,
                color: AppColors.kPrimaryColor.withOpacity(0.7),
              ),
              Positioned(
                bottom: -65,
                child: Row(
                  children: [
                    20.0.width,
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kGrey100,
                          ),
                          child: const CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(AppImages.selfieImageTwo),
                          ),
                        ),
                        Positioned(
                          right: -2,
                          bottom: 0,
                          child: SvgPicture.asset(AppImages.uploadImage),
                        )
                      ],
                    ),
                    15.0.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.0.height,
                        Text(
                          '${userProfile.value?.firstName!.split(' ').first} ${userProfile.value?.lastName!.split(' ').last}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
                        ),
                        Text(userProfile.value?.email ?? ''),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          90.0.height,
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: SingleChildScrollView(
                child: ScaffoldBody(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PERSONAL INFORMATION
                      const ProfileTitle(title: 'PERSONAL INFORMATION'),
                      8.0.height,
                      Container(
                        decoration: whiteCardDecoration(),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var value = profilePersonalInfoItems[index];
                            return ProfileCard(
                              image: value.image,
                              text: value.text,
                              onPressed: () => value.optionPath == null
                                  ? null
                                  : context.pushNamed(
                                      value.optionPath,
                                      extra: userProfile.value,
                                    ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0,
                              color: AppColors.kGrey100,
                            );
                          },
                          //! TODO: Change to profilePersonalInfoItems.length
                          itemCount: 2,
                        ),
                      ),
                      24.0.height,

                      // SECURITY
                      const ProfileTitle(title: 'SECURITY'),
                      8.0.height,
                      Container(
                        decoration: whiteCardDecoration(),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var value = profileSecurityItems[index];
                            return ProfileCard(
                              image: value.image,
                              text: value.text,
                              onPressed: value.optionPath == null && value.text != 'Biometrics'
                                  ? () {}
                                  : () {
                                      value.text == 'Biometrics'
                                          ? AppBottomSheet.showBottomSheet(
                                              context,
                                              isDismissible: false,
                                              enableDrag: false,
                                              widget: const EnableBiometricsSheet(),
                                            )
                                          : context.pushNamed(value.optionPath);
                                    },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0,
                              color: AppColors.kGrey100,
                            );
                          },
                          //! TODO: Change to profileSecurityItems.length
                          itemCount: 3,
                        ),
                      ),
                      24.0.height,

                      // MORE
                      const ProfileTitle(title: 'MORE'),
                      8.0.height,
                      Container(
                        decoration: whiteCardDecoration(),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var value = profileMoreItems[index];
                            return ProfileCard(
                              image: value.image,
                              text: value.text,
                              color: value.color,
                              onPressed: () {
                                if (value.text == 'Log Out') {
                                  ref.read(userStateProvider.notifier).logOutUser();
                                } else if (value.text == 'Terms and Conditions') {
                                  context.pushNamed(WebviewScreen.path, pathParameters: {
                                    "url":
                                        "$APP_PARTNER_DOMAIN_NAME/${PrefKeys.termsAndConditions}",
                                    "routeName": "Terms and Conditions",
                                  });
                                } else if (value.text == 'Privacy Policy') {
                                  context.pushNamed(WebviewScreen.path, pathParameters: {
                                    "url": "$APP_PARTNER_DOMAIN_NAME/${PrefKeys.privacyPolicy}",
                                    "routeName": "Privacy Policy",
                                  });
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0,
                              color: AppColors.kGrey100,
                            );
                          },
                          itemCount: profileMoreItems.length,
                        ),
                      ),
                      24.0.height,
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
