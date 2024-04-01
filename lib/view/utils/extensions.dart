import 'package:flutter/material.dart';

extension DoubleExt on double {
  BorderRadius get toBorderRadius => BorderRadius.circular(this);

  /// a spacer widget
  Spacer get space => const Spacer();

  /// convert a double field to SizedBox with its height
  SizedBox get height => SizedBox(height: this);

  /// convert a double field to SizedBox with its widget
  SizedBox get width => SizedBox(width: this);
}
