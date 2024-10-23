import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/view/features/home/account-view/create_account_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class SendCurrencySheet extends StatefulWidget {
  final List<CorridorsResponse> corridors;
  final SendRoute location;
  final List<DestinationCountry> destination;
  const SendCurrencySheet({
    super.key,
    required this.corridors,
    required this.location,
    required this.destination,
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
    final filteredDataFROM = widget.corridors
        .where((country) => country.name!.toLowerCase().contains(_searchQuery))
        .toList();
    final filteredDataTO = widget.destination
        .where((country) => country.name!.toLowerCase().contains(_searchQuery))
        .toList();
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            text: switch (widget.location) {
              SendRoute.from => "From",
              SendRoute.to => "To",
            },
          ),
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
                  switch (widget.location) {
                    case SendRoute.from:
                      var value = filteredDataFROM[index];
                      return SendCurrencyItem(
                        route: SendRoute.from,
                        image: value.flag!.png,
                        name: value.name,
                        countryCode: value.code,
                        currencyData: value,
                      );
                    case SendRoute.to:
                      var value = filteredDataTO[index];
                      return SendCurrencyItem(
                        route: SendRoute.to,
                        image: value.flag!.png,
                        name: value.name,
                        countryCode: value.code,
                        destinationData: value,
                      );
                  }
                },
                separatorBuilder: (context, index) => 24.0.height,
                itemCount: filteredDataFROM.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SendCurrencyItem extends StatefulWidget {
  final String? name, image, countryCode;
  final CorridorsResponse? currencyData;
  final DestinationCountry? destinationData;
  final Function()? onPressed;
  final SendRoute route;
  const SendCurrencyItem({
    super.key,
    this.name,
    this.image,
    this.onPressed,
    this.currencyData,
    this.countryCode,
    this.destinationData,
    required this.route,
  });

  @override
  State<SendCurrencyItem> createState() => _SendCurrencyItemState();
}

class _SendCurrencyItemState extends State<SendCurrencyItem> {
  @override
  Widget build(BuildContext context) {
    switch (widget.route) {
      case SendRoute.from:
        return InkWell(
          onTap: () {
            if (widget.currencyData!.sourceCurrencies!.length < 2) {
              context.pop(widget.currencyData);
              sourceCurrency.value = widget.currencyData!.sourceCurrencies!.first;
              setState(() {});
            } else {
              AppBottomSheet.showBottomSheet(
                context,
                widget: MultipleCurrencySheet(
                  name: widget.name ?? '',
                  list: widget.currencyData!.sourceCurrencies!,
                ),
              );
              sourceCorridor.value = widget.currencyData!;
              setState(() {});
              log(sourceCorridor.value.code!);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                maxRadius: 28,
                backgroundImage: NetworkImage(widget.image ?? ""),
              ),
              16.0.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.name ?? 'United States',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.kGrey800,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  5.0.height,
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var value = widget.currencyData!.sourceCurrencies![index];
                            return Text(
                              value.code ?? 'USD',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            );
                          },
                          separatorBuilder: (context, index) => Text(
                            ', ',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          itemCount: widget.currencyData!.sourceCurrencies!.length < 3
                              ? widget.currencyData!.sourceCurrencies!.length
                              : 3,
                        ),
                      ),
                      if (widget.currencyData!.sourceCurrencies!.length > 3) ...[
                        Text(' + ${widget.currencyData!.sourceCurrencies!.length - 3} more'),
                      ]
                    ],
                  ),
                ],
              ),
              const Spacer(),
              widget.currencyData!.sourceCurrencies!.length < 2
                  ? const SizedBox.shrink()
                  : SvgPicture.asset(AppImages.arrowRight)
            ],
          ),
        );
      case SendRoute.to:
        return InkWell(
          onTap: () {
            if (widget.destinationData!.destinationCurrencies!.length < 2) {
              context.pop(widget.destinationData);
              destinationCurrency.value = widget.destinationData!.destinationCurrencies!.first;
              setState(() {});
            } else {
              AppBottomSheet.showBottomSheet(
                context,
                widget: MultipleCurrencySheet(
                  name: widget.name ?? '',
                  list: widget.currencyData!.sourceCurrencies!,
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                maxRadius: 28,
                backgroundImage: NetworkImage(widget.image ?? ""),
              ),
              16.0.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.name ?? 'United States',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.kGrey800,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  5.0.height,
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var value = widget.destinationData!.destinationCurrencies![index];
                            return Text(
                              value.code ?? 'USD',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            );
                          },
                          separatorBuilder: (context, index) => Text(
                            ', ',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          itemCount: widget.destinationData!.destinationCurrencies!.length < 3
                              ? widget.destinationData!.destinationCurrencies!.length
                              : 3,
                        ),
                      ),
                      if (widget.destinationData!.destinationCurrencies!.length > 3) ...[
                        Text(
                            ' + ${widget.destinationData!.destinationCurrencies!.length - 3} more'),
                      ]
                    ],
                  ),
                ],
              ),
              const Spacer(),
              widget.destinationData!.destinationCurrencies!.length < 2
                  ? const SizedBox.shrink()
                  : SvgPicture.asset(AppImages.arrowRight)
            ],
          ),
        );
    }
  }
}

class MultipleCurrencySheet extends StatefulWidget {
  const MultipleCurrencySheet({
    super.key,
    required this.name,
    required this.list,
  });

  final String name;
  final List<DestinationCountry> list;

  @override
  State<MultipleCurrencySheet> createState() => _MultipleCurrencySheetState();
}

class _MultipleCurrencySheetState extends State<MultipleCurrencySheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Row(
            children: [
              SvgPicture.asset(AppImages.backArrow),
              16.0.width,
              Text(
                widget.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kGrey700,
                    ),
              )
            ],
          ),
        ),
        24.0.height,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var newList = widget.list[index];
            return InkWell(
              onTap: () {
                sourceCurrency.value = newList;
                setState(() {});
                context.pop();
                context.pop();
              },
              child: CurrencyItem(
                name: newList.name,
                code: "${newList.code} Account domiciled in ${widget.name}",
                image: newList.flag == null
                    ? "https://media.istockphoto.com/id/583715254/photo/national-flags-of-the-different-countries-of-the-world.jpg?b=1&s=612x612&w=0&k=20&c=gdvXYVsV6R6K0aCip-Q4i_R5qCfLsg61-qAXtlhUzpI="
                    : newList.flag!.png,
              ),
            );
          },
          separatorBuilder: (context, index) => 24.0.height,
          itemCount: widget.list.length,
        ),
      ],
    );
  }
}
