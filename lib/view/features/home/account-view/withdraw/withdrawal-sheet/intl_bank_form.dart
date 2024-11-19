import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/requests/validate_acc_no_req.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/view/features/services/transfers/bank_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/add_beneficiary_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/validate_acc_no_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';

enum FundAccountType { saving, checking }

class InternationalBankForm extends ConsumerStatefulWidget {
  const InternationalBankForm({
    super.key,
  });

  @override
  ConsumerState<InternationalBankForm> createState() => _InternationalBankFormState();
}

class _InternationalBankFormState extends ConsumerState<InternationalBankForm> {
  // Global Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<State> _selectKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _accountNo = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _sortCode = TextEditingController();
  final TextEditingController _swiftCode = TextEditingController();
  final TextEditingController _transitNumber = TextEditingController();
  final TextEditingController _routingNumber = TextEditingController();
  final TextEditingController _bankAddress = TextEditingController();
  final TextEditingController _recipientAddress = TextEditingController();
  final TextEditingController _recipientCity = TextEditingController();
  final TextEditingController _recipientPostalCode = TextEditingController();
  final TextEditingController _fundTransferAccountType = TextEditingController();

  // Bank Controller
  BanksModel? _selectedBank = BanksModel();

  // Valid Intl Countries
  List<String> validIntlCountries = ['US', 'GB', 'CA', 'CN'];
  bool isValidCountry(String country) {
    List<String> validCountries = validIntlCountries;
    return validCountries.contains(country) ||
        validCountries.any((validCountry) => country.contains(validCountry));
  }

  // Method to Validate Account Number
  validateAccountNumber() {
    ref.read(validateAccountNumberProvider.notifier).validateAccountMethod(
          ValidateAccountNumberReq(
            bankCode: _selectedBank?.code ?? "",
            accountNumber: _accountNo.text,
          ),
        );
  }

  @override
  void dispose() {
    _accountNo.dispose();
    _recipientName.dispose();
    _bank.dispose();
    _sortCode.dispose();
    _swiftCode.dispose();
    _routingNumber.dispose();
    _transitNumber.dispose();
    _bankAddress.dispose();
    _recipientAddress.dispose();
    _recipientCity.dispose();
    _recipientPostalCode.dispose();
    _fundTransferAccountType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addBeneficiaryLoading = ref.watch(addBeneficiaryProvider).isLoading;
    final validateAccountLoading = ref.watch(validateAccountNumberProvider).isLoading;
    final transferState = ref.watch(selectedTransferStateProvider);

    ref.listen(addBeneficiaryProvider, (_, next) {
      if (next is AsyncData) {
        context.pop();
        selectedBeneficiary.value = next.value ?? BeneficiaryModel();
        context.pushNamed(SendMoneyDetailsView.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    ref.listen(validateAccountNumberProvider, (_, next) {
      if (next is AsyncData<String>) {
        _recipientName.text = next.value;
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInput(
            header: 'Bank',
            controller: _bank,
            hint: 'Select Bank',
            inputType: TextInputType.text,
            validator: validateGeneric,
            readOnly: true,
            animate: false,
            suffixIcon: SvgPicture.asset(
              AppImages.arrowDown,
              fit: BoxFit.scaleDown,
            ),
            onPressed: () async {
              BanksModel? result = await AppBottomSheet.showBottomSheet(
                context,
                widget: BanksSheet(
                  country: transferState.destinationCountry?.code ?? "",
                ),
              );

              if (result != null) {
                _selectedBank = result;
                _bank.text = result.bankName ?? "";
                _sortCode.text = result.bic ?? "";
                _swiftCode.text = result.swiftCode ?? "";
                if ((transferState.destinationCountry?.code?.contains("NG") ?? false) &&
                    _accountNo.text.isNotEmpty &&
                    _accountNo.text.length == 10) {
                  validateAccountNumber();
                }
              }
            },
            onChanged: (value) {
              log("changed");
              if ((transferState.destinationCountry?.code?.contains("GH") ?? false) &&
                  value.isNotEmpty &&
                  _accountNo.text.isNotEmpty &&
                  _accountNo.text.length == 10) {
                validateAccountNumber();
              }
            },
          ),
          24.0.height,
          if (isValidCountry(transferState.destinationCountry?.code ?? "")) ...[
            TextInput(
              animate: false,
              header: 'Bank Address',
              controller: _bankAddress,
              hint: 'Bank Address',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
          ],
          TextInput(
            animate: false,
            header: 'Account Number/IBAN',
            controller: _accountNo,
            hint: 'Enter your Account Number/IBAN',
            inputType: TextInputType.number,
            onChanged: (value) {
              if ((transferState.destinationCountry?.code?.contains("NG") ?? false) &&
                  value.isNotEmpty &&
                  _selectedBank != null &&
                  value.length == 10) {
                validateAccountNumber();
              }
            },
            validator: validateGeneric,
          ),
          24.0.height,
          Row(
            children: [
              Expanded(
                child: TextInput(
                  animate: false,
                  header: 'Recipient Name',
                  controller: _recipientName,
                  hint: 'Recipient Name',
                  readOnly: transferState.destinationCountry?.code?.contains("NG") ?? false,
                  inputType: TextInputType.text,
                  validator: validateGeneric,
                ),
              ),
              if (validateAccountLoading) ...[
                15.0.width,
                Column(
                  children: [
                    20.0.height,
                    const SpinKitFadingCircle(
                      color: AppColors.kPrimaryColor,
                      size: 35,
                    ),
                  ],
                )
              ]
            ],
          ),
          if (isValidCountry(transferState.destinationCountry?.code ?? "")) ...[
            24.0.height,
            TextInput(
              animate: false,
              header: 'Recipient Address',
              controller: _recipientAddress,
              hint: 'Recipient Address',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
            TextInput(
              animate: false,
              header: 'Recipient City',
              controller: _recipientCity,
              hint: 'Recipient City',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
            TextInput(
              animate: false,
              header: 'Recipient Postal Code',
              controller: _recipientPostalCode,
              hint: 'Recipient Postal Code',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
            TextInput(
              animate: false,
              header: 'Sort Code',
              controller: _sortCode,
              hint: 'Sort Code',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
            TextInput(
              animate: false,
              header: 'Swift Code',
              controller: _swiftCode,
              hint: 'Swift Code',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
            TextInput(
              animate: false,
              header: 'Routing Number',
              controller: _routingNumber,
              hint: 'Routing Number',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
            TextInput(
              animate: false,
              header: 'Transit Number',
              controller: _transitNumber,
              hint: 'Transit Number',
              inputType: TextInputType.name,
              validator: null,
            ),
            24.0.height,
            TextInput(
              animate: false,
              header: 'Fund Transfer Account Type',
              controller: _fundTransferAccountType,
              readOnly: true,
              hint: 'Select Account Type',
              inputType: TextInputType.name,
              validator: null,
              suffixIcon: SvgPicture.asset(
                AppImages.arrowDown,
                fit: BoxFit.scaleDown,
              ),
              onPressed: () async {
                await platformSpecificDropdown(
                  key: _selectKey,
                  context: context,
                  items: FundAccountType.values.map((number) => number.name.capitalize()).toList(),
                  value: _fundTransferAccountType.text,
                  onChanged: (newValue) {
                    setState(() {
                      _fundTransferAccountType.text = newValue ?? "";
                    });
                  },
                );
              },
            ),
          ],
          48.0.height,
          MainButton(
            isLoading: addBeneficiaryLoading,
            text: 'Add Bank Account',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref.read(addBeneficiaryProvider.notifier).addBeneficiaryMethod(
                      AddBeneficiaryReq(
                        serviceTypeCode: 'ST000015',
                        channel: 'Bank',
                        sourceAccountNumber: _accountNo.text,
                        currency: transferState.sourceCurrency?.code,
                        sourceCountry: transferState.sourceCountry?.code,
                        sourceCountryCode: transferState.sourceCountry?.code,
                        destinationCountryCode: transferState.destinationCountry?.code,
                        destinationCurrency: transferState.destinationCurrency?.code,
                        sourceCurrency: transferState.sourceCurrency?.code,
                        accountNumber: _accountNo.text,
                        accountName: _recipientName.text,
                        fullName: _recipientName.text,
                        firstName: _recipientName.text.trim().split(' ').first,
                        lastName: _recipientName.text.trim().split(' ').last,
                        bankCode: _selectedBank?.code,
                        bankName: _selectedBank?.bankName,
                        bankAddress: _bankAddress.text,
                        iban: _accountNo.text,
                        routingNumber: _routingNumber.text,
                        swiftCode: _swiftCode.text,
                        sortCode: _sortCode.text,
                        transitNumber: _transitNumber.text,
                        recipientAddress: _recipientAddress.text,
                        recipientCity: _recipientCity.text,
                        recipientPostalCode: _recipientPostalCode.text,
                        accountType: _fundTransferAccountType.text,
                      ),
                    );
              }
            },
          ),
          16.0.height,
        ],
      ),
    );
  }
}
