import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';

AppBar innerAppBar({required String title}) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: const BackArrowButton(),
    title: SectionHeader(text: title),
  );
}