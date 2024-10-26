import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/customer_transaction_model.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/features/transactions/vm/get_customer_transx_vm.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/filter_bottomsheet.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class TransactionHistoryView extends ConsumerStatefulWidget {
  static String path = 'transaction-history-view';
  const TransactionHistoryView({super.key});

  @override
  ConsumerState<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends ConsumerState<TransactionHistoryView> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String _searchQuery = '';

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  // Async Value to hold the Transaction List
  List<TransactionsRes> transactionList = [];

  getTransactionList() async {
    transactionList = await ref.read(getCustomerTranxProvider.notifier).getCustomerTransxMethod();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    isSelectedList = List.generate(filterTabList.length, (_) => false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTransactionList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.removeListener(_onSearchChanged);

    super.dispose();
  }

  List<String> filterTabList = [
    'All',
    'Cards',
    'Exchange',
    'Buy&Sell',
    'Bills',
    'Another',
  ];

  List<String> filterDateList = [
    'This Week',
    'Month',
    'Year',
    'Custom',
  ];
  List<bool> isSelectedList = [];
  String selectedFilterDate = '';

  @override
  Widget build(BuildContext context) {
    final transactionLoading = ref.watch(getCustomerTranxProvider).isLoading;

    // Search Controller
    final filteredData = transactionList
        .where((list) =>
            list.narration!.toLowerCase().contains(_searchQuery) ||
            list.trxAmount!.toString().contains(_searchQuery))
        .toList();

    return Scaffold(
      appBar: innerAppBar(title: 'Transaction History'),
      body: ScaffoldBody(
        body: AbsorbPointer(
          absorbing: transactionLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.height,
              // Search Bar and Filter
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextInput(
                      controller: _searchController,
                      hint: "Search Transactions",
                      inputType: TextInputType.emailAddress,
                      validator: null,
                      animate: false,
                    ),
                  ),
                  8.0.width,

                  // Filter Button
                  InkWell(
                    onTap: () {
                      filterBottomSheet(
                        context: context,
                        filterTabList: filterTabList,
                        isSelectedList: isSelectedList,
                        filterDateList: filterDateList,
                        selectedFilterDate: selectedFilterDate,
                        startDateController: _startDateController,
                        endDateController: _endDateController,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.kWhiteColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.kGrey300),
                      ),
                      child: SvgPicture.asset(AppImages.filterList),
                    ),
                  )
                ],
              ),
              16.0.height,

              // All Transactions
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SectionHeader(text: 'All Transactions'),
                      24.0.height,
                      transactionLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: SpinKitRing(
                                color: AppColors.kPrimaryColor,
                                size: 100,
                                lineWidth: 3,
                              ),
                            )
                          : transactionList.isEmpty
                              ? Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      24.0.height,
                                      const CardIcon(
                                        image: AppImages.chart,
                                        size: 40,
                                        padding: 40,
                                        bgColor: AppColors.kGrey200,
                                      ),
                                      16.0.height,
                                      Text(
                                        'No Transactions',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.kGrey700,
                                            ),
                                      )
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                    physics: const AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var value = filteredData[index];
                                      return TransactionCard(
                                        onPressed: () {
                                          return index % 2 == 0
                                              ? context.pushNamed(
                                                  TransactionDetails.path,
                                                  extra: TransactionStatusUpdate.sent,
                                                )
                                              : context.pushNamed(
                                                  TransactionDetails.path,
                                                  extra: TransactionStatusUpdate.sending,
                                                );
                                        },
                                        transxItem: value,
                                      );
                                    },
                                    separatorBuilder: (context, index) => 24.0.height,
                                    itemCount: filteredData.length,
                                  ),
                                ),
                    ],
                  ),
                ),
              ),

              12.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
