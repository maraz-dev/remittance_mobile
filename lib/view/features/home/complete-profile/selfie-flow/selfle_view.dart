import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfie_capture_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/selfie-flow/selfie_captured_view.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';

class SelfieView extends ConsumerStatefulWidget {
  static String path = 'selfie-view';
  const SelfieView({super.key});

  @override
  ConsumerState<SelfieView> createState() => _SelfieViewState();
}

class _SelfieViewState extends ConsumerState<SelfieView> {
  /// Controllers
  final PageController _selfiePageController =
      PageController(viewportFraction: 1.0, keepPage: true);
  final PageStorageKey<String> _pageStorageKey =
      const PageStorageKey<String>('selfiePageViewKey');

  int pageCount = 0;

  @override
  void dispose() {
    _selfiePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(
        title: 'Selfie',
        backOnPressed: () {
          pageCount == 0
              ? context.pop()
              : _selfiePageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: PageStorage(
          bucket: PageStorageBucket(),
          child: PageView(
            controller: _selfiePageController,
            key: _pageStorageKey,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() => pageCount = value);
            },
            children: [
              SelfieCaptureView(
                pressed: () {
                  _selfiePageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              SelfieCapturedView(
                pressed: () {
                  _selfiePageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
