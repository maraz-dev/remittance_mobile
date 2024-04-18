import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/widgets/bottom_sheet_amount_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/rates_card.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/current_balance_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/transaction_pin_sheet.dart';

class AddMoneyView extends StatefulWidget {
  static String path = 'add-money-view.dart';
  const AddMoneyView({super.key});

  @override
  State<AddMoneyView> createState() => _AddMoneyViewState();
}

class _AddMoneyViewState extends State<AddMoneyView> {
  final TextEditingController _paymentType = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _paymentType.dispose();
    _bank.dispose();
    _accountNumber.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Add Money'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                /// Payment Type
                TextInput(
                  header: 'Payment Type',
                  controller: _paymentType,
                  hint: 'Select Payment Type',
                  inputType: TextInputType.text,
                  validator: validateGeneric,
                  readOnly: true,
                  suffixIcon: SvgPicture.asset(
                    AppImages.arrowDown,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                24.0.height,

                /// Bank
                TextInput(
                  header: 'Bank',
                  controller: _paymentType,
                  hint: 'Select Bank',
                  inputType: TextInputType.text,
                  validator: validateGeneric,
                  readOnly: true,
                  suffixIcon: SvgPicture.asset(
                    AppImages.arrowDown,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                24.0.height,

                /// Account Number
                TextInput(
                  header: 'Account Number',
                  controller: _paymentType,
                  hint: 'Enter Account Number',
                  inputType: TextInputType.number,
                  maxLength: 10,
                  validator: validateGeneric,
                ),
                24.0.height,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        height: 190.h,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.kTextfieldColor,
              border: Border.all(color: AppColors.kCountryDropDownColor),
            ),
            child: Column(
              children: [
                const RatesCard(
                  showBorder: false,
                  color: AppColors.kPinInputColor,
                ),
                10.0.height,
                const CurrentBalanceWidget()
              ],
            ),
          ),
          12.0.height,
          MainButton(
            //isLoading: true,
            text: 'Add Money',
            onPressed: () {
              AppBottomSheet.showBottomSheet(context,
                  isDismissible: false,
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () => context.pop(),
                          child: SvgPicture.asset(AppImages.boxBackArrow)),
                      16.0.height,
                      const BottomSheetTitle(
                        title: 'Add Money',
                        subtitle:
                            'The amount below will be added into your USD account',
                      ),
                      24.0.height,
                      const BSAmountCard(),
                      5.0.height,
                      const AdditionalFeeText(),
                      40.0.height,
                      MainButton(
                          text: 'Add Money',
                          onPressed: () {
                            context.pop();
                            AppBottomSheet.showBottomSheet(
                              context,
                              isDismissible: false,
                              widget: TransactionPinSheet(
                                onPressed: () {
                                  context.pop();
                                  AppBottomSheet.showBottomSheet(
                                    context,
                                    isDismissible: false,
                                    widget: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(AppImages.success),
                                        16.0.height,
                                        BottomSheetTitle(
                                          title: 'Funds Added Successfully',
                                          subtitle:
                                              'Great job! You have successfully added ${500.amountWithCurrency('usd')} to your USD Account',
                                        ),
                                        40.0.height,
                                        MainButton(
                                          text: 'Back to Home',
                                          onPressed: () {
                                            context.pushReplacementNamed(
                                                DashboardView.path);
                                          },
                                        ),
                                        8.0.height,
                                        MainButton(
                                          text: 'See Transaction Receipt',
                                          color: AppColors.kWhiteColor,
                                          textColor: AppColors.kSecondaryColor,
                                          borderColor: AppColors.kBorderColor,
                                          onPressed: () {
                                            context.pop();
                                            context.pushNamed(
                                                AddMoneyTransactionDetails
                                                    .path);
                                          },
                                        ),
                                        16.0.height
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                      12.0.height
                    ],
                  ));
            },
          )
              .animate()
              .fadeIn(begin: 0, delay: 1000.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
          8.0.width,
        ],
      ),
    );
  }
}
