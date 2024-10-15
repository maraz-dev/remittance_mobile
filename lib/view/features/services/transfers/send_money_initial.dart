import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/features/services/vm/send_charge_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/rates_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
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
ValueNotifier<AccountCurrencies> desCurrencyValue =
    ValueNotifier(AccountCurrencies());

class SendMoneyInitialView extends ConsumerStatefulWidget {
  static String path = 'send-money-initial-view';
  const SendMoneyInitialView({super.key});

  @override
  ConsumerState<SendMoneyInitialView> createState() =>
      _SendMoneyInitialViewState();
}

class _SendMoneyInitialViewState extends ConsumerState<SendMoneyInitialView> {
  /// Global Keys
  final GlobalKey<State> _sourceCountryKey = GlobalKey();
  final GlobalKey<State> _destinationCountryKey = GlobalKey();
  //final GlobalKey<State> _recipientTypeKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _sourceCurrency = TextEditingController();
  final TextEditingController _destinationCurrency = TextEditingController();
  final TextEditingController _sourceAmount = TextEditingController();
  final TextEditingController _destinationAmount = TextEditingController();

  @override
  void dispose() {
    _sourceCurrency.dispose();
    _destinationCurrency.dispose();
    _sourceAmount.dispose();

    _destinationAmount.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendChargeLoading = ref.watch(sendChargeProvider).isLoading;
    final corridors = ref.watch(getCorridorsProvider);

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
                    10.0.height,

                    /// You Send
                    const SectionHeader(text: 'You Send'),
                    8.0.height,
                    Row(
                      key: _sourceCountryKey,
                      children: [
                        const CircleAvatar(),
                        8.0.width,
                        Text(
                          'US',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        8.0.width,
                        InkWell(
                          onTap: () async {
                            final List<String> list = data
                                .map((element) => element.code ?? "")
                                .toList();
                            await platformSpecificDropdown(
                              key: _sourceCountryKey,
                              context: context,
                              items: list,
                              value: _sourceCurrency.text,
                              onChanged: (newValue) {
                                setState(() {
                                  _sourceCurrency.text = newValue ?? "";
                                  // srcCurrencyValue.value =
                                  //     userAccounts.value?.elementAt(
                                  //           userAccounts.value?.indexWhere(
                                  //                 (value) =>
                                  //                     value.currencyCode ==
                                  //                     _sourceCurrency.text,
                                  //               ) ??
                                  //               0,
                                  //         ) ??
                                  //         AccountModel();
                                });
                              },
                            );
                          },
                          child: SvgPicture.asset(AppImages.arrowDown),
                        ),
                      ],
                    ),
                    16.0.height,

                    // Source Amount
                    AmountInput(
                      controller: _sourceAmount,
                    ),

                    /// Receipient Receives
                    32.0.height,
                    const SectionHeader(text: 'Recipient Receives'),
                    8.0.height,
                    Row(
                      key: _destinationCountryKey,
                      children: [
                        const CircleAvatar(),
                        8.0.width,
                        Text(
                          'US',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        8.0.width,
                        InkWell(
                          onTap: () async {
                            final List<String> list = data
                                .map((element) => element.code ?? "")
                                .toList();
                            await platformSpecificDropdown(
                              key: _destinationCountryKey,
                              context: context,
                              items: list,
                              value: _destinationCurrency.text,
                              onChanged: (newValue) {
                                setState(() {
                                  _destinationCurrency.text = newValue ?? "";
                                });
                              },
                            );
                          },
                          child: SvgPicture.asset(AppImages.arrowDown),
                        ),
                      ],
                    ),
                    16.0.height,

                    // Destination Amount
                    AmountInput(
                      readOnly: true,
                      color: AppColors.kWhiteColor,
                      controller: _destinationAmount,
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
                            description: 'Rates',
                          ),
                          16.0.height,
                          const RatesCard(
                            image: AppImages.loyalty,
                            text: '0.0 NGN',
                            description: 'Discount Applied',
                          ),
                          16.0.height,
                          const RatesCard(
                            image: AppImages.addAlt,
                            text: '1,500,000 NGN',
                            description: 'Total Fees',
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
      bottomNavigationBar: BottomNavBarWidget(
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
              context.pushNamed(SendMoneyFinalView.path);
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
