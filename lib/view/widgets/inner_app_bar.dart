import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';

AppBar innerAppBar({
  required String title,
  Function()? backOnPressed,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: BackArrowButton(
      backOnPressed: backOnPressed,
    ),
    title: SectionHeader(text: title),
    shadowColor: Colors.black.withOpacity(0.5),
    elevation: 2,
  );
}
