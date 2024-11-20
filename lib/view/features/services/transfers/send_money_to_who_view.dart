import 'package:config/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdrawal-sheet/add_withdrawal_account.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/recipient_card.dart';
import 'package:remittance_mobile/view/features/services/widgets/recipients-sheets/borderpay_user_sheet.dart';
import 'package:remittance_mobile/view/features/services/widgets/recipients-sheets/cash_pickup_sheet.dart';
import 'package:remittance_mobile/view/features/services/widgets/recipients-sheets/mobile_money_sheet.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

ValueNotifier<BeneficiaryModel> selectedBeneficiary = ValueNotifier(BeneficiaryModel());

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
    final transferState = ref.watch(selectedTransferStateProvider);

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
                      // Show only the recipients for that particular currency
                      final streamlinedList = data
                          .where((currency) => currency.destinationCurrency!
                              .contains("${transferState.destinationCurrency!.code}"))
                          .toList();

                      // Filter the list for searching
                      final filteredData = streamlinedList
                          .where(
                            (recipient) =>
                                recipient.accountName!.toLowerCase().contains(_searchQuery) ||
                                recipient.accountNumber!.toLowerCase().contains(_searchQuery),
                          )
                          .toList();
                      if (streamlinedList.isEmpty) {
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
                                  16.0.height,
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var value = filteredData[index];
                                      return InkWell(
                                        onTap: () {
                                          selectedBeneficiary.value = value;
                                          context.pushNamed(
                                            SendMoneyDetailsView.path,
                                          );
                                        },
                                        child: RecipientsCard(
                                          image: value.channel!.contains('Mobile')
                                              ? "https://banner2.cleanpng.com/20180402/zde/avhi752rp.webp"
                                              : "https://static.vecteezy.com/system/resources/thumbnails/000/593/729/small/B011.jpg",
                                          name: value.accountName,
                                          accNumber: value.channel!.contains("Bank")
                                              ? value.accountNumber
                                              : value.phoneNumber,
                                          channel: value.bankName,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => Column(
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
                        ? Center(
                            child: Text(error.toString()),
                          )
                        : const Center(
                            child: Text('An Error Occured'),
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

class AddRecipientSheet extends ConsumerWidget {
  const AddRecipientSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transferState = ref.watch(selectedTransferStateProvider);

    final filteredRecipientList = addRecipientOptionList
        .where((e) => transferState.recipientTypes!
            .any((l) => e.title.replaceAll(' ', '').contains(l.name ?? "")))
        .toList();
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var list = filteredRecipientList[index];

            return InkWell(
              onTap: () {
                context.pop();
                AppBottomSheet.showBottomSheet(
                  context,
                  widget: list.getScreen(context),
                );
              },
              child: AddRecipientItemCard(list: list),
            );
          },
          separatorBuilder: (context, index) => 24.0.height,
          itemCount: filteredRecipientList.length,
        ),
        16.0.height,
      ],
    );
  }
}

class AddRecipientOptionItem {
  final String icon, title, desc;
  Widget? screen;

  AddRecipientOptionItem({
    required this.icon,
    required this.title,
    required this.desc,
    this.screen,
  });

  Widget getScreen(BuildContext context) {
    switch (title) {
      case 'Bank Account':
        return const AddBankAccountSheet(route: BankRoute.recipients);
      case 'Mobile Money':
        return const MobileMoneySheet();
      case 'Balance ($APP_NAME)':
        return const BorderPayUserSheet();
      case 'Cash Pickup':
        return const CashPickUpSheet();
      default:
        throw Exception('No screen defined for $title');
    }
  }
}

List<AddRecipientOptionItem> addRecipientOptionList = [
  AddRecipientOptionItem(
    icon: AppImages.accountDetails,
    title: 'Bank Account',
    desc: 'Provide recipients bank account details',
    screen: const AddBankAccountSheet(route: BankRoute.recipients),
  ),
  AddRecipientOptionItem(
    icon: AppImages.accountDetails,
    title: 'Mobile Money',
    desc: 'Provide recipients mobile money account details',
    screen: const MobileMoneySheet(),
  ),
  AddRecipientOptionItem(
    icon: AppImages.wallet,
    title: 'Balance ($APP_NAME)',
    desc: 'Send money to a $APP_NAME user',
    screen: const BorderPayUserSheet(),
  ),
  AddRecipientOptionItem(
    icon: AppImages.card,
    title: 'Cash Pickup',
    desc: 'Provide details of the person receiving the cash',
    screen: const CashPickUpSheet(),
  ),
];
