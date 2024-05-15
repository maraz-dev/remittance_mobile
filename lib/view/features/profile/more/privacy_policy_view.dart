import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class PrivacyPolicyView extends StatelessWidget {
  static String path = 'privacy-policy-view';
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Privacy Policy'),
      body: ScaffoldBody(body: Container()),
    );
  }
}
