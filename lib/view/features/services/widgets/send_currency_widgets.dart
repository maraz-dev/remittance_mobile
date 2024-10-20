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
  final String title;
  final List<CorridorsResponse> corridors;
  final SendRoute location;
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
        .where((country) => country.name!.toLowerCase().contains(_searchQuery))
        .toList();
    return SizedBox(
      height: 500,
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
                  return SendCurrencyItem(
                    image: value.flag!.png,
                    name: value.name,
                    countryCode: value.code,
                    sourceCurrencies: value.sourceCurrencies ?? [],
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

class SendCurrencyItem extends StatefulWidget {
  final String? name, image, countryCode;
  final List<DestinationCountry> sourceCurrencies;
  final Function()? onPressed;
  const SendCurrencyItem({
    super.key,
    this.name,
    this.image,
    this.onPressed,
    required this.sourceCurrencies,
    this.countryCode,
  });

  @override
  State<SendCurrencyItem> createState() => _SendCurrencyItemState();
}

class _SendCurrencyItemState extends State<SendCurrencyItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.sourceCurrencies.length < 2) {
          context.pop(widget.sourceCurrencies.first);
        } else {
          AppBottomSheet.showBottomSheet(
            context,
            widget: MultipleCurrencySheet(
              name: widget.name ?? '',
              list: widget.sourceCurrencies,
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
                        var value = widget.sourceCurrencies[index];
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
                      itemCount:
                          widget.sourceCurrencies.length < 3 ? widget.sourceCurrencies.length : 3,
                    ),
                  ),
                  if (widget.sourceCurrencies.length > 3) ...[
                    Text(' + ${widget.sourceCurrencies.length - 3}'),
                  ]
                ],
              ),
            ],
          ),
          const Spacer(),
          widget.sourceCurrencies.length < 2
              ? const SizedBox.shrink()
              : SvgPicture.asset(AppImages.arrowRight)
        ],
      ),
    );
  }
}

class MultipleCurrencySheet extends StatelessWidget {
  const MultipleCurrencySheet({
    super.key,
    required this.name,
    required this.list,
  });

  final String name;
  final List<DestinationCountry> list;

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
                name,
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
            var newList = list[index];
            return InkWell(
              onTap: () {
                context.pop();
                context.pop();
              },
              child: CurrencyItem(
                name: newList.name,
                code: "${newList.code} Account domiciled in $name",
                image: newList.flag == null
                    ? "https://media.istockphoto.com/id/583715254/photo/national-flags-of-the-different-countries-of-the-world.jpg?b=1&s=612x612&w=0&k=20&c=gdvXYVsV6R6K0aCip-Q4i_R5qCfLsg61-qAXtlhUzpI="
                    : newList.flag!.png,
              ),
            );
          },
          separatorBuilder: (context, index) => 24.0.height,
          itemCount: list.length,
        ),
      ],
    );
  }
}
