import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/profile/widgets/contact_card.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class HelpAndSupportView extends StatefulWidget {
  static String path = 'help-and-support-view';
  const HelpAndSupportView({super.key});

  @override
  State<HelpAndSupportView> createState() => _HelpAndSupportViewState();
}

class _HelpAndSupportViewState extends State<HelpAndSupportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Help And Support'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              16.0.height,
              const Text(
                "If you have any issues within our platform you’d like us to solve, contact us today.",
              ),
              16.0.height,
              const ContactCard(
                text: 'Reach Us on Whatsapp',
                subtitle: '+234 703 445 5709',
              ),
              12.0.height,
              const ContactCard(
                text: 'Send Us an Email',
                subtitle: 'hello@errandpay.com',
                image: AppImages.emailButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
