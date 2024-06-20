import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/proof_of_address_upload_view.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';
import 'package:remittance_mobile/view/features/home/widgets/means_of_id_card.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ProofOfAddressView extends ConsumerStatefulWidget {
  static String path = '/proof-of-address-view';
  const ProofOfAddressView({super.key});

  @override
  ConsumerState<ProofOfAddressView> createState() => _ProofOfAddressViewState();
}

class _ProofOfAddressViewState extends ConsumerState<ProofOfAddressView> {
  @override
  Widget build(BuildContext context) {
    // Get Proof of Address List
    final proofOfAddressList = ref.watch(getProofOfAddressProvider);

    return Scaffold(
      appBar: innerAppBar(title: 'Proof Of Address'),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          children: [
            20.0.height,
            proofOfAddressList.maybeWhen(
              orElse: () => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 25,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
                separatorBuilder: (context, index) => 16.0.height,
                itemCount: 5,
              ),
              data: (data) => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var value = data[index];
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.pushNamed(ProofOfAddressUploadView.path);
                    },
                    child: MeansOfIDCard(
                      text: value.friendlyName ?? "",
                    ).animate().fadeIn(),
                  );
                },
                separatorBuilder: (context, index) => 16.0.height,
                itemCount: data.length,
              ),
              error: (error, stackTrace) {
                if (kDebugMode) print(stackTrace);
                return Center(
                  child: Text(
                    kDebugMode ? error.toString() : 'An Error Occured',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
