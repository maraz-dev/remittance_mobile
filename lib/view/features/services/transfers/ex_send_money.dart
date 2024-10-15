import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/services/transfers/bank_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/features/services/vm/send_charge_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

ValueNotifier<AccountModel> srcCurrencyValue = ValueNotifier(AccountModel());
ValueNotifier<AccountCurrencies> desCurrencyValue =
    ValueNotifier(AccountCurrencies());

class SendMoneyInitialView extends ConsumerStatefulWidget {
  static String path = 'send-money-initial-view';
  const SendMoneyInitialView({super.key});

  @override
  ConsumerState<SendMoneyInitialView> createState() =>
      _SendMoneyInitialViewState();
}

class _SendMoneyInitialViewState extends ConsumerState<SendMoneyInitialView> {
  /// Global Keys
  final GlobalKey<State> _sourceCountryKey = GlobalKey();
  final GlobalKey<State> _destinationCurrencyKey = GlobalKey();
  final GlobalKey<State> _recipientTypeKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _sourceCountry = TextEditingController();
  final TextEditingController _destinationCountry = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _recipientType = TextEditingController();
  final TextEditingController _emailAdress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _transactionDesc = TextEditingController();
  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _accountName = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  // final List<String> _recipientDropDown = [
  //   'ErrandPay User',
  //   'Bank',
  //   'Mobile Money'
  // ];

  final List<String> _recipientDropDown = [
    'Bank',
  ];

  @override
  void dispose() {
    _sourceCountry.dispose();
    _destinationCountry.dispose();
    _recipientName.dispose();
    _phoneNumber.dispose();
    _transactionDesc.dispose();
    _recipientType.dispose();
    _emailAdress.dispose();
    _bankName.dispose();
    _accountNumber.dispose();
    _accountName.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountCurrenciesProvider = ref.watch(getAccountsCurrencyProvider);
    final userAccounts = ref.watch(getCustomerAccountsProvider);
    final sendChargeLoading = ref.watch(sendChargeProvider).isLoading;
    final corridors = ref.watch(getCorridorsProvider);

    ref.listen(sendChargeProvider, (_, next) {
      if (next is AsyncData) {
        context.pushNamed(SendMoneyFinalView.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return AbsorbPointer(
      absorbing: userAccounts.isLoading ||
          accountCurrenciesProvider.isLoading ||
          sendChargeLoading,
      child: Scaffold(
        appBar: innerAppBar(title: 'Send Money'),
        body: Form(
          key: _formKey,
          child: ScaffoldBody(
            body: SingleChildScrollView(
              child: accountCurrenciesProvider.isLoading ||
                      userAccounts.isLoading
                  ? const SpinKitRing(
                      color: AppColors.kPrimaryColor,
                      size: 100,
                      lineWidth: 3,
                    )
                  : Column(
                      children: [
                        10.0.height,

                        /// Country
                        TextInput(
                          key: _sourceCountryKey,
                          header: 'Source Currency',
                          controller: _sourceCountry,
                          hint: 'Select Source Currency',
                          inputType: TextInputType.text,
                          validator: validateGeneric,
                          readOnly: true,
                          onPressed: () async {
                            final List<String>? list = userAccounts.value
                                ?.map((element) => element.currencyCode ?? "")
                                .toList();
                            await platformSpecificDropdown(
                              key: _sourceCountryKey,
                              context: context,
                              items: list ?? [],
                              value: _sourceCountry.text,
                              onChanged: (newValue) {
                                setState(() {
                                  _sourceCountry.text = newValue ?? "";
                                  srcCurrencyValue.value =
                                      userAccounts.value?.elementAt(
                                            userAccounts.value?.indexWhere(
                                                  (value) =>
                                                      value.currencyCode ==
                                                      _sourceCountry.text,
                                                ) ??
                                                0,
                                          ) ??
                                          AccountModel();
                                });
                              },
                            );
                          },
                          suffixIcon: SvgPicture.asset(
                            AppImages.arrowDown,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        24.0.height,

                        /// Country
                        TextInput(
                          key: _destinationCurrencyKey,
                          header: 'Destination Currency',
                          controller: _destinationCountry,
                          hint: 'Select Destination Destination',
                          inputType: TextInputType.text,
                          validator: validateGeneric,
                          readOnly: true,
                          onPressed: () async {
                            final List<String>? list = accountCurrenciesProvider
                                .value
                                ?.map((element) => element.currencyCode ?? "")
                                .toList();
                            await platformSpecificDropdown(
                              key: _destinationCurrencyKey,
                              context: context,
                              items: list ?? [],
                              value: _destinationCountry.text,
                              onChanged: (newValue) {
                                setState(() {
                                  _destinationCountry.text = newValue ?? "";
                                  desCurrencyValue.value =
                                      accountCurrenciesProvider.value
                                              ?.elementAt(
                                            accountCurrenciesProvider.value
                                                    ?.indexWhere(
                                                  (value) =>
                                                      value.currencyCode ==
                                                      _destinationCountry.text,
                                                ) ??
                                                0,
                                          ) ??
                                          AccountCurrencies();
                                });
                              },
                            );
                          },
                          suffixIcon: SvgPicture.asset(
                            AppImages.arrowDown,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        24.0.height,

                        /// Recipient Type Provider
                        TextInput(
                          key: _recipientTypeKey,
                          header: 'Recipient Type',
                          controller: _recipientType,
                          hint: 'Select Recipient Type',
                          inputType: TextInputType.text,
                          validator: validateGeneric,
                          readOnly: true,
                          suffixIcon: SvgPicture.asset(
                            AppImages.arrowDown,
                            fit: BoxFit.scaleDown,
                          ),
                          onPressed: () async {
                            await platformSpecificDropdown(
                              key: _recipientTypeKey,
                              context: context,
                              items: _recipientDropDown,
                              value: _recipientType.text,
                              onChanged: (newValue) {
                                setState(() {
                                  _recipientType.text = newValue ?? "";
                                });
                              },
                            );
                          },
                        ),
                        24.0.height,

                        /// ErrandPay User Dropdown
                        Visibility(
                          visible: _recipientType.text == ''
                              ? false
                              : _recipientType.text == 'ErrandPay User'
                                  ? true
                                  : false,
                          child: Column(
                            children: [
                              /// Recipient Name
                              TextInput(
                                header: 'Recipient Name',
                                controller: _recipientName,
                                hint: 'Enter Recipient Name',
                                inputType: TextInputType.name,
                                validator: validateGeneric,
                              ),
                              24.0.height,

                              /// Email Address
                              TextInput(
                                header: 'Email Address',
                                controller: _emailAdress,
                                hint: 'Enter Email Address',
                                inputType: TextInputType.emailAddress,
                                validator: validateEmail,
                              ),
                              24.0.height,

                              /// Phone Number
                              TextInput(
                                header: 'Phone Number',
                                controller: _phoneNumber,
                                hint: 'Enter Phone Number',
                                inputType: TextInputType.number,
                                validator: validateGeneric,
                              ),
                              24.0.height,

                              /// Transaction Descrition
                              TextInput(
                                header: 'Transaction Description',
                                controller: _transactionDesc,
                                hint: 'Enter Transaction Description',
                                inputType: TextInputType.multiline,
                                maxLines: 5,
                                validator: validateGeneric,
                              ),
                              24.0.height,
                            ],
                          ),
                        ),

                        /// Bank Dropdown
                        Visibility(
                          visible: _recipientType.text == ''
                              ? false
                              : _recipientType.text == 'Bank'
                                  ? true
                                  : false,
                          child: Column(
                            children: [
                              /// Bank Name
                              TextInput(
                                header: 'Bank Name',
                                controller: _bankName,
                                hint: 'Select Bank',
                                inputType: TextInputType.name,
                                validator: validateGeneric,
                                readOnly: true,
                                onPressed: () async {
                                  BanksModel? result =
                                      await AppBottomSheet.showBottomSheet(
                                    context,
                                    widget: BanksSheet(
                                      country:
                                          desCurrencyValue.value.countryCode ??
                                              "NG",
                                    ),
                                  );
                                  _bankName.text = result?.bankName ?? "";
                                },
                                suffixIcon: SvgPicture.asset(
                                  AppImages.arrowDown,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              24.0.height,

                              /// Phone Number
                              TextInput(
                                header: 'Account Number',
                                controller: _accountNumber,
                                hint: 'Enter Account Number',
                                inputType: TextInputType.number,
                                validator: validateGeneric,
                              ),
                              24.0.height,

                              /// Transaction Descrition
                              TextInput(
                                header: 'Transaction Description',
                                controller: _transactionDesc,
                                hint: 'Enter Transaction Description',
                                inputType: TextInputType.multiline,
                                maxLines: 5,
                                validator: validateGeneric,
                              ),
                              24.0.height,
                            ],
                          ),
                        ),

                        /// Mobile Money Dropdown
                        Visibility(
                          visible: _recipientType.text == ''
                              ? false
                              : _recipientType.text == 'Mobile Money'
                                  ? true
                                  : false,
                          child: Column(
                            children: [
                              /// Phone Number
                              TextInput(
                                header: 'Phone Number',
                                controller: _phoneNumber,
                                hint: 'Enter Phone Number',
                                inputType: TextInputType.number,
                                validator: validateGeneric,
                              ),
                              24.0.height,

                              /// Transaction Descrition
                              TextInput(
                                header: 'Transaction Description',
                                controller: _transactionDesc,
                                hint: 'Enter Transaction Description',
                                inputType: TextInputType.multiline,
                                maxLines: 5,
                                validator: validateGeneric,
                              ),
                              24.0.height,
                            ],
                          ),
                        ),

                        24.0.height,
                      ],
                    ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              isLoading: sendChargeLoading,
              text: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(sendChargeProvider.notifier).sendChargeMethod(
                        SendChargeReq(
                          destinationCountryCode:
                              desCurrencyValue.value.countryCode,
                          destinationCurrency:
                              desCurrencyValue.value.currencyCode,
                          sourceCurrency: srcCurrencyValue.value.currencyCode,
                          amount: 10,
                        ),
                      );
                }
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0)
          ],
        ),
      ),
    );
  }
}
