// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/verify_transx_req.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/verify_transx_funding_vm.dart';
import 'package:remittance_mobile/view/features/transactions/widgets/card_icon.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulHookConsumerWidget {
  final String url;
  final String routeName;
  const WebviewScreen({super.key, required this.url, required this.routeName});
  static String path = "/webview/:url/:routeName";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends ConsumerState<WebviewScreen> with RestorationMixin {
  @override
  String get restorationId => 'webview_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {}

  String name = "";
  bool pageLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('Flutter;Webview')
      ..setOnConsoleMessage((message) {
        log(message.toString());
      })
      ..enableZoom(true)
      ..loadRequest(Uri.parse(widget.url))
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                pageLoading = progress < 100;
              });
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                pageLoading = false;
              });
            }
          },
          onNavigationRequest: (NavigationRequest navRequest) async {
            if (navRequest.url.contains("borderpal.co")) {
              final strippedNavUrl = navRequest.url.split('&');
              final flwTrxId = strippedNavUrl
                  .elementAt(strippedNavUrl.indexWhere((item) => item.contains("transaction_id")))
                  .split('=')
                  .last;
              if (context.mounted) {
                ref.read(verifyFundingTransxProvider.notifier).verifyFundingTransxMethod(
                      VerifyFundingTransxReq(
                        flwTransactionId: int.parse(flwTrxId),
                        //requestId: flwRequestId.value,
                      ),
                    );
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(verifyFundingTransxProvider, (_, next) {
      if (next is AsyncData) {
        // isSuccessful & isCompleted
        if ((next.value?.isSuccessful ?? false) && (next.value?.isCompleted ?? false)) {
          AppBottomSheet.showBottomSheet(
            context,
            enableDrag: false,
            isDismissible: false,
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                64.0.height,
                const CardIcon(
                  image: AppImages.doneOutline,
                  padding: 30,
                  bgColor: AppColors.kGrey100,
                ),
                24.0.height,
                const SectionHeader(text: 'Transaction Complete'),
                8.0.height,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Your request is Complete. \n\nIf your Balance doesn\'t reflect immediately, Refresh your Dashboard.',
                    textAlign: TextAlign.center,
                  ),
                ),
                64.0.height,
                MainButton(
                    text: 'Go to Dashboard',
                    onPressed: () {
                      context.goNamed(DashboardView.path);
                    })
              ],
            ),
          );
        }
        // isSuccessful & is NOT isCompleted
        else if ((next.value?.isSuccessful ?? false) && !(next.value?.isCompleted ?? false)) {
          AppBottomSheet.showBottomSheet(
            context,
            enableDrag: false,
            isDismissible: false,
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                64.0.height,
                const CardIcon(
                  image: AppImages.doneOutline,
                  padding: 30,
                  bgColor: AppColors.kGrey100,
                ),
                24.0.height,
                const SectionHeader(text: 'Request Pending'),
                8.0.height,
                const Text('Your request is awaiting Confirmation.'),
                64.0.height,
                MainButton(
                    text: 'Go To Dashboard',
                    onPressed: () {
                      context.goNamed(DashboardView.path);
                    })
              ],
            ),
          );
        }
        // NOT isSuccessful & NOT isCompleted
        else if (!(next.value?.isSuccessful ?? false) && !(next.value?.isCompleted ?? false)) {
          AppBottomSheet.showBottomSheet(
            context,
            enableDrag: false,
            isDismissible: false,
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                64.0.height,
                const CardIcon(
                  image: AppImages.doneOutline,
                  padding: 30,
                  bgColor: AppColors.kGrey100,
                ),
                24.0.height,
                const SectionHeader(text: 'Transaction Failed'),
                8.0.height,
                const Text('Your request is unsuccessful.'),
                64.0.height,
                MainButton(
                    text: 'Try Again',
                    onPressed: () {
                      context.pop();
                      context.pop();
                    })
              ],
            ),
          );
        }
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: innerAppBar(title: ''),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
