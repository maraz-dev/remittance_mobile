import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdrawal-sheet/intl_bank_form.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdrawal-sheet/local_bank_form.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdrawal-sheet/withdrawal_tab_bar.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class AddBankAccountSheet extends StatefulWidget {
  const AddBankAccountSheet({
    super.key,
  });

  @override
  State<AddBankAccountSheet> createState() => _AddBankAccountSheetState();
}

class _AddBankAccountSheetState extends State<AddBankAccountSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _bankOptionTabController;

  @override
  void initState() {
    super.initState();
    _bankOptionTabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.0.height,

          // Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(text: 'Add Withdrawal Bank Account'),
              InkWell(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  AppImages.closeIcon,
                  colorFilter: AppColors.kGrey700.colorFilterMode(),
                  width: 24,
                  height: 24,
                ),
              )
            ],
          ),
          27.0.height,

          // Bank Tab Controller
          WithdrawalTabBar(bankOptionTabController: _bankOptionTabController),
          24.0.height,

          // View Per Tab
          Expanded(
            child: TabBarView(
              controller: _bankOptionTabController,
              children: const [
                SingleChildScrollView(child: LocalBankForm()),
                SingleChildScrollView(child: InternationalBankForm()),
              ],
            ),
          ),

          24.0.height,
        ],
      ),
    );
  }
}
