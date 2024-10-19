import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/recipient_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class SendMoneyToWhoView extends ConsumerStatefulWidget {
  static const path = 'send-money-to-who-view';
  const SendMoneyToWhoView({super.key});

  @override
  ConsumerState<SendMoneyToWhoView> createState() => _SendMoneyToWhoViewState();
}

class _SendMoneyToWhoViewState extends ConsumerState<SendMoneyToWhoView> {
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
    final getBeneficiaries = ref.watch(getBeneficiariesProvider);

    return Scaffold(
      appBar: innerAppBar(title: 'Send Money'),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(getCustomerAccountsProvider);
        },
        child: ScaffoldBody(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  15.0.height,
                  Text(
                    'Who do you want to send money to ?',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  16.0.height,
                  getBeneficiaries.maybeWhen(
                    data: (data) {
                      final filteredData = data
                          .where(
                            (currency) =>
                                currency.accountName!
                                    .toLowerCase()
                                    .contains(_searchQuery) ||
                                currency.accountNumber!
                                    .toLowerCase()
                                    .contains(_searchQuery),
                          )
                          .toList();
                      if (data.isEmpty) {
                        return AddNewRecipientWidget(
                          onPressed: () {
                            AppBottomSheet.showBottomSheet(
                              context,
                              widget: const AddRecipientSheet(),
                            );
                          },
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AddNewRecipientAlt(
                              onPressed: () {
                                AppBottomSheet.showBottomSheet(
                                  context,
                                  widget: const AddRecipientSheet(),
                                );
                              },
                            ),
                            24.0.height,
                            // All Recipients Card
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kWhiteColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionHeader(
                                    text: 'All Recipients',
                                    fontSize: 16,
                                  ),
                                  TextInput(
                                    controller: _searchController,
                                    hint: "Search...",
                                    inputType: TextInputType.text,
                                    validator: null,
                                    animate: false,
                                    prefixIcon: SvgPicture.asset(
                                      AppImages.search,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  24.0.height,
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var value = filteredData[index];
                                      return InkWell(
                                        onTap: () {
                                          context.pushNamed(
                                            SendMoneyDetailsView.path,
                                          );
                                        },
                                        child: RecipientsCard(
                                          image: "",
                                          name: value.accountName,
                                          accNumber: value.accountNumber,
                                          channel: value.channel,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Column(
                                      children: [
                                        const Divider(
                                          color: AppColors.kGrey200,
                                        ),
                                        12.0.height,
                                      ],
                                    ),
                                    itemCount: filteredData.length,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                    orElse: () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        50.0.height,
                        const SpinKitRing(
                          color: AppColors.kPrimaryColor,
                          size: 100,
                          lineWidth: 3,
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => kDebugMode
                        ? Text(error.toString())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              50.0.height,
                              const SpinKitRing(
                                color: AppColors.kPrimaryColor,
                                size: 100,
                                lineWidth: 3,
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddRecipientSheet extends StatelessWidget {
  const AddRecipientSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SectionHeader(text: 'Add a Recipient'),
        16.0.height,
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.kGrey100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Charges may vary based on some receiving methods',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.kGrey700,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        24.0.height,
      ],
    );
  }
}
