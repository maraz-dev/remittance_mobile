import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
import 'package:remittance_mobile/view/features/home/widgets/balance_widget.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/send_charge_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/rates_card.dart';
import 'package:remittance_mobile/view/features/services/widgets/send_currency_widgets.dart';
import 'package:remittance_mobile/view/features/services/widgets/swap_icon_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/alert_dialog.dart';
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

ValueNotifier<String> sourceAmount = ValueNotifier('');
ValueNotifier<CorridorsResponse> sourceCorridor = ValueNotifier(CorridorsResponse());
ValueNotifier<DestinationCountry> sourceCurrency = ValueNotifier(DestinationCountry());
ValueNotifier<DestinationCountry> destinationCorridor = ValueNotifier(DestinationCountry());
ValueNotifier<DestinationCurrency> destinationCurrency = ValueNotifier(DestinationCurrency());
ValueNotifier<SendChargeResponse> feeResponse = ValueNotifier(SendChargeResponse());
ValueNotifier<bool> showCharge = ValueNotifier(false);

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

  // Charge Values
  num _rate = 0.0;
  num _fee = 0.0;

  // // Variable to show charge
  // bool showCharge.value = false;

  @override
  void initState() {
    super.initState();
    _destinationAmount.text = '0.00';
    _sourceAmount.text = '0.00';
    _sourceAmount.addListener(() {
      setState(() {
        showCharge.value = false;
      });
    });
  }

  @override
  void dispose() {
    // _sourceCurrency.dispose();
    // _destinationCurrency.dispose();
    _sourceAmount.dispose();
    _destinationAmount.dispose();
    super.dispose();
  }

  handleChargeReq() {
    ref.read(sendChargeProvider.notifier).sendChargeMethod(
          SendChargeReq(
            destinationCountryCode: destinationCorridor.value.code,
            destinationCurrency: destinationCurrency.value.code,
            sourceCurrency: sourceCurrency.value.code,
            channel: "Bank",
            amount: double.parse(_sourceAmount.text.replaceAll(',', '')),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final sendChargeLoading = ref.watch(sendChargeProvider).isLoading;
    final corridorsLoading =
        ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG")).isLoading;
    final corridors = ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG"));

    ref.listen(sendChargeProvider, (_, next) {
      if (next is AsyncData) {
        //context.pushNamed(SendMoneyFinalView.path);
        _destinationAmount.text = next.value?.destinationAmount?.amountInt() ?? '0.00';
        _rate = 1 / (next.value?.rate ?? 1.0);
        _fee = next.value?.fee ?? 0.0;
        feeResponse.value = next.value ?? SendChargeResponse();

        setState(() {
          showCharge.value = true;
        });
      }
      if (next is AsyncError) {
        setState(() {
          showCharge.value = false;
        });
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return Scaffold(
      appBar: innerAppBar(
        title: 'Send Money',
        backOnPressed: () {
          context.pop();

          // Set all the Value Notifiers to Default
          setState(() {
            sourceCorridor.value = CorridorsResponse();
            sourceCurrency.value = DestinationCountry();
            destinationCorridor.value = DestinationCountry();
            destinationCurrency.value = DestinationCurrency();
            showCharge.value = false;
          });
        },
      ),
      body: Form(
        key: _formKey,
        child: corridors.maybeWhen(
          data: (data) {
            return AbsorbPointer(
              absorbing: sendChargeLoading || corridorsLoading,
              child: ScaffoldBody(
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
                                  onTap: () async {
                                    CorridorsResponse? result =
                                        await AppBottomSheet.showBottomSheet(
                                      context,
                                      widget: SendCurrencySheet(
                                        location: SendRoute.from,
                                        corridors: data,
                                        destination:
                                            sourceCorridor.value.destinationCountries ?? [],
                                      ),
                                    );
                                    setState(() {
                                      sourceCorridor.value = result!;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(sourceCorridor.value.flag?.png ?? ""),
                                      ),
                                      8.0.width,
                                      Text(
                                        sourceCorridor.value.code ?? "TBS",
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
                                  onTap: () async {
                                    if (sourceCorridor.value.destinationCountries == null) {
                                      ShowAlertDialog.showAlertDialog(
                                        context,
                                        title: 'Error!',
                                        content: 'Select the FROM Country',
                                        defaultActionText: 'Ok',
                                      );
                                    } else {
                                      DestinationCountry? result =
                                          await AppBottomSheet.showBottomSheet(
                                        context,
                                        widget: SendCurrencySheet(
                                          location: SendRoute.to,
                                          corridors: data,
                                          destination:
                                              sourceCorridor.value.destinationCountries ?? [],
                                        ),
                                      );

                                      setState(() {
                                        destinationCorridor.value = result!;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(destinationCorridor.value.flag?.png ?? ""),
                                      ),
                                      8.0.width,
                                      Text(
                                        destinationCorridor.value.code ?? "TBS",
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
                        fontSize: 36.sp,
                        controller: _sourceAmount,
                        currency: sourceCurrency.value.code,
                      ),
                      8.0.height,

                      // Balance
                      BalanceWidget(
                        balance: fromBalance.value.balance!
                            .amountWithCurrency(fromBalance.value.currencySymbol ?? ""),
                        fontSize: 16,
                      ),

                      /// Receipient Receives
                      16.0.height,
                      Visibility(
                        visible: !showCharge.value,
                        child: Column(
                          children: [
                            16.0.height,
                            MainButton(
                              isLoading: sendChargeLoading,
                              text: 'Calculate',
                              onPressed: () {
                                handleChargeReq();
                              },
                            )
                                .animate()
                                .fadeIn(begin: 0, delay: 1000.ms)
                                // .then(delay: 200.ms)
                                .slideY(begin: .1, end: 0),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: showCharge.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Destination Amount
                            AmountInput(
                              readOnly: true,
                              header: 'Recipient Receives',
                              color: AppColors.kWhiteColor,
                              controller: _destinationAmount,
                              currency: destinationCurrency.value.code,
                              fontSize: 30.sp,
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
                                  RatesCard(
                                    image: AppImages.compareArrows,
                                    text:
                                        '1 ${destinationCurrency.value.code} = ${_rate.formatDecimal()} ${sourceCurrency.value.code}',
                                    description: 'Rate',
                                  ),
                                  16.0.height,
                                  RatesCard(
                                    image: AppImages.loyalty,
                                    text: '${_fee.formatDecimal()} ${sourceCurrency.value.code}',
                                    description: 'Fees',
                                    onTapped: () {},
                                  ),
                                  16.0.height,
                                  RatesCard(
                                    image: AppImages.addAlt,
                                    text:
                                        '${(double.parse(_sourceAmount.text.replaceAll(',', '')) + _fee).formatDecimal()} ${sourceCurrency.value.code}',
                                    description: 'Total Amount',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      bottomNavigationBar: corridorsLoading || !showCharge.value
          ? null
          : BottomNavBarWidget(
              children: [
                MainButton(
                  isLoading: sendChargeLoading,
                  text: 'Next',
                  onPressed: () {
                    setState(() {
                      sourceAmount.value = _sourceAmount.text;
                    });
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
