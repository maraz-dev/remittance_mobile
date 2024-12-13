import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'dart:math' as math;

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String? header, currency, image;
  final bool? readOnly;
  final bool animate;
  final Color? textColor, color, currencyColor;
  final double? fontSize;
  final Function(String)? onChanged, onFieldSubmitted;

  const AmountInput({
    super.key,
    required this.controller,
    this.header,
    this.readOnly,
    this.animate = true,
    this.currency,
    this.image,
    this.color,
    this.textColor,
    this.onChanged,
    this.onFieldSubmitted,
    this.fontSize,
    this.currencyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: animate
          ? [
              FadeEffect(
                begin: 0,
                delay: 200.ms,
              ),
              const SlideEffect(
                begin: Offset(0, .5),
                end: Offset(0, 0),
              )
            ]
          : [],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[
            Text(
              header ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.bold),
            ),
            6.0.height,
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: color ?? AppColors.kGrey200,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: readOnly ?? false,
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    cursorColor: AppColors.kGrey700,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'This field cannot be empty';
                      } else if (double.parse(value?.replaceAll(',', '') ?? '0.0') <= 0) {
                        return 'Amount must be greater than 0';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColors.kGrey700,
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize ?? 40.sp),
                    decoration: InputDecoration(
                      fillColor: color,
                      hintText: '0.00',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: AppColors.kHintColor,
                            fontSize: fontSize ?? 40.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                      LengthLimitingTextInputFormatter(17),
                      ThousandsFormatter(
                        allowFraction: true,
                        formatter: NumberFormat.decimalPattern(),
                      ),
                      // NumberTextInputFormatter(
                      //   integerDigits: 12,
                      //   decimalDigits: 2,
                      //   prefix: '',
                      //   maxValue: '1000000000.00',
                      //   decimalSeparator: '.',
                      //   groupDigits: 3,
                      //   groupSeparator: ',',
                      //   allowNegative: false,
                      //   overrideDecimalPoint: true,
                      //   insertDecimalPoint: true,
                      //   insertDecimalDigits: true,
                      // ),
                    ],
                    onChanged: onChanged,
                    onFieldSubmitted: onFieldSubmitted,
                  ),
                ),
                16.0.width,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  decoration: BoxDecoration(
                      color: currencyColor ?? AppColors.kGrey300,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    currency ?? 'TBS',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.kGrey700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThousandsFormatter extends NumberInputFormatter {
  //static final NumberFormat _formatter = NumberFormat.decimalPattern();

  final FilteringTextInputFormatter _decimalFormatter;
  final String _decimalSeparator;
  final RegExp _decimalRegex;

  final NumberFormat formatter;
  final bool allowFraction;

  ThousandsFormatter({required this.formatter, this.allowFraction = false})
      : _decimalSeparator = (formatter).symbols.DECIMAL_SEP,
        _decimalRegex =
            RegExp(allowFraction ? '[0-9]+([${(formatter).symbols.DECIMAL_SEP}])?' : r'\d+'),
        _decimalFormatter = FilteringTextInputFormatter.allow(
            RegExp(allowFraction ? '[0-9]+([${(formatter).symbols.DECIMAL_SEP}])?' : r'\d+'));

  @override
  String _formatPattern(String digits) {
    if (digits.isEmpty) return digits;
    num number;
    if (allowFraction) {
      String decimalDigits = digits;
      if (_decimalSeparator != '.') {
        decimalDigits = digits.replaceFirst(RegExp(_decimalSeparator), '.');
      }
      number = double.tryParse(decimalDigits) ?? 0.0;
    } else {
      number = int.tryParse(digits) ?? 0;
    }
    final result = (formatter).format(number);
    if (allowFraction && digits.endsWith(_decimalSeparator)) {
      return '$result$_decimalSeparator';
    }

    // Fix the .0 or .01 or .10 and similar issues
    if (digits.contains('.')) {
      List<String> decimalPlacesValue = digits.split(".");
      String decimalOnly = decimalPlacesValue[1];
      double? digitsOnly = double.tryParse(decimalPlacesValue[0]);
      String result = (formatter).format(digitsOnly);
      result = '$result.$decimalOnly';
      return result;
    }
    return result;
  }

  @override
  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue) {
    return _decimalFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool _isUserInput(String s) {
    return s == _decimalSeparator || _decimalRegex.firstMatch(s) != null;
  }
}

abstract class NumberInputFormatter extends TextInputFormatter {
  TextEditingValue? _lastNewValue;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    /// nothing changes, nothing to do
    if (newValue.text == _lastNewValue?.text) {
      return newValue;
    }
    _lastNewValue = newValue;

    /// remove all invalid characters
    newValue = _formatValue(oldValue, newValue);

    /// current selection
    int selectionIndex = newValue.selection.end;

    /// format original string, this step would add some separator
    /// characters to original string
    final newText = _formatPattern(newValue.text);

    /// count number of inserted character in new string
    int insertCount = 0;

    /// count number of original input character in new string
    int inputCount = 0;
    for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (_isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    /// adjust selection according to number of inserted characters staying before
    /// selection
    selectionIndex += insertCount;
    selectionIndex = math.min(selectionIndex, newText.length);

    /// if selection is right after an inserted character, it should be moved
    /// backward, this adjustment prevents an issue that user cannot delete
    /// characters when cursor stands right after inserted characters
    if (selectionIndex - 1 >= 0 &&
        selectionIndex - 1 < newText.length &&
        !_isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selectionIndex),
        composing: TextRange.empty);
  }

  /// check character from user input or being inserted by pattern formatter
  bool _isUserInput(String s);

  /// format user input with pattern formatter
  String _formatPattern(String digits);

  /// validate user input
  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue);
}
