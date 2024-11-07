import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_send_money_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class ExchangeBuyOptionView extends StatefulWidget {
  const ExchangeBuyOptionView({super.key});

  @override
  State<ExchangeBuyOptionView> createState() => _ExchangeBuyOptionViewState();
}

class _ExchangeBuyOptionViewState extends State<ExchangeBuyOptionView> {
  // Text Editing Controllers
  final TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AmountInput(
              controller: _amount,
              header: 'You Buy',
            ),
            24.0.height,

            // Seller's Amount
            const SectionHeader(text: 'Seller receives'),
            8.0.height,
            RichTextWidget(
              text: 'The amount equivalent you will need to be able to buy ',
              hyperlink: '${_amount.text} USD.',
              hyperlinkColor: AppColors.kBlackColor,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            text: 'Next',
            onPressed: () {
              context.pushNamed(ExchangeSendMoneyOptionsView.path);
            },
          )
              .animate()
              .fadeIn(begin: 0, delay: 500.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
        ],
      ),
    );
  }
}
