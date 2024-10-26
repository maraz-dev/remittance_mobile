import 'dart:math';

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
extension Amount on dynamic {
  /// For Currency Formatting on Double
  String amountWithCurrency(String symbol) {
    // String currencySymbol = '₦';
    // switch (symbol) {
    //   case 'ngn':
    //     currencySymbol = '₦';
    //     break;
    //   case 'usd':
    //     currencySymbol = '\$';
    //     break;
    //   case 'gbp':
    //     currencySymbol = '£';
    //     break;
    //   default:
    //     currencySymbol = '';
    //     break;
    // }
    var formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(this);
  }
}

extension CurrencyAmount on dynamic {
  String amountInt({
    int minDecimalPlaces = 2,
    int maxDecimalPlaces = 2,
    bool includeCommas = true,
  }) {
    if (this == null) {
      return "0.0";
    } else {
      // Convert the dynamic value to a double
      final doubleValue = (this is String)
          ? double.tryParse(this) ?? 0.0
          : (this is num)
              ? this.toDouble()
              : 0.0;

      // Create a number format
      var formatter = NumberFormat("#,##0");
      if (minDecimalPlaces > 0) {
        formatter.minimumFractionDigits = minDecimalPlaces;
        formatter.maximumFractionDigits = maxDecimalPlaces;
      }

      // Format the double value
      String result = formatter.format(doubleValue);

      // Optionally add commas
      if (includeCommas) {
        return result;
      } else {
        return result.replaceAll(',', '');
      }
    }
  }
}

// For Color on SVG Assets
extension SvgColor on Color {
  /// For Color on SVG Assets
  ColorFilter colorFilterMode() {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}

// Extension to Mask the Characters of a Phone Number aside the last 4 digits
extension MaskString on String {
  // Extension to Mask the Characters of a Phone Number aside the last 4 digits
  String mask() {
    if (length <= 4) {
      // Return the original string if it's 4 characters or less
      return this;
    }

    int len = length;
    String lastFour = substring(len - 4);
    String masked = '*' * 5;

    return masked + lastFour;
  }
}

extension ByteFormat on int {
  String formatBytes() {
    if (this <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (log(this) / log(1024)).floor();
    final size = this / pow(1024, i);
    return "${size.toInt()} ${suffixes[i]}";
  }
}

extension WidgetPadding on Widget {
  Widget widgetPadding({
    double l = 0.0,
    double t = 0.0,
    double r = 0.0,
    double b = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(l, t, r, b),
      child: this,
    );
  }
}

extension DecimalFormatter on dynamic {
  String formatDecimal({bool useCommas = true}) {
    // Return empty string if null
    if (this == null) return '';

    // Convert to double
    double value;
    try {
      value = double.parse(toString());
    } catch (e) {
      return toString();
    }

    // Get whole number and decimal parts
    List<String> parts = value.toString().split('.');
    String wholeNumber = parts[0];
    String decimal = parts.length > 1 ? parts[1] : '';

    // Format the number according to the decimal place rules
    String formattedNumber;

    // Case 1: If whole number is not 0, use 2 decimal places
    if (wholeNumber != '0') {
      formattedNumber = value.toStringAsFixed(2);
    }
    // Case 2: If whole number is 0
    else {
      // If decimal length > 5, use 5 decimal places
      if (decimal.length > 5) {
        formattedNumber = value.toStringAsFixed(5);
      }
      // Otherwise, use the original decimal length
      else {
        formattedNumber = decimal.isEmpty ? '0' : value.toString();
      }
    }

    // Add commas if requested
    if (useCommas) {
      List<String> parts = formattedNumber.split('.');
      parts[0] = _addCommas(parts[0]);
      formattedNumber = parts.join('.');
    }

    return formattedNumber;
  }

  // Helper method to add commas to the whole number part
  String _addCommas(String wholeNumber) {
    final StringBuffer result = StringBuffer();
    final bool isNegative = wholeNumber.startsWith('-');
    String numberToFormat = isNegative ? wholeNumber.substring(1) : wholeNumber;

    for (int i = 0; i < numberToFormat.length; i++) {
      if (i > 0 && (numberToFormat.length - i) % 3 == 0) {
        result.write(',');
      }
      result.write(numberToFormat[i]);
    }

    return isNegative ? '-${result.toString()}' : result.toString();
  }
}

extension TruncateString on String {
  String truncate(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return "${substring(0, maxLength)}...";
    }
  }
}

extension DateTimeExtension on DateTime {
  String to12HourFormat() {
    final hour = this.hour;
    final minute = this.minute;
    final period = hour >= 12 ? 'PM' : 'AM';

    // Convert 24-hour format to 12-hour format
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    // Add leading zero to minutes if needed
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$displayHour:$displayMinute$period';
  }
}
