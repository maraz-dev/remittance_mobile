import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const SectionHeader(text: 'Services'),
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.height,
              const SectionHeader(text: 'TRANSFERS'),
              10.0.height,
              const SectionHeader(text: 'BILL PAYMENT'),
              10.0.height,
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SvgPicture.asset(
                        AppImages.betting,
                        fit: BoxFit.scaleDown,
                      ),
                      Text(
                        'Betting',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.kSecondaryColor),
                      )
                    ],
                  );
                },
              ),
              const SectionHeader(text: 'EXCHANGE'),
              10.0.height,
              const SectionHeader(text: 'VIRTUAL CARDS'),
              10.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
