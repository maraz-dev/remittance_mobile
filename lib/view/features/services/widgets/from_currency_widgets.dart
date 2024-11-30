import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/view/features/home/account-view/create_account_sheet.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class FROMCountrySheet extends ConsumerStatefulWidget {
  const FROMCountrySheet({
    super.key,
  });

  @override
  ConsumerState<FROMCountrySheet> createState() => _FROMCountrySheetState();
}

class _FROMCountrySheetState extends ConsumerState<FROMCountrySheet> {
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
    final sourceCountry = ref.watch(sourceCountryProvider);

    return SizedBox(
      height: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(text: "From"),
          16.0.height,
          TextInput(
            controller: _searchController,
            hint: "Search...",
            inputType: TextInputType.text,
            validator: null,
            animate: false,
          ),
          24.0.height,
          sourceCountry.maybeWhen(
            data: (data) {
              final filteredDataFROM = data
                  .where((country) => country.name!.toLowerCase().contains(_searchQuery))
                  .toList();
              return Expanded(
                child: SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var value = filteredDataFROM[index];
                      return SendCurrencyItem(
                        onPressed: () {
                          ref
                              .read(selectedTransferStateProvider.notifier)
                              .selectSourceCountry(value);
                          if (value.sourceCurrencies!.length == 1) {
                            ref
                                .read(selectedTransferStateProvider.notifier)
                                .selectSourceCurrency(value.sourceCurrencies!.first);
                            context.pop();
                          } else {
                            AppBottomSheet.showBottomSheet(
                              context,
                              widget: CurrencySheet(
                                name: value.name ?? '',
                                list: value.sourceCurrencies ?? [],
                              ),
                            );
                          }
                        },
                        image: value.flag!.png,
                        name: value.name,
                        countryCode: value.code,
                        currencyData: value.sourceCurrencies,
                      );
                    },
                    separatorBuilder: (context, index) => 24.0.height,
                    itemCount: filteredDataFROM.length,
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
                ? Center(
                    child: Text(error.toString()),
                  )
                : const Center(
                    child: Text('An Error Occured'),
                  ),
          ),
        ],
      ),
    );
  }
}

class SendCurrencyItem extends StatefulWidget {
  final String? name, image, countryCode;
  final List<SMCountry>? currencyData;
  final Function()? onPressed;
  const SendCurrencyItem({
    super.key,
    this.name,
    this.image,
    this.onPressed,
    this.currencyData,
    this.countryCode,
  });

  @override
  State<SendCurrencyItem> createState() => _SendCurrencyItemState();
}

class _SendCurrencyItemState extends State<SendCurrencyItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
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
                widget.name ?? '',
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
                        var value = widget.currencyData![index];
                        return Text(
                          value.code ?? '',
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
                      itemCount: widget.currencyData!.length < 3 ? widget.currencyData!.length : 3,
                    ),
                  ),
                  if (widget.currencyData!.length > 3) ...[
                    Text(' + ${widget.currencyData!.length - 3} more'),
                  ]
                ],
              ),
            ],
          ),
          const Spacer(),
          widget.currencyData!.length < 2
              ? const SizedBox.shrink()
              : SvgPicture.asset(AppImages.arrowRight)
        ],
      ),
    );
  }
}

class CurrencySheet extends ConsumerStatefulWidget {
  const CurrencySheet({
    super.key,
    required this.name,
    required this.list,
  });

  final String name;
  final List<SMCountry> list;

  @override
  ConsumerState<CurrencySheet> createState() => _CurrencySheetState();
}

class _CurrencySheetState extends ConsumerState<CurrencySheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.pop();
          },
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
                ref.read(selectedTransferStateProvider.notifier).selectSourceCurrency(newList);
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
