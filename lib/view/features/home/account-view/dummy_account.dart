import 'package:remittance_mobile/view/utils/app_images.dart';

class CurrencyAccountDetails {
  final String accountImage;
  final double balance;
  final String accountType;

  CurrencyAccountDetails(
      {required this.accountImage,
      required this.balance,
      required this.accountType});
}

List<CurrencyAccountDetails> accountList = [
  CurrencyAccountDetails(
    accountImage: AppImages.us,
    balance: 500,
    accountType: 'USD',
  ),
  CurrencyAccountDetails(
    accountImage: AppImages.ng,
    balance: 5000000,
    accountType: 'NGN',
  ),
  CurrencyAccountDetails(
    accountImage: AppImages.uk,
    balance: 415,
    accountType: 'GBP',
  ),
];
