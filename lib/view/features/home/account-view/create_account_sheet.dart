import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/home/account-view/confirm_create_account.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/create_individual_account_vm.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/alert_dialog.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class CreateCustomerAccountSheet extends ConsumerStatefulWidget {
  const CreateCustomerAccountSheet({
    super.key,
  });

  @override
  ConsumerState<CreateCustomerAccountSheet> createState() =>
      _CreateCustomerAccountSheetState();
}

class _CreateCustomerAccountSheetState
    extends ConsumerState<CreateCustomerAccountSheet> {
  /// Controller to Search
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Account Currency Endpoint
    final accountCurrenciesProvider = ref.watch(getAccountsCurrencyProvider);
    final createAccountLoading =
        ref.watch(createCustomerAccountProvider).isLoading;

    ref.listen(createCustomerAccountProvider, (_, next) {
      if (next is AsyncData<AccountModel>) {
        context.pushNamed(
          ConfirmCreateAccountView.path,
          extra: next.value,
        );
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(
          next.error.toString(),
          context,
        );
      }
    });

    return createAccountLoading
        ? const SpinKitRing(
            color: AppColors.kPrimaryColor,
            size: 100,
            lineWidth: 3,
          )
        : SafeArea(
            child: SizedBox(
              height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(text: 'Add New'),
                  TextInput(
                    controller: _searchController,
                    hint: "Search...",
                    inputType: TextInputType.text,
                    validator: null,
                    animate: false,
                  ),
                  24.0.height,
                  Expanded(
                    child: SingleChildScrollView(
                      child: accountCurrenciesProvider.maybeWhen(
                        orElse: () => const SpinKitRing(
                          color: AppColors.kPrimaryColor,
                          size: 100,
                          lineWidth: 3,
                        ),
                        error: (error, stackTrace) => const SpinKitRing(
                          color: AppColors.kPrimaryColor,
                          size: 100,
                          lineWidth: 3,
                        ),
                        data: (data) {
                          final filteredData = data
                              .where((currency) =>
                                  currency.currencyName!
                                      .toLowerCase()
                                      .contains(_searchQuery) ||
                                  currency.currencyCode!
                                      .toLowerCase()
                                      .contains(_searchQuery))
                              .toList();
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var value = filteredData[index];
                              return CurrencyItem(
                                onPressed: () async {
                                  // Confirm the User Picked that Currency
                                  final result =
                                      await ShowAlertDialog.showAlertDialog(
                                    context,
                                    title: 'Add Currency',
                                    content:
                                        'You are creating an Account in ${value.currencyCode} ',
                                    defaultActionText: 'Ok',
                                    cancelActionText: 'Cancel',
                                  );
                                  if (result == null) {
                                    return;
                                  } else if (result == true) {
                                    if (context.mounted) {
                                      //context.pop();
                                      ref
                                          .read(createCustomerAccountProvider
                                              .notifier)
                                          .createAccountMethod(
                                            CreateCustomerAccountReq(
                                              currencyCode: value.currencyCode,
                                              countryCode: value.countryCode,
                                            ),
                                          );
                                    }
                                  }
                                },
                                name: value.currencyName,
                                code: value.currencyCode,
                                image: value.flagPng,
                              );
                            },
                            separatorBuilder: (context, index) => 24.0.height,
                            itemCount: filteredData.length,
                          );
                        },
                      ),
                    ),
                  ),
                  30.0.height,
                ],
              ),
            ),
          );
  }
}

class CurrencyItem extends StatelessWidget {
  final String? name, code, image;
  final Function()? onPressed;
  const CurrencyItem({
    super.key,
    this.name,
    this.code,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            maxRadius: 28,
            backgroundImage: NetworkImage(image ?? ""),
          ),
          16.0.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? 'American Dollar',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.kGrey800,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              5.0.height,
              Text(
                code ?? 'USD',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
