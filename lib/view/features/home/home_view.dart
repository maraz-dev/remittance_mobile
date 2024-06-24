import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/local/user_data_impl.dart';
import 'package:remittance_mobile/data/models/responses/user_response.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_transaction_pin.dart';
import 'package:remittance_mobile/view/features/home/account-view/account_widget.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/kyc_info_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_appbar.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_image.dart';
import 'package:remittance_mobile/view/features/home/widgets/home_service_card.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

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
    /// Dummy [bool] to test the Accounts Card
    const bool doesUserHaveAccount = true;

    // Fetch the Saved User Data
    final user = ref.watch(localUserProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kGrey50,
        automaticallyImplyLeading: false,
        title: HomeAppBarWidget(
          response: user.value ?? UserResponse(),
        ),
      ),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.0.height,

            // KYC Info Card
            const KycInfoCard(),

            16.0.height,

            /// Acounts
            const AccountsWidget(doesUserHaveAccount: doesUserHaveAccount),
            24.0.height,

            /// Services
            const SectionHeader(text: 'Services'),
            8.0.height,
            SizedBox(
              height: 55,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return homeServiceCardList[index];
                  },
                  separatorBuilder: (context, index) => 8.0.width,
                  itemCount: homeServiceCardList.length),
            ),
            36.0.height,

            /// Banner
            const SectionHeader(text: 'For You'),
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
            ),
            16.0.height,

            30.0.height,
          ],
        ),
      )),
    );
  }
}
