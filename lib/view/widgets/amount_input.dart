import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/validator.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String header;
  const AmountInput({
    super.key,
    required this.controller,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.bold),
        ),
        6.0.height,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.kGrey300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  cursorColor: AppColors.kGrey700,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validateGeneric,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: AppColors.kGrey700,
                      fontWeight: FontWeight.w500,
                      fontSize: 40.sp),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(
                            color: AppColors.kHintColor,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500),
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
                ),
              ),
              16.0.width,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.kGrey100,
                ),
                child: Row(
                  children: [
                    Text(
                      'NGN',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.kGrey700,
                          ),
                    ),
                    5.0.width,
                    InkWell(
                      child: SvgPicture.asset(AppImages.arrowDown),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          begin: 0,
          delay: 500.ms,
        )
        .slideY(
          begin: .5,
          end: 0,
        );
  }
}
