import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';
import 'package:remittance_mobile/view/features/home/widgets/means_of_id_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ProofOfAddressSelectView extends ConsumerStatefulWidget {
  static String path = 'proof-of-address-select-view';
  const ProofOfAddressSelectView({
    super.key,
    required this.pressed,
  });

  final VoidCallback pressed;

  @override
  ConsumerState<ProofOfAddressSelectView> createState() =>
      _ProofOfAddressViewState();
}

class _ProofOfAddressViewState extends ConsumerState<ProofOfAddressSelectView> {
  @override
  Widget build(BuildContext context) {
    // Get Proof of Address List
    final proofOfAddressList = ref.watch(getProofOfAddressProvider);

    return ScaffoldBody(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.0.height,
            Text(
              'Choose your Preferred Means of Proof of Address.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.kGrey700),
            ),
            24.0.height,
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
                      widget.pressed();
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
      ),
    );
  }
}
