import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/forgot_password_view.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/reset_password_view.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/security_lock_view.dart';
import 'package:remittance_mobile/view/features/auth/login_screen.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_view.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/add_money_view.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/home_view.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/means_of_id_view.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/proof_of_address.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/selfle_view.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/ssn_and_bvn_view.dart';
import 'package:remittance_mobile/view/features/onboarding/onboarding_screen.dart';
import 'package:remittance_mobile/view/features/profile/more/help_and_support_view.dart';
import 'package:remittance_mobile/view/features/profile/more/privacy_policy_view.dart';
import 'package:remittance_mobile/view/features/profile/more/terms_and_conditions_view.dart';
import 'package:remittance_mobile/view/features/profile/personal-info/account_statements_view.dart';
import 'package:remittance_mobile/view/features/profile/personal-info/personal_details_view.dart';
import 'package:remittance_mobile/view/features/profile/profile_view.dart';
import 'package:remittance_mobile/view/features/profile/security/change_password_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/airtime_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/betting_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/cable_tv_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/electricity_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/internet_view.dart';
import 'package:remittance_mobile/view/features/services/services_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/receive_money_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_initial.dart';
import 'package:remittance_mobile/view/features/services/virtual-cards/virtual_cards_empty_view.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_history_view.dart';
import 'package:remittance_mobile/view/features/transactions/transactions_view.dart';

final GlobalKey<NavigatorState> rootNavigation = GlobalKey(debugLabel: "root");
final GlobalKey<NavigatorState> shellNavigation =
    GlobalKey(debugLabel: "shell");

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      initialLocation: "/",
      navigatorKey: rootNavigation,
      debugLogDiagnostics: true,
      restorationScopeId: "app",
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(
          path: "/",
          name: OnboardingScreen.path,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: LoginScreen.path,
          name: LoginScreen.path,
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: SecurityLockView.path,
              name: SecurityLockView.path,
              builder: (context, state) => const SecurityLockView(),
            ),
            GoRoute(
              path: ForgotPasswordView.path,
              name: ForgotPasswordView.path,
              builder: (context, state) => const ForgotPasswordView(),
            ),
            GoRoute(
              path: ResetPasswordView.path,
              name: ResetPasswordView.path,
              builder: (context, state) => const ResetPasswordView(),
            )
          ],
        ),
        GoRoute(
          path: CreateAccountView.path,
          name: CreateAccountView.path,
          builder: (context, state) => const CreateAccountView(),
        ),
        GoRoute(
          path: DashboardView.path,
          name: DashboardView.path,
          builder: (context, state) => const DashboardView(),
        ),
        GoRoute(
            path: HomeView.path,
            name: HomeView.path,
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                path: CurrencyAccountView.path,
                name: CurrencyAccountView.path,
                builder: (context, state) => const CurrencyAccountView(),
              ),
              GoRoute(
                path: AddMoneyView.path,
                name: AddMoneyView.path,
                builder: (context, state) => const AddMoneyView(),
              ),
              GoRoute(
                path: TransactionDetails.path,
                name: TransactionDetails.path,
                builder: (context, state) => const TransactionDetails(),
              ),
            ]),
        GoRoute(
          path: ServicesView.path,
          name: ServicesView.path,
          builder: (context, state) => const ServicesView(),
          routes: [
            GoRoute(
              path: BettingView.path,
              name: BettingView.path,
              builder: (context, state) => const BettingView(),
            ),
            GoRoute(
              path: ElectricityView.path,
              name: ElectricityView.path,
              builder: (context, state) => const ElectricityView(),
            ),
            GoRoute(
              path: CableTvView.path,
              name: CableTvView.path,
              builder: (context, state) => const CableTvView(),
            ),
            GoRoute(
              path: AirtimeView.path,
              name: AirtimeView.path,
              builder: (context, state) => const AirtimeView(),
            ),
            GoRoute(
              path: InternetView.path,
              name: InternetView.path,
              builder: (context, state) => const InternetView(),
            ),
            GoRoute(
              path: SendMoneyInitialView.path,
              name: SendMoneyInitialView.path,
              builder: (context, state) => const SendMoneyInitialView(),
            ),
            GoRoute(
              path: SendMoneyFinalView.path,
              name: SendMoneyFinalView.path,
              builder: (context, state) => const SendMoneyFinalView(),
            ),
            GoRoute(
              path: ReceiveMoneyView.path,
              name: ReceiveMoneyView.path,
              builder: (context, state) => const ReceiveMoneyView(),
            ),
            GoRoute(
              path: VirtualCardEmptyView.path,
              name: VirtualCardEmptyView.path,
              builder: (context, state) => const VirtualCardEmptyView(),
            ),
          ],
        ),
        GoRoute(
            path: TransactionsView.path,
            name: TransactionsView.path,
            builder: (context, state) => const TransactionsView(),
            routes: [
              GoRoute(
                path: TransactionHistoryView.path,
                name: TransactionHistoryView.path,
                builder: (context, state) => const TransactionHistoryView(),
              )
            ]),
        GoRoute(
          path: ProfileView.path,
          name: ProfileView.path,
          builder: (context, state) => const ProfileView(),
          routes: [
            GoRoute(
              path: PersonalDetailsView.path,
              name: PersonalDetailsView.path,
              builder: (context, state) => const PersonalDetailsView(),
            ),
            GoRoute(
              path: ChangePasswordView.path,
              name: ChangePasswordView.path,
              builder: (context, state) => const ChangePasswordView(),
            ),
            GoRoute(
              path: AccountStatementView.path,
              name: AccountStatementView.path,
              builder: (context, state) => const AccountStatementView(),
            ),
            GoRoute(
              path: PrivacyPolicyView.path,
              name: PrivacyPolicyView.path,
              builder: (context, state) => const PrivacyPolicyView(),
            ),
            GoRoute(
              path: TermsAndConditionsView.path,
              name: TermsAndConditionsView.path,
              builder: (context, state) => const TermsAndConditionsView(),
            ),
            GoRoute(
              path: HelpAndSupportView.path,
              name: HelpAndSupportView.path,
              builder: (context, state) => const HelpAndSupportView(),
            )
          ],
        ),
        GoRoute(
          path: SsnAndKycView.path,
          name: SsnAndKycView.path,
          builder: (context, state) => const SsnAndKycView(),
        ),
        GoRoute(
          path: MeansOfIdView.path,
          name: MeansOfIdView.path,
          builder: (context, state) => const MeansOfIdView(),
        ),
        GoRoute(
          path: ProofOfAddressView.path,
          name: ProofOfAddressView.path,
          builder: (context, state) => const ProofOfAddressView(),
        ),
        GoRoute(
          path: SelfieView.path,
          name: SelfieView.path,
          builder: (context, state) => const SelfieView(),
        )

        // GoRoute(
        //     path: SMSScreen.path,
        //     name: SMSScreen.path,
        //     builder: (context, state) => const SMSScreen(),
        //     routes: [
        //       GoRoute(
        //         path: SMSDetailsScreen.path,
        //         name: SMSDetailsScreen.path,
        //         builder: (context, state) => const SMSDetailsScreen(),
        //       ),
        //     ]),
      ]);
});
