// import 'dart:math' as math;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
// import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
// import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
// import 'package:remittance_mobile/view/features/home/widgets/balance_widget.dart';
// import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
// import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
// import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
// import 'package:remittance_mobile/view/features/services/vm/send_charge_vm.dart';
// import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
// import 'package:remittance_mobile/view/features/services/widgets/rates_card.dart';
// import 'package:remittance_mobile/view/features/services/widgets/swap_icon_card.dart';
// import 'package:remittance_mobile/view/theme/app_colors.dart';
// import 'package:remittance_mobile/view/utils/alert_dialog.dart';
// import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
// import 'package:remittance_mobile/view/utils/app_images.dart';
// import 'package:remittance_mobile/view/utils/buttons.dart';
// import 'package:remittance_mobile/view/utils/extensions.dart';
// import 'package:remittance_mobile/view/utils/snackbar.dart';
// import 'package:remittance_mobile/view/widgets/amount_input.dart';
// import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
// import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
// import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
// import 'package:remittance_mobile/view/widgets/section_header.dart';
// import 'dart:developer';

// import 'package:remittance_mobile/view/features/home/account-view/create_account_sheet.dart';
// import 'package:remittance_mobile/view/utils/input_fields.dart';

// ValueNotifier<String> sourceAmount = ValueNotifier('');
// ValueNotifier<CorridorsResponse> sourceCorridor = ValueNotifier(CorridorsResponse());
// ValueNotifier<DestinationCountry> sourceCurrency = ValueNotifier(DestinationCountry());
// ValueNotifier<DestinationCountry> destinationCorridor = ValueNotifier(DestinationCountry());
// ValueNotifier<DestinationCountry> destinationCurrency = ValueNotifier(DestinationCountry());
// ValueNotifier<SendChargeResponse> feeResponse = ValueNotifier(SendChargeResponse());
// ValueNotifier<bool> showCharge = ValueNotifier(false);

// class SendMoneyHowMuchView extends ConsumerStatefulWidget {
//   static String path = 'send-money-how-much';
//   const SendMoneyHowMuchView({super.key});

//   @override
//   ConsumerState<SendMoneyHowMuchView> createState() => _SendMoneyInitialViewState();
// }

// class _SendMoneyInitialViewState extends ConsumerState<SendMoneyHowMuchView> {
//   //final GlobalKey<State> _recipientTypeKey = GlobalKey();
//   final GlobalKey<FormState> _formKey = GlobalKey();

//   // final TextEditingController _sourceCurrency = TextEditingController();
//   // final TextEditingController _destinationCurrency = TextEditingController();
//   final TextEditingController _sourceAmount = TextEditingController();
//   final TextEditingController _destinationAmount = TextEditingController();

//   // Charge Values
//   num _rate = 0.0;
//   num _fee = 0.0;

//   // // Variable to show charge
//   // bool showCharge.value = false;

//   @override
//   void initState() {
//     super.initState();
//     _destinationAmount.text = '0.00';
//     _sourceAmount.text = '0';
//     _sourceAmount.addListener(() {
//       setState(() {
//         showCharge.value = false;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     // _sourceCurrency.dispose();
//     // _destinationCurrency.dispose();
//     _sourceAmount.dispose();
//     _destinationAmount.dispose();
//     super.dispose();
//   }

//   handleChargeReq() {
//     if (_sourceAmount.text.isNotEmpty && _sourceAmount.text != '.') {
//       ref.read(sendChargeProvider.notifier).sendChargeMethod(
//             SendChargeReq(
//               destinationCountryCode: destinationCorridor.value.code,
//               destinationCurrency: destinationCurrency.value.code,
//               sourceCurrency: sourceCurrency.value.code,
//               channel: "Bank",
//               amount: double.parse(_sourceAmount.text.replaceAll(',', '')),
//             ),
//           );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final sendChargeLoading = ref.watch(sendChargeProvider).isLoading;
//     final corridorsLoading =
//         ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG")).isLoading;
//     final corridors = ref.watch(getCorridorsProvider(fromBalance.value.countryCode ?? "NG"));

//     ref.listen(sendChargeProvider, (_, next) {
//       if (next is AsyncData) {
//         //context.pushNamed(SendMoneyFinalView.path);
//         _destinationAmount.text = next.value?.destinationAmount?.amountInt() ?? '0.00';
//         _rate = 1 / (next.value?.rate ?? 1.0);
//         _fee = next.value?.fee ?? 0.0;
//         feeResponse.value = next.value ?? SendChargeResponse();

//         setState(() {
//           showCharge.value = true;
//         });
//       }
//       if (next is AsyncError) {
//         setState(() {
//           showCharge.value = false;
//         });
//         SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
//       }
//     });

//     return Scaffold(
//       appBar: innerAppBar(
//         title: 'Send Money',
//         backOnPressed: () {
//           context.pop();

//           // Set all the Value Notifiers to Default
//           setState(() {
//             sourceCorridor.value = CorridorsResponse();
//             sourceCurrency.value = DestinationCountry();
//             destinationCorridor.value = DestinationCountry();
//             destinationCurrency.value = DestinationCountry();
//             showCharge.value = false;
//           });
//         },
//       ),
//       body: Form(
//         key: _formKey,
//         child: corridors.maybeWhen(
//           data: (data) {
//             if (data.isEmpty) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   32.0.height,
//                   Center(
//                     child: Text(
//                       'No Corridor Available for ${fromBalance.value.countryCode}',
//                       style: Theme.of(context).textTheme.displayMedium,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               // Set Default values
//               setState(() {
//                 sourceCorridor.value = data.first;
//                 destinationCorridor.value = data.first.destinationCountries!.first;
//                 sourceCurrency.value = sourceCorridor.value.sourceCurrencies!.first;
//                 destinationCurrency.value = destinationCorridor.value.destinationCurrencies!.first;
//               });
//               return AbsorbPointer(
//                 absorbing: sendChargeLoading || corridorsLoading,
//                 child: ScaffoldBody(
//                   body: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         15.0.height,
//                         Text(
//                           'How much do you want to send?',
//                           style: Theme.of(context).textTheme.displayMedium,
//                           textAlign: TextAlign.center,
//                         ),
//                         16.0.height,
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: AppColors.kWhiteColor,
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SectionHeader(
//                                     text: 'From',
//                                     fontSize: 14,
//                                   ),
//                                   8.0.height,

//                                   // FROM Button
//                                   InkWell(
//                                     onTap: () async {
//                                       CorridorsResponse? result =
//                                           await AppBottomSheet.showBottomSheet(
//                                         context,
//                                         widget: SendCurrencySheet(
//                                           location: SendRoute.from,
//                                           corridors: data,
//                                           destination:
//                                               sourceCorridor.value.destinationCountries ?? [],
//                                         ),
//                                       );
//                                       setState(() {
//                                         sourceCorridor.value = result!;
//                                       });
//                                     },
//                                     child: Row(
//                                       children: [
//                                         CircleAvatar(
//                                           backgroundImage:
//                                               NetworkImage(sourceCorridor.value.flag?.png ?? ""),
//                                         ),
//                                         8.0.width,
//                                         Text(
//                                           sourceCorridor.value.code ?? "TBS",
//                                           style: Theme.of(context).textTheme.displaySmall,
//                                         ),
//                                         8.0.width,
//                                         SvgPicture.asset(AppImages.arrowDown),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Transform.rotate(
//                                 angle: math.pi / 2,
//                                 child: const SwapIconWidget(
//                                   padding: 8,
//                                 ),
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const SectionHeader(
//                                     text: 'To',
//                                     fontSize: 14,
//                                   ),
//                                   8.0.height,

//                                   // TO Button
//                                   InkWell(
//                                     onTap: () async {
//                                       if (sourceCorridor.value.destinationCountries == null) {
//                                         ShowAlertDialog.showAlertDialog(
//                                           context,
//                                           title: 'Error!',
//                                           content: 'Select the FROM Country',
//                                           defaultActionText: 'Ok',
//                                         );
//                                       } else {
//                                         DestinationCountry? result =
//                                             await AppBottomSheet.showBottomSheet(
//                                           context,
//                                           widget: SendCurrencySheet(
//                                             location: SendRoute.to,
//                                             corridors: data,
//                                             destination:
//                                                 sourceCorridor.value.destinationCountries ?? [],
//                                           ),
//                                         );

//                                         setState(() {
//                                           destinationCorridor.value = result!;
//                                         });
//                                       }
//                                     },
//                                     child: Row(
//                                       children: [
//                                         CircleAvatar(
//                                           backgroundImage: NetworkImage(
//                                               destinationCorridor.value.flag?.png ?? ""),
//                                         ),
//                                         8.0.width,
//                                         Text(
//                                           destinationCorridor.value.code ?? "TBS",
//                                           style: Theme.of(context).textTheme.displaySmall,
//                                         ),
//                                         8.0.width,
//                                         SvgPicture.asset(AppImages.arrowDown),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         16.0.height,

//                         // Source Amount
//                         AmountInput(
//                           header: 'You Send',
//                           fontSize: 36.sp,
//                           controller: _sourceAmount,
//                           currency: sourceCurrency.value.code,
//                         ),
//                         8.0.height,

//                         // Balance
//                         BalanceWidget(
//                           balance: fromBalance.value.balance!
//                               .amountWithCurrency(fromBalance.value.currencySymbol ?? ""),
//                           fontSize: 16,
//                         ),

//                         /// Receipient Receives
//                         16.0.height,
//                         Visibility(
//                           visible: !showCharge.value,
//                           child: Column(
//                             children: [
//                               16.0.height,
//                               MainButton(
//                                 isLoading: sendChargeLoading,
//                                 text: 'Calculate',
//                                 onPressed: () {
//                                   handleChargeReq();
//                                 },
//                               )
//                                   .animate()
//                                   .fadeIn(begin: 0, delay: 1000.ms)
//                                   // .then(delay: 200.ms)
//                                   .slideY(begin: .1, end: 0),
//                             ],
//                           ),
//                         ),

//                         Visibility(
//                           visible: showCharge.value,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Destination Amount
//                               AmountInput(
//                                 readOnly: true,
//                                 header: 'Recipient Receives',
//                                 color: AppColors.kWhiteColor,
//                                 currencyColor: AppColors.kGrey200,
//                                 controller: _destinationAmount,
//                                 currency: destinationCurrency.value.code,
//                                 fontSize: 30.sp,
//                               ),

//                               24.0.height,
//                               Container(
//                                 padding: const EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.kWhiteColor,
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     RatesCard(
//                                       image: AppImages.compareArrows,
//                                       text:
//                                           '1 ${destinationCurrency.value.code} = ${_rate.formatDecimal()} ${sourceCurrency.value.code}',
//                                       description: 'Rate',
//                                     ),
//                                     16.0.height,
//                                     RatesCard(
//                                       image: AppImages.loyalty,
//                                       text: '${_fee.formatDecimal()} ${sourceCurrency.value.code}',
//                                       description: 'Fees',
//                                       onTapped: () {},
//                                     ),
//                                     16.0.height,
//                                     if (_sourceAmount.text.isNotEmpty &&
//                                         _sourceAmount.text != '.') ...[
//                                       RatesCard(
//                                         image: AppImages.addAlt,
//                                         text:
//                                             '${(double.parse(_sourceAmount.text.replaceAll(',', '')) + _fee).formatDecimal()} ${sourceCurrency.value.code}',
//                                         description: 'Total Amount',
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//           },
//           orElse: () => const SpinKitRing(
//             color: AppColors.kPrimaryColor,
//             size: 100,
//             lineWidth: 3,
//           ),
//           error: (error, stackTrace) => kDebugMode
//               ? Text(error.toString())
//               : const SpinKitRing(
//                   color: AppColors.kPrimaryColor,
//                   size: 100,
//                   lineWidth: 3,
//                 ),
//         ),
//       ),
//       bottomNavigationBar: corridorsLoading || !showCharge.value
//           ? null
//           : BottomNavBarWidget(
//               children: [
//                 MainButton(
//                   isLoading: sendChargeLoading,
//                   text: 'Next',
//                   onPressed: () {
//                     if (_sourceAmount.text.isNotEmpty && _sourceAmount.text != '.') {
//                       setState(() {
//                         sourceAmount.value = _sourceAmount.text;
//                       });
//                       context.pushNamed(SendMoneyToWhoView.path);
//                     }
//                   },
//                 )
//                     .animate()
//                     .fadeIn(begin: 0, delay: 1000.ms)
//                     // .then(delay: 200.ms)
//                     .slideY(begin: .1, end: 0)
//               ],
//             ),
//     );
//   }
// }

// class SendCurrencySheet extends StatefulWidget {
//   final List<CorridorsResponse> corridors;
//   final SendRoute location;
//   final List<DestinationCountry> destination;
//   const SendCurrencySheet({
//     super.key,
//     required this.corridors,
//     required this.location,
//     required this.destination,
//   });

//   @override
//   State<SendCurrencySheet> createState() => _SendCurrencySheetState();
// }

// class _SendCurrencySheetState extends State<SendCurrencySheet> {
//   /// Controller to Search
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   void _onSearchChanged() {
//     setState(() {
//       _searchQuery = _searchController.text.toLowerCase();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchController.removeListener(_onSearchChanged);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredDataFROM = widget.corridors
//         .where((country) => country.name!.toLowerCase().contains(_searchQuery))
//         .toList();
//     final filteredDataTO = widget.destination
//         .where((country) => country.name!.toLowerCase().contains(_searchQuery))
//         .toList();
//     return SizedBox(
//       height: 500,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SectionHeader(
//             text: switch (widget.location) {
//               SendRoute.from => "From",
//               SendRoute.to => "To",
//             },
//           ),
//           16.0.height,
//           TextInput(
//             controller: _searchController,
//             hint: "Search...",
//             inputType: TextInputType.text,
//             validator: null,
//             animate: false,
//           ),
//           24.0.height,
//           Expanded(
//             child: SingleChildScrollView(
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   switch (widget.location) {
//                     case SendRoute.from:
//                       var value = filteredDataFROM[index];
//                       return SendCurrencyItem(
//                         route: SendRoute.from,
//                         image: value.flag!.png,
//                         name: value.name,
//                         countryCode: value.code,
//                         currencyData: value,
//                       );
//                     case SendRoute.to:
//                       var value = filteredDataTO[index];
//                       return SendCurrencyItem(
//                         route: SendRoute.to,
//                         image: value.flag!.png,
//                         name: value.name,
//                         countryCode: value.code,
//                         destinationData: value,
//                       );
//                   }
//                 },
//                 separatorBuilder: (context, index) => 24.0.height,
//                 itemCount: switch (widget.location) {
//                   SendRoute.from => filteredDataFROM.length,
//                   SendRoute.to => filteredDataTO.length
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SendCurrencyItem extends StatefulWidget {
//   final String? name, image, countryCode;
//   final CorridorsResponse? currencyData;
//   final DestinationCountry? destinationData;
//   final Function()? onPressed;
//   final SendRoute route;
//   const SendCurrencyItem({
//     super.key,
//     this.name,
//     this.image,
//     this.onPressed,
//     this.currencyData,
//     this.countryCode,
//     this.destinationData,
//     required this.route,
//   });

//   @override
//   State<SendCurrencyItem> createState() => _SendCurrencyItemState();
// }

// class _SendCurrencyItemState extends State<SendCurrencyItem> {
//   @override
//   Widget build(BuildContext context) {
//     switch (widget.route) {
//       case SendRoute.from:
//         return InkWell(
//           onTap: () {
//             if (widget.currencyData!.sourceCurrencies!.length < 2) {
//               context.pop(widget.currencyData);
//               sourceCurrency.value = widget.currencyData!.sourceCurrencies!.first;
//               setState(() {});
//             } else {
//               context.pop(widget.currencyData);
//               setState(() {});
//               // sourceCorridor.value = widget.currencyData!;
//               // setState(() {});
//               AppBottomSheet.showBottomSheet(
//                 context,
//                 widget: MultipleCurrencySheet(
//                   name: widget.name ?? '',
//                   list: widget.currencyData!.sourceCurrencies!,
//                 ),
//               );
//               log(sourceCorridor.value.code!);
//             }
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 maxRadius: 28,
//                 backgroundImage: NetworkImage(widget.image ?? ""),
//               ),
//               16.0.width,
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     widget.name ?? '',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: AppColors.kGrey800,
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   5.0.height,
//                   Row(
//                     children: [
//                       SizedBox(
//                         height: 20,
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             var value = widget.currencyData!.sourceCurrencies![index];
//                             return Text(
//                               value.code ?? '',
//                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                             );
//                           },
//                           separatorBuilder: (context, index) => Text(
//                             ', ',
//                             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                           itemCount: widget.currencyData!.sourceCurrencies!.length < 3
//                               ? widget.currencyData!.sourceCurrencies!.length
//                               : 3,
//                         ),
//                       ),
//                       if (widget.currencyData!.sourceCurrencies!.length > 3) ...[
//                         Text(' + ${widget.currencyData!.sourceCurrencies!.length - 3} more'),
//                       ]
//                     ],
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               widget.currencyData!.sourceCurrencies!.length < 2
//                   ? const SizedBox.shrink()
//                   : SvgPicture.asset(AppImages.arrowRight)
//             ],
//           ),
//         );
//       case SendRoute.to:
//         return InkWell(
//           onTap: () {
//             // Check if destinationCurrencies is null or empty
//             if (widget.destinationData?.destinationCurrencies == null ||
//                 widget.destinationData!.destinationCurrencies!.isEmpty) {
//               return;
//             }

//             if (widget.destinationData!.destinationCurrencies!.length < 2) {
//               if (widget.destinationData!.destinationCurrencies!.isNotEmpty) {
//                 setState(() {
//                   destinationCurrency.value == widget.destinationData!.destinationCurrencies!.first;
//                 });
//               }
//               log('TO: ${destinationCurrency.value.code}');

//               context.pop();
//             } else {
//               AppBottomSheet.showBottomSheet(
//                 context,
//                 widget: MultipleCurrencySheet(
//                   name: widget.name ?? '',
//                   list: widget.destinationData!.destinationCurrencies!,
//                 ),
//               );
//             }
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 maxRadius: 28,
//                 backgroundImage: NetworkImage(widget.image ?? ""),
//               ),
//               16.0.width,
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     widget.name ?? '',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: AppColors.kGrey800,
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   5.0.height,
//                   Row(
//                     children: [
//                       SizedBox(
//                         height: 20,
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             var value = widget.destinationData!.destinationCurrencies![index];
//                             return Text(
//                               value.code ?? '',
//                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                             );
//                           },
//                           separatorBuilder: (context, index) => Text(
//                             ', ',
//                             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                           itemCount: widget.destinationData!.destinationCurrencies!.length < 3
//                               ? widget.destinationData!.destinationCurrencies!.length
//                               : 3,
//                         ),
//                       ),
//                       if (widget.destinationData!.destinationCurrencies!.length > 3) ...[
//                         Text(
//                             ' + ${widget.destinationData!.destinationCurrencies!.length - 3} more'),
//                       ]
//                     ],
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               widget.destinationData!.destinationCurrencies!.length < 2
//                   ? const SizedBox.shrink()
//                   : SvgPicture.asset(AppImages.arrowRight)
//             ],
//           ),
//         );
//     }
//   }
// }

// class MultipleCurrencySheet extends StatefulWidget {
//   const MultipleCurrencySheet({
//     super.key,
//     required this.name,
//     required this.list,
//   });

//   final String name;
//   final List<DestinationCountry> list;

//   @override
//   State<MultipleCurrencySheet> createState() => _MultipleCurrencySheetState();
// }

// class _MultipleCurrencySheetState extends State<MultipleCurrencySheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InkWell(
//           onTap: () {
//             context.pop();
//           },
//           child: Row(
//             children: [
//               SvgPicture.asset(AppImages.backArrow),
//               16.0.width,
//               Text(
//                 widget.name,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.kGrey700,
//                     ),
//               )
//             ],
//           ),
//         ),
//         24.0.height,
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             var newList = widget.list[index];
//             return InkWell(
//               onTap: () {
//                 sourceCurrency.value = newList;
//                 setState(() {});
//                 log(sourceCurrency.value.code ?? "");
//                 context.pop(sourceCurrency);
//               },
//               child: CurrencyItem(
//                 name: newList.name,
//                 code: "${newList.code} Account domiciled in ${widget.name}",
//                 image: newList.flag == null
//                     ? "https://media.istockphoto.com/id/583715254/photo/national-flags-of-the-different-countries-of-the-world.jpg?b=1&s=612x612&w=0&k=20&c=gdvXYVsV6R6K0aCip-Q4i_R5qCfLsg61-qAXtlhUzpI="
//                     : newList.flag!.png,
//               ),
//             );
//           },
//           separatorBuilder: (context, index) => 24.0.height,
//           itemCount: widget.list.length,
//         ),
//       ],
//     );
//   }
// }
