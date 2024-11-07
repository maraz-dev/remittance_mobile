import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class BanksSheet extends ConsumerStatefulWidget {
  final String country;
  const BanksSheet({
    super.key,
    required this.country,
  });

  @override
  ConsumerState<BanksSheet> createState() => _BanksSheet();
}

class _BanksSheet extends ConsumerState<BanksSheet> {
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
    // Account Currency Endpoint
    final banks = ref.watch(getBanksProvider(widget.country));

    return SafeArea(
      child: SizedBox(
        height: 700,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeader(text: 'Choose Bank'),
                InkWell(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset(
                    AppImages.closeIcon,
                    colorFilter: AppColors.kGrey700.colorFilterMode(),
                    width: 24,
                  ),
                )
              ],
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
                child: banks.maybeWhen(
                  orElse: () => const SpinKitRing(
                    color: AppColors.kPrimaryColor,
                    size: 100,
                    lineWidth: 3,
                  ),
                  error: (error, stackTrace) => const SpinKitRing(
                    color: AppColors.kPrimaryColor,
                    size: 100,
                    lineWidth: 3,
                  ),
                  data: (data) {
                    final filteredData = data
                        .where((bank) =>
                            bank.bankName!.toLowerCase().contains(_searchQuery) ||
                            bank.bankName!.toLowerCase().contains(_searchQuery))
                        .toList();
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var value = filteredData[index];
                        return BankItem(
                          onPressed: () async {
                            context.pop(value);
                          },
                          name: value.bankName,
                          code: value.code,
                          image: AppImages.accountDetails,
                        );
                      },
                      separatorBuilder: (context, index) => 24.0.height,
                      itemCount: filteredData.length,
                    );
                  },
                ),
              ),
            ),
            30.0.height,
          ],
        ),
      ),
    );
  }
}

class BankItem extends StatelessWidget {
  final String? name, code, image;
  final Function()? onPressed;
  const BankItem({
    super.key,
    this.name,
    this.code,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CardIcon(
            image: AppImages.accountDetails,
            bgColor: AppColors.kGrey100,
          ),
          16.0.width,
          Expanded(
            child: Text(
              name ?? 'American Dollar',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.kGrey800,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
