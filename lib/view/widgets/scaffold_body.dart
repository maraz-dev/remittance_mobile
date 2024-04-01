import 'package:flutter/material.dart';

class ScaffoldBody extends StatelessWidget {
  final Widget body;
  const ScaffoldBody({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: body,
      ),
    );
  }
}
