import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/widgets/accounts_title.dart';
import 'package:remittance_mobile/view/features/home/widgets/add_new_account_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_account_card.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountsWidget extends StatelessWidget {
  const AccountsWidget({
    super.key,
    required this.doesUserHaveAccount,
    required this.accounts,
  });

  final bool doesUserHaveAccount;
  final List<AccountModel> accounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AccountsTitle(isCardListEmpty: doesUserHaveAccount)
            .widgetPadding(l: 24, r: 24.0),
        12.0.height,
        SizedBox(
          height: 135.h,
          child: doesUserHaveAccount
              ? ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var value = accounts[index];
                    return InkWell(
                      onTap: () {
                        context.pushNamed(
                          CurrencyAccountView.path,
                          extra: value,
                        );
                      },
                      child: AccountsCard(
                        // TODO: You will change this later
                        onclicked: index == 0 ? true : false,
                        accountImage: value.currency == "NGN"
                            ? AppImages.ng
                            : AppImages.us,
                        balance: value.balance ?? 0.0,
                        accountType: value.currency ?? "",
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 8.0.width,
                  itemCount: accounts.length,
                )
              : const AddNewAccountCard(),
        ).widgetPadding(l: 24),
      ],
    );
  }
}
