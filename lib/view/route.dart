import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/forgot_password_otp_form.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/forgot_password_view.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/reset_password_view.dart';
import 'package:remittance_mobile/view/features/auth/security-lock/security_lock_view.dart';
import 'package:remittance_mobile/view/features/auth/login_view.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_view.dart';
import 'package:remittance_mobile/view/features/auth/security-lock/set_security_question_view.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/avs_authorization_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/debit_card_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/confirm_create_account.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_initial_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_receive_money_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_send_money_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_transaction_detail.dart';
import 'package:remittance_mobile/view/features/home/account-view/payments_methods_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/add_money_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdraw_money_view.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/home_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/complete_profile_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/means_of_id_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/proof-of-address-flow/proof_of_address_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfle_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/ssn_and_bvn_view.dart';
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
import 'package:remittance_mobile/view/features/services/transfers/send_money_details.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/virtual-cards/virtual_cards_empty_view.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_history_view.dart';
import 'package:remittance_mobile/view/features/transactions/transactions_view.dart';
import 'package:remittance_mobile/view/route/current_user_notifier.dart';

final GlobalKey<NavigatorState> rootNavigation = GlobalKey(debugLabel: "root");
final GlobalKey<NavigatorState> shellNavigation = GlobalKey(debugLabel: "shell");

final routeProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(userStateProvider);

  return GoRouter(
    initialLocation: "/",
    navigatorKey: rootNavigation,
    debugLogDiagnostics: true,
    restorationScopeId: "app",
    redirect: (context, state) {
      final isloggedIn = user.newUser;
      final isFirstLaunch = SharedPrefManager.isFirstLaunch;
      if (isFirstLaunch) {
        log("is first launch");
        if (state.matchedLocation == '/') {
          return '/';
        }
      } else if (isloggedIn || !isloggedIn) {
        if (state.matchedLocation == '/') {
          return LoginScreen.path;
        }
      }

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
            path: ForgotPasswordOtpForm.path,
            name: ForgotPasswordOtpForm.path,
            builder: (context, state) => const ForgotPasswordOtpForm(),
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
          routes: [
            GoRoute(
              path: SetSecurityQuestionView.path,
              name: SetSecurityQuestionView.path,
              builder: (context, state) => const SetSecurityQuestionView(),
            ),
          ]),
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
              path: ConfirmCreateAccountView.path,
              name: ConfirmCreateAccountView.path,
              builder: (context, state) {
                final accountDetails = state.extra as AccountModel;
                return ConfirmCreateAccountView(
                  accountDetails: accountDetails,
                );
              },
            ),
            GoRoute(
              path: CurrencyAccountView.path,
              name: CurrencyAccountView.path,
              builder: (context, state) {
                final accountDetails = state.extra as AccountModel;
                return CurrencyAccountView(
                  accountDetails: accountDetails,
                );
              },
            ),
            GoRoute(
                path: AddMoneyView.path,
                name: AddMoneyView.path,
                builder: (context, state) => const AddMoneyView(),
                routes: [
                  GoRoute(
                    path: DebitCardSheet.path,
                    name: DebitCardSheet.path,
                    builder: (context, state) => const DebitCardSheet(),
                  ),
                  GoRoute(
                    path: AvsAuthorizationSheet.path,
                    name: AvsAuthorizationSheet.path,
                    builder: (context, state) => const AvsAuthorizationSheet(),
                  ),
                ]),
            GoRoute(
              path: WithdrawMoneyView.path,
              name: WithdrawMoneyView.path,
              builder: (context, state) => const WithdrawMoneyView(),
            ),
            GoRoute(
              path: PaymentMethodView.path,
              name: PaymentMethodView.path,
              builder: (context, state) => const PaymentMethodView(),
            ),
            GoRoute(
                path: ExchangeInitialView.path,
                name: ExchangeInitialView.path,
                builder: (context, state) => const ExchangeInitialView(),
                routes: [
                  GoRoute(
                    path: ExchangeSendMoneyOptionsView.path,
                    name: ExchangeSendMoneyOptionsView.path,
                    builder: (context, state) => const ExchangeSendMoneyOptionsView(),
                  ),
                  GoRoute(
                    path: ExchangeReceiveMoneyOptionsView.path,
                    name: ExchangeReceiveMoneyOptionsView.path,
                    builder: (context, state) => const ExchangeReceiveMoneyOptionsView(),
                  ),
                  GoRoute(
                    path: ExchangeTransactionDetailView.path,
                    name: ExchangeTransactionDetailView.path,
                    builder: (context, state) => const ExchangeTransactionDetailView(),
                  ),
                ]),
            GoRoute(
              path: TransactionDetails.path,
              name: TransactionDetails.path,
              builder: (context, state) {
                final status = state.extra as TransactionStatusUpdate;
                final requestId = state.pathParameters["id"] ?? "";
                return TransactionDetails(
                  requestId: requestId,
                  status: status,
                );
              },
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
              path: SendMoneyFromView.path,
              name: SendMoneyFromView.path,
              builder: (context, state) => const SendMoneyFromView(),
              routes: [
                GoRoute(
                  path: SendMoneyHowMuchView.path,
                  name: SendMoneyHowMuchView.path,
                  builder: (context, state) => const SendMoneyHowMuchView(),
                ),
                GoRoute(
                  path: SendMoneyToWhoView.path,
                  name: SendMoneyToWhoView.path,
                  builder: (context, state) => const SendMoneyToWhoView(),
                ),
                GoRoute(
                  path: SendMoneyDetailsView.path,
                  name: SendMoneyDetailsView.path,
                  builder: (context, state) => const SendMoneyDetailsView(),
                ),
              ]),
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
        path: CompleteProfileView.path,
        name: CompleteProfileView.path,
        builder: (context, state) => const CompleteProfileView(),
        routes: [
          GoRoute(
            path: SsnAndBvnView.path,
            name: SsnAndBvnView.path,
            builder: (context, state) => const SsnAndBvnView(),
          ),
          GoRoute(
              path: MeansOfIdView.path,
              name: MeansOfIdView.path,
              builder: (context, state) => const MeansOfIdView(),
              routes: const [
                // GoRoute(
                //   path: IdFrontCaptureView.path,
                //   name: IdFrontCaptureView.path,
                //   builder: (context, state) => const IdFrontCaptureView(),
                // ),
              ]),
          GoRoute(
              path: ProofOfAddressView.path,
              name: ProofOfAddressView.path,
              builder: (context, state) => const ProofOfAddressView(),
              routes: const [
                // GoRoute(
                //   path: ProofOfAddressUploadView.path,
                //   name: ProofOfAddressUploadView.path,
                //   builder: (context, state) =>
                //       const ProofOfAddressUploadView(),
                // ),
              ]),
          GoRoute(
            path: SelfieView.path,
            name: SelfieView.path,
            builder: (context, state) => const SelfieView(),
          )
        ],
      ),
    ],
  );
});
