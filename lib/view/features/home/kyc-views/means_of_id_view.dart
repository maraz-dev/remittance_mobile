import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/means_of_id_options.dart';
import 'package:remittance_mobile/view/features/home/widgets/means_of_id_card.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class MeansOfIdView extends StatelessWidget {
  static String path = '/means-of-id-view';
  const MeansOfIdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Means of ID'),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          children: [
            20.0.height,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var value = idOptionList[index];
                return MeansOfIDCard(
                  text: value.text,
                )
                    .animate()
                    .fadeIn()
                    .slideX(begin: 1, delay: 100.ms + (index * 30).ms);
              },
              separatorBuilder: (context, index) => 16.0.height,
              itemCount: idOptionList.length,
            ),
          ],
        ),
      )),
    );
  }
}
