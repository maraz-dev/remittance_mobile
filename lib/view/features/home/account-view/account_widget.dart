import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/features/home/account-view/dummy_account.dart';
import 'package:remittance_mobile/view/features/home/widgets/accounts_title.dart';
import 'package:remittance_mobile/view/features/home/widgets/add_new_account_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_account_card.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AccountsWidget extends StatelessWidget {
  const AccountsWidget({
    super.key,
    required this.doesUserHaveAccount,
  });

  final bool doesUserHaveAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AccountsTitle(isCardListEmpty: doesUserHaveAccount),
        12.0.height,
        SizedBox(
          height: 135.h,
          child: doesUserHaveAccount
              ? ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var value = accountList[index];
                    return AccountsCard(
                        onclicked: true,
                        accountImage: value.accountImage,
                        balance: value.balance,
                        accountType: value.accountType);
                  },
                  separatorBuilder: (context, index) => 8.0.width,
                  itemCount: accountList.length,
                )
              : const AddNewAccountCard(),
        ),
      ],
    );
  }
}
