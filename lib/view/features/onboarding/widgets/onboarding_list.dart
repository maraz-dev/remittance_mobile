class OnboardingList {
  final String title;
  final String subtitle;

  OnboardingList({
    required this.title,
    required this.subtitle,
  });
}

List<OnboardingList> onboardingScreenList = [
  OnboardingList(
    title: 'Free Account, 10+ \ncurrencies',
    subtitle:
        'Create a Free account, a Virtual Card and hold Balances in more than 10 currencies and choose which to use at any time.',
  ),
  OnboardingList(
    title: 'Send, Receive & \nRequest Funds',
    subtitle:
        'Receive Money, Request Cash or Send Payment to 50+ countries instantly, with no hidden charges and at the best rate.',
  ),
  OnboardingList(
    title: 'Trusted by Partners across \nthe World',
    subtitle:
        'Known by Africans across the world to keep track of their balances and transfers, and get access to their money on the go, anywhere.',
  )
];
