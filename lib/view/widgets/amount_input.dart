import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String? header, currency, image;
  final bool? readOnly;
  final bool animate;
  final Color? textColor, color;
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
                      LengthLimitingTextInputFormatter(17),
                      NumberTextInputFormatter(
                        integerDigits: 12,
                        decimalDigits: 2,
                        prefix: '',
                        maxValue: '1000000000.00',
                        decimalSeparator: '.',
                        groupDigits: 3,
                        groupSeparator: ',',
                        allowNegative: false,
                        overrideDecimalPoint: true,
                        insertDecimalPoint: true,
                        insertDecimalDigits: true,
                      ),
                    ],
                    onChanged: onChanged,
                    onFieldSubmitted: onFieldSubmitted,
                  ),
                ),
                16.0.width,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  decoration: BoxDecoration(
                      color: color ?? AppColors.kGrey300, borderRadius: BorderRadius.circular(16)),
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
