import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';
import 'package:remittance_mobile/view/features/home/widgets/means_of_id_card.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class MeansOfIdSelectView extends ConsumerStatefulWidget {
  static String path = 'means-of-id-select-view.dart';
  final VoidCallback pressed;

  const MeansOfIdSelectView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<MeansOfIdSelectView> createState() =>
      _MeansOfIdSelectViewState();
}

class _MeansOfIdSelectViewState extends ConsumerState<MeansOfIdSelectView> {
  @override
  Widget build(BuildContext context) {
    // Get the Means of ID
    final meansOfIDList = ref.watch(getMeansOfIDProvider);

    return ScaffoldBody(
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
                  return MeansOfIDCard(
                    text: value.friendlyName ?? "",
                    onPressed: () {
                      widget.pressed();
                    },
                  ).animate().fadeIn();
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
