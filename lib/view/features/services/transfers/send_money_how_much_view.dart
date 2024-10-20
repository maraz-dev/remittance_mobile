import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/home/widgets/balance_widget.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/send_charge_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/rates_card.dart';
import 'package:remittance_mobile/view/features/services/widgets/send_currency_widgets.dart';
import 'package:remittance_mobile/view/features/services/widgets/swap_icon_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

ValueNotifier<AccountModel> srcCurrencyValue = ValueNotifier(AccountModel());
ValueNotifier<AccountCurrencies> desCurrencyValue = ValueNotifier(AccountCurrencies());

enum SendRoute { from, to }

class SendMoneyHowMuchView extends ConsumerStatefulWidget {
  static String path = 'send-money-how-much';
  const SendMoneyHowMuchView({super.key});

  @override
  ConsumerState<SendMoneyHowMuchView> createState() => _SendMoneyInitialViewState();
}

class _SendMoneyInitialViewState extends ConsumerState<SendMoneyHowMuchView> {
  //final GlobalKey<State> _recipientTypeKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();

  // final TextEditingController _sourceCurrency = TextEditingController();
  // final TextEditingController _destinationCurrency = TextEditingController();
  final TextEditingController _sourceAmount = TextEditingController();
  final TextEditingController _destinationAmount = TextEditingController();

  @override
  void dispose() {
    // _sourceCurrency.dispose();
    // _destinationCurrency.dispose();
    _sourceAmount.dispose();

    _destinationAmount.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendChargeLoading = ref.watch(sendChargeProvider).isLoading;
    final corridorsLoading =
        ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG")).isLoading;
    final corridors = ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG"));

    ref.listen(sendChargeProvider, (_, next) {
      if (next is AsyncData) {
        context.pushNamed(SendMoneyFinalView.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return Scaffold(
      appBar: innerAppBar(title: 'Send Money'),
      body: Form(
        key: _formKey,
        child: corridors.maybeWhen(
          data: (data) {
            return ScaffoldBody(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.0.height,
                    Text(
                      'How much do you want to send?',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    16.0.height,
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.kWhiteColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionHeader(
                                text: 'From',
                                fontSize: 14,
                              ),
                              8.0.height,

                              // FROM Button
                              InkWell(
                                onTap: () {
                                  AppBottomSheet.showBottomSheet(
                                    context,
                                    widget: SendCurrencySheet(
                                      title: 'From',
                                      location: SendRoute.from,
                                      corridors: data,
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    const CircleAvatar(),
                                    8.0.width,
                                    Text(
                                      'TBS',
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                    8.0.width,
                                    SvgPicture.asset(AppImages.arrowDown),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Transform.rotate(
                            angle: math.pi / 2,
                            child: const SwapIconWidget(
                              padding: 8,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SectionHeader(
                                text: 'To',
                                fontSize: 14,
                              ),
                              8.0.height,

                              // TO Button
                              InkWell(
                                onTap: () {
                                  AppBottomSheet.showBottomSheet(
                                    context,
                                    widget: SendCurrencySheet(
                                      title: 'To',
                                      location: SendRoute.to,
                                      corridors: data,
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    const CircleAvatar(),
                                    8.0.width,
                                    Text(
                                      'TBS',
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                    8.0.width,
                                    SvgPicture.asset(AppImages.arrowDown),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    16.0.height,

                    // Source Amount
                    AmountInput(
                      header: 'You Send',
                      controller: _sourceAmount,
                      currency: 'TBS',
                    ),
                    8.0.height,
                    BalanceWidget(
                      balance: fromBalance.value.balance!
                          .amountWithCurrency(fromBalance.value.currencySymbol ?? ""),
                      fontSize: 16,
                    ),

                    /// Receipient Receives
                    16.0.height,

                    // Destination Amount
                    AmountInput(
                      readOnly: true,
                      header: 'Recipient Receives',
                      color: AppColors.kWhiteColor,
                      controller: _destinationAmount,
                      currency: 'TBS',
                    ),

                    24.0.height,
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.kWhiteColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const RatesCard(
                            image: AppImages.compareArrows,
                            text: '1 USD = 1500 NGN',
                            description: 'Rate',
                          ),
                          16.0.height,
                          RatesCard(
                            image: AppImages.loyalty,
                            text: '0.0 NGN',
                            description: 'Fees',
                            onTapped: () {},
                          ),
                          16.0.height,
                          const RatesCard(
                            image: AppImages.addAlt,
                            text: '1,500,000 NGN',
                            description: 'Total Amount',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          orElse: () => const SpinKitRing(
            color: AppColors.kPrimaryColor,
            size: 100,
            lineWidth: 3,
          ),
          error: (error, stackTrace) => kDebugMode
              ? Text(error.toString())
              : const SpinKitRing(
                  color: AppColors.kPrimaryColor,
                  size: 100,
                  lineWidth: 3,
                ),
        ),
      ),
      bottomNavigationBar: corridorsLoading
          ? null
          : BottomNavBarWidget(
              children: [
                MainButton(
                  isLoading: sendChargeLoading,
                  text: 'Next',
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   ref.read(sendChargeProvider.notifier).sendChargeMethod(
                    //         SendChargeReq(
                    //           destinationCountryCode:
                    //               desCurrencyValue.value.countryCode,
                    //           destinationCurrency:
                    //               desCurrencyValue.value.currencyCode,
                    //           sourceCurrency: srcCurrencyValue.value.currencyCode,
                    //           amount: 10,
                    //         ),
                    //       );
                    // }
                    context.pushNamed(SendMoneyToWhoView.path);
                  },
                )
                    .animate()
                    .fadeIn(begin: 0, delay: 1000.ms)
                    // .then(delay: 200.ms)
                    .slideY(begin: .1, end: 0)
              ],
            ),
    );
  }
}
