import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/id_back_capture_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/id_back_captured_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/id_front_captured_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/id_number_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/means_of_id_select_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/means-of-id-flow/id_front_capture_view.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';

class MeansOfIdView extends ConsumerStatefulWidget {
  static String path = 'means-of-id-view';
  const MeansOfIdView({super.key});

  @override
  ConsumerState<MeansOfIdView> createState() => _MeansOfIdViewState();
}

class _MeansOfIdViewState extends ConsumerState<MeansOfIdView> {
  /// Controllers
  final PageController _meansOfIdPageController =
      PageController(viewportFraction: 1.0, keepPage: true);
  final PageStorageKey<String> _pageStorageKey =
      const PageStorageKey<String>('meansOfIdPageViewKey');

  int pageCount = 0;

  @override
  void dispose() {
    _meansOfIdPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(
        title: 'Means of ID',
        backOnPressed: () {
          pageCount == 0
              ? context.pop()
              : _meansOfIdPageController.previousPage(
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
            controller: _meansOfIdPageController,
            key: _pageStorageKey,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() => pageCount = value);
            },
            children: [
              MeansOfIdSelectView(
                pressed: () {
                  _meansOfIdPageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              IdNumberView(
                pressed: () {
                  _meansOfIdPageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              IdFrontCaptureView(
                pressed: () {
                  _meansOfIdPageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              IdFrontCapturedView(
                controller: _meansOfIdPageController,
                pressed: () {
                  _meansOfIdPageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              IdBackCaptureView(
                pressed: () {
                  _meansOfIdPageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              IdBackCapturedView(
                controller: _meansOfIdPageController,
                pressed: () {
                  _meansOfIdPageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
