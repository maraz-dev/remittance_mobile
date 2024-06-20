import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/means_of_id_capture_view.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';
import 'package:remittance_mobile/view/features/home/widgets/means_of_id_card.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class MeansOfIdView extends ConsumerStatefulWidget {
  static String path = '/means-of-id-view';
  const MeansOfIdView({super.key});

  @override
  ConsumerState<MeansOfIdView> createState() => _MeansOfIdViewState();
}

class _MeansOfIdViewState extends ConsumerState<MeansOfIdView> {
  @override
  Widget build(BuildContext context) {
    // Get the Means of ID
    final meansOfIDList = ref.watch(getMeansOfIDProvider);

    return Scaffold(
      appBar: innerAppBar(title: 'Means of ID'),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          children: [
            20.0.height,
            meansOfIDList.maybeWhen(
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
                      context.pushNamed(MeansOfIdCaptureView.path);
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
