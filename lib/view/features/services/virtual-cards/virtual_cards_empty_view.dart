import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class VirtualCardEmptyView extends StatelessWidget {
  static String path = 'virtual-card-empty-view';
  const VirtualCardEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Virtual Cards'),
      body: ScaffoldBody(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          80.0.height,
          SvgPicture.asset(AppImages.human),
          Text(
            'Nothing to See Here',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kErrorColor, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Your most recent transcations will show up here when you start transacting.',
              textAlign: TextAlign.center,
            ),
          ),
          16.0.height,
          MainButton(text: 'Create New Card', onPressed: () {})
        ],
      )),
    );
  }
}
