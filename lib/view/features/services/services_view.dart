import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/services/services_options.dart';
import 'package:remittance_mobile/view/features/services/widgets/services_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class ServicesView extends StatelessWidget {
  static String path = '/services-view';
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

              /// TRANSFER
              const SectionHeader(text: 'TRANSFERS'),
              10.0.height,
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisExtent: 100.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: servicesTransferUtilities.length,
                itemBuilder: (context, index) {
                  var value = servicesTransferUtilities[index];
                  return InkWell(
                    onTap: () => context.pushNamed(value.screenPath),
                    child: ServicesCard(
                      text: value.text,
                      image: value.image,
                    ),
                  );
                },
              ),
              32.0.height,

              /// BILL PAYMENT
              const SectionHeader(text: 'BILL PAYMENT'),
              10.0.height,
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: servicesBillsPaymentUtilities.length,
                itemBuilder: (context, index) {
                  var value = servicesBillsPaymentUtilities[index];
                  return InkWell(
                    onTap: () => context.pushNamed(value.screenPath),
                    child: ServicesCard(
                      text: value.text,
                      image: value.image,
                    ),
                  );
                },
              ),
              32.0.height,

              /// EXCHANGE
              const SectionHeader(text: 'EXCHANGE'),
              10.0.height,
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: servicesExchangeUtilities.length,
                itemBuilder: (context, index) {
                  var value = servicesExchangeUtilities[index];
                  return InkWell(
                    onTap: null,
                    child: ServicesCard(
                      text: value.text,
                      image: value.image,
                    ),
                  );
                },
              ),
              32.0.height,

              /// VIRTUAL CARDS
              const SectionHeader(text: 'VIRTUAL CARDS'),
              10.0.height,
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: servicesVirtualCardUtilities.length,
                itemBuilder: (context, index) {
                  var value = servicesVirtualCardUtilities[index];
                  return InkWell(
                    onTap: () => context.pushNamed(value.screenPath),
                    child: ServicesCard(
                      text: value.text,
                      image: value.image,
                    ),
                  );
                },
              ),
              32.0.height,
            ],
          ),
        ),
      ),
    );
  }
}
