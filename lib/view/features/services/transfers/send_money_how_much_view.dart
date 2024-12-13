import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
import 'package:remittance_mobile/view/features/home/widgets/balance_widget.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_state.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/send_charge_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/from_currency_widgets.dart';
import 'package:remittance_mobile/view/features/services/widgets/how_much_buttons.dart';
import 'package:remittance_mobile/view/features/services/widgets/rates_card.dart';
import 'package:remittance_mobile/view/features/services/widgets/swap_icon_card.dart';
import 'package:remittance_mobile/view/features/services/widgets/to_currency_widgets.dart';
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

ValueNotifier<String> sourceAmount = ValueNotifier('');
ValueNotifier<SendChargeResponse> feeResponse = ValueNotifier(SendChargeResponse());
ValueNotifier<bool> showCharge = ValueNotifier(false);

class SendMoneyHowMuchView extends ConsumerStatefulWidget {
  static String path = 'send-money-how-much';
  const SendMoneyHowMuchView({super.key});

  @override
  ConsumerState<SendMoneyHowMuchView> createState() => _SendMoneyInitialViewState();
}

class _SendMoneyInitialViewState extends ConsumerState<SendMoneyHowMuchView> {
  //final GlobalKey<State> _recipientTypeKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _sourceAmount = TextEditingController();
  final TextEditingController _destinationAmount = TextEditingController();

  // Charge Values
  num _rate = 0.0;
  num _fee = 0.0;
  FeesPerChannel _feesPerChannel = FeesPerChannel();
  //num _destinationfee = 0.0;

  // // Variable to show charge
  // bool showCharge.value = false;

  @override
  void initState() {
    super.initState();
    _destinationAmount.text = '0.00';
    _sourceAmount.text = '0';
    _sourceAmount.addListener(() {
      setState(() {
        showCharge.value = false;
      });
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   handleChargeReq(ref.watch(selectedTransferStateProvider));
      // });
    });
  }

  @override
  void dispose() {
    _sourceAmount.dispose();
    _destinationAmount.dispose();
    super.dispose();
  }

  handleChargeReq(TransferState transfer) {
    if (_sourceAmount.text.isNotEmpty && _sourceAmount.text != '.') {
      ref.read(sendChargeProvider.notifier).sendChargeMethod(
            SendChargeReq(
              destinationCountryCode: transfer.destinationCountry?.code,
              destinationCurrency: transfer.destinationCurrency?.code,
              sourceCurrency: transfer.sourceCurrency?.code,
              amount: double.parse(_sourceAmount.text.replaceAll(',', '')),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sendChargeLoading = ref.watch(sendChargeProvider).isLoading;
    final corridorsLoading =
        ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG")).isLoading;
    final corridors = ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG"));
    final transferState = ref.watch(selectedTransferStateProvider);

    // if (showCharge.value == false) {
    //   handleChargeReq(transferState);
    // }

    ref.listen(sendChargeProvider, (_, next) {
      if (next is AsyncData<SendChargeResponse>) {
        _destinationAmount.text = next.value.destinationAmount.formatDecimal();
        _rate = (next.value.rate ?? 1.0);
        //_destinationfee = next.value.feeInDestinationCurrency ?? 0.0;
        _fee = next.value.feeInSourceCurrency ?? 0.0;
        feeResponse.value = next.value;
        _feesPerChannel = next.value.feesPerChannel ?? FeesPerChannel();

        setState(() {
          showCharge.value = true;
        });
      }
      if (next is AsyncError) {
        setState(() {
          showCharge.value = false;
          _destinationAmount.text = "0.00";
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
            showCharge.value = false;
          });
        },
      ),
      body: Form(
        key: _formKey,
        child: corridors.maybeWhen(
          data: (data) {
            if (data.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  32.0.height,
                  Center(
                    child: Text(
                      'No Corridor Available for ${fromBalance.value.countryCode}',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            } else {
              // Set Default values
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
                                  FromButton(
                                    onPressed: () {
                                      AppBottomSheet.showBottomSheet(
                                        context,
                                        widget: const FROMCountrySheet(),
                                      );
                                    },
                                    image: transferState.sourceCurrency?.flag?.png ?? "",
                                    code: transferState.sourceCountry?.code ?? "NG",
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
                                  ToButton(
                                    onPressed: () {
                                      AppBottomSheet.showBottomSheet(
                                        context,
                                        widget: const TOCountrySheet(),
                                      );
                                    },
                                    image: transferState.destinationCurrency?.flag?.png ?? "",
                                    code: transferState.destinationCountry?.code ?? "",
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
                          currency: transferState.sourceCurrency?.code,
                          onFieldSubmitted: (value) {
                            handleChargeReq(transferState);
                          },
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
                                  handleChargeReq(transferState);
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: AmountInput(
                                      readOnly: true,
                                      header: 'Recipient Receives',
                                      color: AppColors.kWhiteColor,
                                      currencyColor: AppColors.kGrey200,
                                      controller: _destinationAmount,
                                      currency: transferState.destinationCurrency?.code,
                                      fontSize: 30.sp,
                                    ),
                                  ),
                                  if (sendChargeLoading) ...[
                                    15.0.width,
                                    Column(
                                      children: [
                                        20.0.height,
                                        const SpinKitFadingCircle(
                                          color: AppColors.kPrimaryColor,
                                          size: 35,
                                        ),
                                      ],
                                    )
                                  ]
                                ],
                              ),

                              24.0.height,
                              sendChargeLoading
                                  ? SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 120,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    )
                                  : Container(
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
                                                '1 ${transferState.sourceCurrency?.code} = ${_rate.formatDecimal()} ${transferState.destinationCurrency?.code}',
                                            description: 'Rate',
                                          ),
                                          16.0.height,
                                          RatesCard(
                                            image: AppImages.loyalty,
                                            description: 'Fees',
                                            onTapped: () {
                                              AppBottomSheet.showBottomSheet(
                                                context,
                                                widget: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SectionHeader(text: 'Fees'),
                                                    24.0.height,
                                                    if (_feesPerChannel.bank != null) ...[
                                                      FeeItem(
                                                        channel: 'Bank',
                                                        fee:
                                                            '${_feesPerChannel.bank?.feeInSourceCurrency.formatDecimal()} ${transferState.sourceCurrency?.code}',
                                                      ),
                                                      24.0.height,
                                                    ],
                                                    if (_feesPerChannel.mobileMoney != null) ...[
                                                      FeeItem(
                                                        channel: 'Mobile Money',
                                                        fee:
                                                            '${_feesPerChannel.mobileMoney?.feeInSourceCurrency.formatDecimal()} ${transferState.sourceCurrency?.code}',
                                                      ),
                                                      24.0.height,
                                                    ],
                                                    if (_feesPerChannel.cashPickup != null) ...[
                                                      FeeItem(
                                                        channel: 'Cash Pickup',
                                                        fee:
                                                            '${_feesPerChannel.cashPickup?.feeInSourceCurrency.formatDecimal()} ${transferState.sourceCurrency?.code}',
                                                      ),
                                                      24.0.height,
                                                    ],
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          16.0.height,
                                          if (_sourceAmount.text.isNotEmpty &&
                                              _sourceAmount.text != '.') ...[
                                            RatesCard(
                                              image: AppImages.addAlt,
                                              text:
                                                  '${(double.parse(_sourceAmount.text.replaceAll(',', '')) + _fee).formatDecimal()} ${transferState.sourceCurrency?.code}',
                                              description: 'Total Amount',
                                            ),
                                          ],
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
            }
          },
          orElse: () => const SpinKitRing(
            color: AppColors.kPrimaryColor,
            size: 100,
            lineWidth: 3,
          ),
          error: (error, stackTrace) => kDebugMode
              ? Center(
                  child: Text(error.toString()),
                )
              : const Center(
                  child: Text('An Error Occured'),
                ),
        ),
      ),
      bottomNavigationBar: corridorsLoading || sendChargeLoading || !showCharge.value
          ? null
          : BottomNavBarWidget(
              children: [
                MainButton(
                  isLoading: sendChargeLoading,
                  text: 'Next',
                  onPressed: () {
                    if (_sourceAmount.text.isNotEmpty && _sourceAmount.text != '.') {
                      setState(() {
                        sourceAmount.value = _sourceAmount.text;
                      });
                      context.pushNamed(SendMoneyToWhoView.path);
                    }
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

class FeeItem extends StatelessWidget {
  final String? channel, fee;
  const FeeItem({
    super.key,
    this.channel,
    this.fee,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(text: channel ?? ""),
          Text(fee ?? ""),
        ],
      ),
    );
  }
}
