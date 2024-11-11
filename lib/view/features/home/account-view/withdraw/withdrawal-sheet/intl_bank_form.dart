import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/view/features/services/transfers/bank_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/add_beneficiary_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';

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

  // Text Editing Controllers
  final TextEditingController _accountNo = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _sortCode = TextEditingController();
  final TextEditingController _swiftCode = TextEditingController();

  // Bank Controller
  BanksModel? _selectedBank = BanksModel();

  @override
  void dispose() {
    _accountNo.dispose();
    _recipientName.dispose();
    _bank.dispose();
    _sortCode.dispose();
    _swiftCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addBeneficiaryLoading = ref.watch(addBeneficiaryProvider).isLoading;
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

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInput(
            animate: false,
            header: 'Account Number/IBAN',
            controller: _accountNo,
            hint: 'Enter your Account Number/IBAN',
            inputType: TextInputType.number,
            validator: validateGeneric,
          ),
          24.0.height,
          TextInput(
            animate: false,
            header: 'Recipient Name',
            controller: _recipientName,
            hint: 'Recipient Name',
            inputType: TextInputType.text,
            validator: validateGeneric,
          ),
          24.0.height,
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
                  country: transferState.destinationCurrency?.code ?? "",
                ),
              );

              _selectedBank = result;

              _bank.text = result?.bankName ?? "";
              _sortCode.text = result?.bic ?? "";
              _swiftCode.text = result?.swiftCode ?? "";
            },
          ),
          24.0.height,
          TextInput(
            animate: false,
            header: 'Sort Code',
            controller: _sortCode,
            hint: 'Sort Code',
            inputType: TextInputType.name,
            validator: validateGeneric,
          ),
          24.0.height,
          TextInput(
            animate: false,
            header: 'Swift Code',
            controller: _swiftCode,
            hint: 'Swift Code',
            inputType: TextInputType.name,
            validator: validateGeneric,
          ),
          24.0.height,
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
                        sourceCountry: fromBalance.value.countryCode,
                        sourceCountryCode: fromBalance.value.countryCode,
                        destinationCountryCode: transferState.destinationCountry?.code,
                        destinationCurrency: transferState.destinationCurrency?.code,
                        sourceCurrency: transferState.sourceCurrency?.code,
                        accountNumber: _accountNo.text,
                        iban: _accountNo.text,
                        accountName: _recipientName.text,
                        fullName: _recipientName.text,
                        firstName: _recipientName.text.split(' ').first,
                        lastName: _recipientName.text.split(' ').last,
                        bankCode: _selectedBank?.code,
                        bankName: _selectedBank?.bankName,
                        routingNumber: _sortCode.text,
                        transitNumber: _swiftCode.text,
                      ),
                    );
              }
            },
          )
        ],
      ),
    );
  }
}
