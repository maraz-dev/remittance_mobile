import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class TermsAndConditionsView extends StatelessWidget {
  static String path = 'terms-and-conditions-view';
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Terms and Conditions'),
      body: ScaffoldBody(body: Container()),
    );
  }
}
