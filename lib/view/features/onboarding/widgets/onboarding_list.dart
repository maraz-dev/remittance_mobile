import 'package:remittance_mobile/view/utils/app_images.dart';

class OnboardingList {
  final String title;
  final String subtitle;
  final String image;

  OnboardingList({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

List<OnboardingList> onboardingScreenList = [
  OnboardingList(
    title: 'Free Account, 10+ \ncurrencies',
    subtitle:
        'Create a Free account, a Virtual Card and hold Balances in more than 10 currencies and choose which to use at any time.',
    image: AppImages.onboardingOne,
  ),
  OnboardingList(
    title: 'Send, Receive & \nRequest Funds',
    subtitle:
        'Receive Money, Request Cash or Send Payment to 50+ countries instantly, with no hidden charges and at the best rate.',
    image: AppImages.onboardingTwo,
  ),
  OnboardingList(
    title: 'Send, Receive & \nRequest Funds',
    subtitle:
        'Receive Money, Request Cash or Send Payment to 50+ countries instantly, with no hidden charges and at the best rate.',
    image: AppImages.onboardingThree,
  ),
  OnboardingList(
    title: 'Send, Receive & \nRequest Funds',
    subtitle:
        'Receive Money, Request Cash or Send Payment to 50+ countries instantly, with no hidden charges and at the best rate.',
    image: AppImages.onboardingFour,
  ),
];
