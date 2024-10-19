import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final double? fontSize;
  const SectionHeader({
    super.key,
    required this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: fontSize,
          ),
    );
  }
}
