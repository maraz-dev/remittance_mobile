import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/filter_bottomsheet.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class TransactionHistoryView extends StatefulWidget {
  static String path = 'transaction-history-view';
  const TransactionHistoryView({super.key});

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSelectedList = List.generate(filterTabList.length, (_) => false);
  }

  @override
  void dispose() {
    _searchController.dispose();
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
    return Scaffold(
      appBar: innerAppBar(title: 'Transaction History'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
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
                      hint: "Search Transactions by Name or Amount",
                      inputType: TextInputType.emailAddress,
                      validator: null,
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
                        border: Border.all(color: AppColors.kBorderColor),
                      ),
                      child: SvgPicture.asset(AppImages.filterList),
                    ),
                  )
                ],
              ),
              16.0.height,

              // All Transactions
              Container(
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
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () => context.pushNamed(
                                TransactionDetails.path,
                              ),
                          child: const TransactionCard()),
                      separatorBuilder: (context, index) => 24.0.height,
                      itemCount: 10,
                    ),
                  ],
                ),
              ),
              16.0.height,

              32.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
