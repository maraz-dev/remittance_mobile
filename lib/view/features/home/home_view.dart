import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/local/user_data_impl.dart';
import 'package:remittance_mobile/data/models/responses/user_response.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_transaction_pin.dart';
import 'package:remittance_mobile/view/features/home/account-view/account_widget.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/kyc_info_card.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_appbar.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_image.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_service_card.dart';
import 'package:remittance_mobile/view/features/transactions/vm/get_customer_transx_vm.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/latest_transaction_box.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class HomeView extends ConsumerStatefulWidget {
  static String path = '/home-view';
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // Check if the User has set his Transaction PIN and then Check if the User has done KYC
        if (!SharedPrefManager.isPINSet) {
          AppBottomSheet.showBottomSheet(
            context,
            isDismissible: false,
            enableDrag: false,
            widget: const CreateTransactionPINSheet(
              fromHomeView: true,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the Saved User Data
    final user = ref.watch(localUserProvider);
    final userAccounts = ref.watch(getCustomerAccountsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kGrey50,
        automaticallyImplyLeading: false,
        title: HomeAppBarWidget(
          response: user.value ?? UserResponse(),
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(getCustomerAccountsProvider);
          ref.invalidate(getKycStatusProvider);
          ref.read(getCustomerTranxProvider.notifier).getCustomerTransxMethod();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,

              // KYC Info Card
              const KycInfoCard().widgetPadding(l: 24, r: 24.0),

              16.0.height,

              /// Acounts
              userAccounts.maybeWhen(
                orElse: () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(text: 'Accounts'),
                    12.0.height,
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                ).widgetPadding(l: 24, r: 24.0),
                data: (data) => AccountsWidget(
                  doesUserHaveAccount: data.isEmpty ? false : true,
                  accounts: data,
                ),
              ),
              24.0.height,

              /// Services
              SizedBox(
                height: 50,
                child: MediaQuery.removePadding(
                  context: context,
                  removeRight: true,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return homeServiceCardList[index];
                      },
                      separatorBuilder: (context, index) => 8.0.width,
                      itemCount: homeServiceCardList.length),
                ),
              ).widgetPadding(l: 24),
              20.0.height,

              // Latest Transactions
              const LatestTransactionsBox(
                length: 3,
              ).widgetPadding(l: 24, r: 24.0),
              20.0.height,

              /// Banner
              const SectionHeader(text: 'For You').widgetPadding(l: 24, r: 24.0),
              8.0.height,
              SizedBox(
                height: 200.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return forYouList[index];
                  },
                  separatorBuilder: (context, index) => 12.0.width,
                  itemCount: 2,
                ),
              ).widgetPadding(l: 24),
              16.0.height,

              30.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
