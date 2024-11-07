import 'package:remittance_mobile/view/features/services/bill-payment/airtime_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/betting_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/cable_tv_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/electricity_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/internet_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/receive_money_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/virtual-cards/virtual_cards_empty_view.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class ServiceUtilities {
  final String image;
  final String text;
  final dynamic screenPath;

  ServiceUtilities({
    required this.image,
    required this.text,
    this.screenPath,
  });
}

List<ServiceUtilities> servicesTransferUtilities = [
  ServiceUtilities(
    image: AppImages.servicesSendMoney,
    text: 'Send\nMoney',
    screenPath: SendMoneyFromView.path,
  ),
  ServiceUtilities(
    image: AppImages.servicesReceiveMoney,
    text: 'Receive\nMoney',
    screenPath: ReceiveMoneyView.path,
  ),
];

List<ServiceUtilities> servicesBillsPaymentUtilities = [
  ServiceUtilities(
    image: AppImages.betting,
    text: 'Betting',
    screenPath: BettingView.path,
  ),
  ServiceUtilities(
    image: AppImages.electricity,
    text: 'Electricity',
    screenPath: ElectricityView.path,
  ),
  ServiceUtilities(
    image: AppImages.cableTv,
    text: 'Cable TV',
    screenPath: CableTvView.path,
  ),
  ServiceUtilities(
    image: AppImages.airtime,
    text: 'Airtime',
    screenPath: AirtimeView.path,
  ),
  ServiceUtilities(
    image: AppImages.internet,
    text: 'Internet',
    screenPath: InternetView.path,
  ),
];

List<ServiceUtilities> servicesExchangeUtilities = [
  ServiceUtilities(image: AppImages.buy, text: 'Buy'),
  ServiceUtilities(image: AppImages.sell, text: 'Sell'),
];

List<ServiceUtilities> servicesVirtualCardUtilities = [
  ServiceUtilities(
    image: AppImages.virtualCards,
    text: 'Cards',
    screenPath: VirtualCardEmptyView.path,
  ),
];
