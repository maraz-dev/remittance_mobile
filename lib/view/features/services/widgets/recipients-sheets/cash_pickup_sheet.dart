import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/add_beneficiary_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class CashPickUpSheet extends ConsumerStatefulWidget {
  const CashPickUpSheet({
    super.key,
  });

  @override
  ConsumerState<CashPickUpSheet> createState() => _MobileMoneySheetState();
}

class _MobileMoneySheetState extends ConsumerState<CashPickUpSheet> {
  // Global Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullName = TextEditingController();

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
              const SectionHeader(text: 'Cash Pick Up'),
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
                  header: 'Full Name',
                  controller: _fullName,
                  hint: 'Full Name',
                  inputType: TextInputType.text,
                  validator: validateGeneric,
                  animate: false,
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
                  header: 'Email',
                  controller: _email,
                  hint: 'name@example.com',
                  prefixIcon: SvgPicture.asset(
                    AppImages.mail,
                    fit: BoxFit.scaleDown,
                  ),
                  inputType: TextInputType.name,
                  validator: validateGeneric,
                ),
                24.0.height,
                MainButton(
                    text: 'Continue',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(addBeneficiaryProvider.notifier).addBeneficiaryMethod(
                              AddBeneficiaryReq(
                                serviceTypeCode: 'ST000015',
                                channel: 'CashPickup',
                                currency: transferState.sourceCurrency?.code,
                                sourceCountry: transferState.sourceCountry?.code,
                                sourceCountryCode: transferState.sourceCountry?.code,
                                destinationCountryCode: transferState.destinationCountry?.code,
                                destinationCurrency: transferState.destinationCurrency?.code,
                                sourceCurrency: transferState.sourceCurrency?.code,
                                phoneNumber: _phoneNo.text,
                                accountName: _fullName.text,
                                fullName: _fullName.text,
                                firstName: _fullName.text.trim().split(' ').first,
                                lastName: _fullName.text.trim().split(' ').last,
                                email: _email.text.trim(),
                              ),
                            );
                      }
                    })
              ],
            ),
          ),

          24.0.height,
        ],
      ),
    );
  }
}
