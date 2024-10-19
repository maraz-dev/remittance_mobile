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
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/view/features/home/account-view/create_account_sheet.dart';
import 'package:remittance_mobile/view/features/home/widgets/balance_widget.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/send_charge_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/rates_card.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

ValueNotifier<AccountModel> srcCurrencyValue = ValueNotifier(AccountModel());
ValueNotifier<AccountCurrencies> desCurrencyValue =
    ValueNotifier(AccountCurrencies());

enum CurrencyLocation { from, to }

class SendMoneyHowMuchView extends ConsumerStatefulWidget {
  static String path = 'send-money-how-much';
  const SendMoneyHowMuchView({super.key});

  @override
  ConsumerState<SendMoneyHowMuchView> createState() =>
      _SendMoneyInitialViewState();
}

class _SendMoneyInitialViewState extends ConsumerState<SendMoneyHowMuchView> {
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
    final corridorsLoading = ref.watch(getCorridorsProvider).isLoading;
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
                              Row(
                                children: [
                                  const CircleAvatar(),
                                  8.0.width,
                                  Text(
                                    'US',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  8.0.width,
                                  InkWell(
                                    onTap: () async {
                                      AppBottomSheet.showBottomSheet(
                                        context,
                                        widget: SendCurrencySheet(
                                          title: 'From',
                                          location: CurrencyLocation.from,
                                          corridors: data,
                                        ),
                                      );
                                    },
                                    child:
                                        SvgPicture.asset(AppImages.arrowDown),
                                  ),
                                ],
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
                              Row(
                                children: [
                                  const CircleAvatar(),
                                  8.0.width,
                                  Text(
                                    'US',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  8.0.width,
                                  InkWell(
                                    onTap: () async {
                                      AppBottomSheet.showBottomSheet(
                                        context,
                                        widget: SendCurrencySheet(
                                          title: 'To',
                                          location: CurrencyLocation.to,
                                          corridors: data,
                                        ),
                                      );
                                    },
                                    child:
                                        SvgPicture.asset(AppImages.arrowDown),
                                  ),
                                ],
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
                    ),
                    8.0.height,
                    BalanceWidget(
                      balance: fromBalance.value.balance!.amountWithCurrency(
                          fromBalance.value.currencySymbol ?? ""),
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

class SendCurrencySheet extends StatefulWidget {
  final String title;
  final List<CorridorsResponse> corridors;
  final CurrencyLocation location;
  const SendCurrencySheet({
    super.key,
    required this.title,
    required this.corridors,
    required this.location,
  });

  @override
  State<SendCurrencySheet> createState() => _SendCurrencySheetState();
}

class _SendCurrencySheetState extends State<SendCurrencySheet> {
  /// Controller to Search
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = widget.corridors
        .where((country) =>
            country.name!.toLowerCase().contains(_searchQuery) ||
            country.code!.toLowerCase().contains(_searchQuery))
        .toList();
    return SizedBox(
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(text: widget.title),
          TextInput(
            controller: _searchController,
            hint: "Search...",
            inputType: TextInputType.text,
            validator: null,
            animate: false,
          ),
          24.0.height,
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var value = filteredData[index];
                  return CurrencyItem(
                    name: value.name,
                    code: value.code,
                    image: value.flag!.png,
                  );
                },
                separatorBuilder: (context, index) => 24.0.height,
                itemCount: filteredData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SwapIconWidget extends StatelessWidget {
  final double? padding;
  const SwapIconWidget({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.kGrey100,
        shape: BoxShape.circle,
      ),
      child: CardIcon(
        padding: padding,
        image: AppImages.swapAlt,
        bgColor: AppColors.kGrey700,
      ),
    );
  }
}
