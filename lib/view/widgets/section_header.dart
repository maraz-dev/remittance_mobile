import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  const SectionHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
