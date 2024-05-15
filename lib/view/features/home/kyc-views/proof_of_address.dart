import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remittance_mobile/view/features/home/kyc-views/means_of_id_options.dart';
import 'package:remittance_mobile/view/features/home/widgets/means_of_id_card.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ProofOfAddressView extends StatelessWidget {
  static String path = '/proof-of-address-view';
  const ProofOfAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Proof Of Address'),
      body: ScaffoldBody(
          body: SingleChildScrollView(
        child: Column(
          children: [
            20.0.height,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var value = proofOfAddressList[index];
                return MeansOfIDCard(
                  text: value.text,
                )
                    .animate()
                    .fadeIn()
                    .slideX(begin: 1, end: 0, delay: 100.ms + (index * 30).ms);
              },
              separatorBuilder: (context, index) => 16.0.height,
              itemCount: proofOfAddressList.length,
            ),
          ],
        ),
      )),
    );
  }
}
