import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/prood-of-address-flow/proof_of_address_select_view.dart';
import 'package:remittance_mobile/view/features/home/complete-profile/prood-of-address-flow/proof_of_address_upload_view.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';

class ProofOfAddressView extends ConsumerStatefulWidget {
  static String path = 'proof-of-address-view';
  const ProofOfAddressView({super.key});

  @override
  ConsumerState<ProofOfAddressView> createState() => _ProofOfAddressViewState();
}

class _ProofOfAddressViewState extends ConsumerState<ProofOfAddressView> {
  /// Controllers
  final PageController _poaPageController =
      PageController(viewportFraction: 1.0, keepPage: true);
  final PageStorageKey<String> _pageStorageKey =
      const PageStorageKey<String>('poaPageViewKey');

  int pageCount = 0;

  @override
  void dispose() {
    _poaPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(
        title: 'Proof of Address',
        backOnPressed: () {
          pageCount == 0
              ? context.pop()
              : _poaPageController.previousPage(
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
            controller: _poaPageController,
            key: _pageStorageKey,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() => pageCount = value);
            },
            children: [
              ProofOfAddressSelectView(
                pressed: () {
                  _poaPageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              ProofOfAddressUploadView(
                pressed: () {
                  _poaPageController.nextPage(
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
