import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/view/features/services/transfers/mobile_bank_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/add_beneficiary_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class MobileMoneySheet extends ConsumerStatefulWidget {
  const MobileMoneySheet({
    super.key,
  });

  @override
  ConsumerState<MobileMoneySheet> createState() => _MobileMoneySheetState();
}

class _MobileMoneySheetState extends ConsumerState<MobileMoneySheet> {
  // Global Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _accountName = TextEditingController();
  final TextEditingController _serviceProvider = TextEditingController();

  // Service Provider Controller
  BanksModel? _selectedProvider = BanksModel();

  @override
  void dispose() {
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
    return AbsorbPointer(
      absorbing: addBeneficiaryLoading,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.0.height,

          // Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(text: 'Mobile Money'),
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
          24.0.height,
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInput(
                  header: 'Service Provider',
                  controller: _serviceProvider,
                  hint: 'Select Provider',
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
                      widget: MobileBanksSheet(
                        country: transferState.destinationCountry?.code ?? "",
                      ),
                    );
                    _serviceProvider.text = result?.bankName ?? "";
                    _selectedProvider = result;
                  },
                ),
                24.0.height,
                TextInput(
                  animate: false,
                  header: 'Phone Number',
                  controller: _phoneNo,
                  hint: '2348012345678',
                  inputType: TextInputType.number,
                  validator: validateGeneric,
                ),
                24.0.height,
                TextInput(
                  animate: false,
                  header: 'Account Name',
                  controller: _accountName,
                  hint: 'Recipient Name',
                  inputType: TextInputType.name,
                  validator: validateGeneric,
                ),
                24.0.height,
                MainButton(
                  text: 'Continue',
                  isLoading: addBeneficiaryLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(addBeneficiaryProvider.notifier).addBeneficiaryMethod(
                            AddBeneficiaryReq(
                              serviceTypeCode: 'ST000015',
                              channel: 'MobileMoney',
                              currency: transferState.sourceCurrency?.code,
                              sourceCountry: transferState.sourceCountry?.code,
                              sourceCountryCode: transferState.sourceCountry?.code,
                              destinationCountryCode: transferState.destinationCountry?.code,
                              destinationCurrency: transferState.destinationCurrency?.code,
                              sourceCurrency: transferState.sourceCurrency?.code,
                              phoneNumber: _phoneNo.text,
                              accountName: _accountName.text,
                              fullName: _accountName.text,
                              firstName: _accountName.text.trim().split(' ').first,
                              lastName: _accountName.text.trim().split(' ').last,
                              bankCode: _selectedProvider?.code,
                              bankName: _selectedProvider?.bankName,
                            ),
                          );
                    }
                  },
                )
              ],
            ),
          ),

          24.0.height,
        ],
      ),
    );
  }
}
