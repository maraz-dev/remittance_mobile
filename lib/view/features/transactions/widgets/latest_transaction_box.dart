import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/customer_transaction_model.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/features/transactions/vm/get_customer_transx_vm.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/recent_transaction_header.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/transaction_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class LatestTransactionsBox extends ConsumerStatefulWidget {
  final int? length;
  final String? accountNumber;
  const LatestTransactionsBox({
    super.key,
    this.length,
    this.accountNumber,
  });

  @override
  ConsumerState<LatestTransactionsBox> createState() => _LatestTransactionsBoxState();
}

class _LatestTransactionsBoxState extends ConsumerState<LatestTransactionsBox> {
  // Async Value to hold the Transaction List
  List<TransactionsRes> transactionList = [];
  List<TransactionsRes>? newList;

  getTransactionList() async {
    transactionList = await ref.read(getCustomerTranxProvider.notifier).getCustomerTransxMethod();

    if (widget.accountNumber != null) {
      transactionList = transactionList
          .where((element) => element.accountNumber == widget.accountNumber)
          .toList();
    } else {
      transactionList = transactionList;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTransactionList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionLoading = ref.watch(getCustomerTranxProvider).isLoading;
    final transactionError = ref.watch(getCustomerTranxProvider).hasError;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const RecentTransactionHeader(),
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
              : transactionError
                  ? Column(
                      children: [
                        const CardIcon(
                          image: AppImages.deactivate,
                          size: 30,
                          padding: 30,
                          bgColor: AppColors.kGrey200,
                        ),
                        16.0.height,
                        Text(
                          'Oops! An Error Occured',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.kGrey700,
                              ),
                        )
                      ],
                    )
                  : transactionList.isEmpty
                      ? Column(
                          children: [
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
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var value = transactionList[index];
                            return TransactionCard(
                              onPressed: () {
                                context.pushNamed(
                                  TransactionDetails.path,
                                  pathParameters: {
                                    "id": value.reference ?? "",
                                    "fromSend": "false",
                                  },
                                  extra: TransactionStatusUpdate.sent,
                                );
                              },
                              transxItem: value,
                            );
                          },
                          separatorBuilder: (context, index) => 24.0.height,
                          itemCount: transactionList.length < 5
                              ? transactionList.length
                              : widget.length ?? 5,
                        ),
        ],
      ),
    );
  }
}
