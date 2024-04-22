import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/profile/profile_options.dart';
import 'package:remittance_mobile/view/features/profile/widgets/profile_card.dart';
import 'package:remittance_mobile/view/features/profile/widgets/profile_title.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/box_decoration.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class ProfileView extends StatefulWidget {
  static String path = '/profile-view';
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
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
              ),
              Positioned(
                bottom: -65,
                child: Row(
                  children: [
                    20.0.width,
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              AssetImage(AppImages.tempProfileImage),
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
                          'Adebola Sanni',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kBlackColor),
                        ),
                        const Text('@pinkybolar'),
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
                              onPressed: () =>
                                  context.pushNamed(value.optionPath),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0,
                              color: AppColors.kCountryDropDownColor,
                            );
                          },
                          itemCount: profilePersonalInfoItems.length,
                        ),
                      ),
                      24.0.height,
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
                              onPressed: () =>
                                  context.pushNamed(value.optionPath),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0,
                              color: AppColors.kCountryDropDownColor,
                            );
                          },
                          itemCount: profileSecurityItems.length,
                        ),
                      ),
                      24.0.height,
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
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0,
                              color: AppColors.kCountryDropDownColor,
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
