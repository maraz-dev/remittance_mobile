import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/profile/widgets/account_statement_card.dart';
import 'package:remittance_mobile/view/features/profile/widgets/statement_header.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/box_decoration.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class AccountStatementView extends StatefulWidget {
  static String path = 'account-statement-view';
  const AccountStatementView({super.key});

  @override
  State<AccountStatementView> createState() => _AccountStatementViewState();
}

class _AccountStatementViewState extends State<AccountStatementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Account Statements'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.height,
              const StatementYearHeader(text: '2024'),
              8.0.height,
              Container(
                decoration: whiteCardDecoration(),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const AccountStatementCard();
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      color: AppColors.kCountryDropDownColor,
                    );
                  },
                  itemCount: 4,
                ),
              ),
              24.0.height,
              const StatementYearHeader(text: '2023'),
              8.0.height,
              Container(
                decoration: whiteCardDecoration(),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const AccountStatementCard();
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      color: AppColors.kCountryDropDownColor,
                    );
                  },
                  itemCount: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
