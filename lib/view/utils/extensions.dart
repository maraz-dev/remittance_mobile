import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// For SizedBox Spacing
extension DoubleExt on double {
  BorderRadius get toBorderRadius => BorderRadius.circular(this);

  /// a spacer widget
  Spacer get space => const Spacer();

  /// convert a double field to SizedBox with its height
  SizedBox get height => SizedBox(height: this);

  /// convert a double field to SizedBox with its widget
  SizedBox get width => SizedBox(width: this);
}

// For Currency Formatting on Double
extension Amount on double {
  /// For Currency Formatting on Double
  String amountWithCurrency(String symbol) {
    String currencySymbol = '₦';
    switch (symbol) {
      case 'ngn':
        currencySymbol = '₦';
        break;
      case 'usd':
        currencySymbol = '\$';
        break;
      case 'gbp':
        currencySymbol = '£';
        break;
      default:
        currencySymbol = '';
        break;
    }
    var formatter =
        NumberFormat.currency(symbol: currencySymbol, decimalDigits: 2);
    return formatter.format(this);
  }
}

// For Currency Formatting on Int
extension IntAmount on int {
  /// For Currency Formatting on Int
  String amountWithCurrency(String symbol) {
    String currencySymbol = '₦';
    switch (symbol) {
      case 'ngn':
        currencySymbol = '₦';
        break;
      case 'usd':
        currencySymbol = '\$';
        break;
      case 'gbp':
        currencySymbol = '£';
        break;
      default:
        currencySymbol = '';
        break;
    }
    var formatter =
        NumberFormat.currency(symbol: currencySymbol, decimalDigits: 0);
    return formatter.format(this);
  }
}

// For Color on SVG Assets
extension SvgColor on Color {
  /// For Color on SVG Assets
  ColorFilter colorFilterMode() {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}
