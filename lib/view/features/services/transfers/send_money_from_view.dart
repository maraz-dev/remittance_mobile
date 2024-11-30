import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/home/account-view/create_account_sheet.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

ValueNotifier<AccountModel> fromBalance = ValueNotifier(AccountModel());

class SendMoneyFromView extends ConsumerStatefulWidget {
  static const path = 'send-money-from-view';
  const SendMoneyFromView({super.key});

  @override
  ConsumerState<SendMoneyFromView> createState() => _SendMoneyFromViewState();
}

class _SendMoneyFromViewState extends ConsumerState<SendMoneyFromView> {
  @override
  Widget build(BuildContext context) {
    final userAccounts = ref.watch(getCustomerAccountsProvider);

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
                    'Send Money from?',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  16.0.height,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.kWhiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(text: 'From My Balance'),
                        16.0.height,
                        userAccounts.maybeWhen(
                          data: (data) {
                            if (data.isEmpty) {
                              return InkWell(
                                onTap: () {
                                  AppBottomSheet.showBottomSheet(
                                    context,
                                    widget: const CreateCustomerAccountSheet(),
                                  );
                                },
                                child: const AddNewBalanceWidget(),
                              );
                            } else {
                              // Only show the Balances that aren't Zero
                              final newDataList = data;

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var value = newDataList[index];
                                  return InkWell(
                                    onTap: () {
                                      fromBalance.value = value;
                                      context.pushNamed(SendMoneyHowMuchView.path);
                                    },
                                    child: SendMoneyBalance(
                                      image: value.flagPng,
                                      balance: value.balance!.amountWithCurrency(""),
                                      currency: value.currencyName,
                                      symbol: value.currencyCode,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => 24.0.height,
                                itemCount: newDataList.length,
                              );
                            }
                          },
                          orElse: () => SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 50,
                              borderRadius: BorderRadius.circular(16),
                            ),
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

class SendMoneyBalance extends StatelessWidget {
  final String? image, symbol, balance, currency;
  const SendMoneyBalance({
    super.key,
    this.image,
    this.symbol,
    this.balance,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(image ?? ""),
        ),
        12.0.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$balance $symbol",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.kGrey700,
                  ),
            ),
            Text(currency ?? "")
          ],
        ),
        const Spacer(),
        SvgPicture.asset(AppImages.arrowRight),
      ],
    );
  }
}

class AddNewBalanceWidget extends StatelessWidget {
  const AddNewBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CardIcon(
          padding: 8,
          bgColor: AppColors.kGrey200,
          image: AppImages.add,
        ),
        12.0.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              text: 'Add New',
              fontSize: 16,
            ),
            5.0.height,
            Text(
              '50+ Currencies',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }
}
