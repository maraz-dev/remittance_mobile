import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay_mobile/view/theme/app_colors.dart';
import 'package:smart_pay_mobile/view/utils/app_images.dart';

class TextInput extends StatelessWidget {
  final String fieldName;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final Function()? onPressed;
  final int? maxLength;
  const TextInput({
    super.key,
    required this.fieldName,
    required this.controller,
    required this.hint,
    required this.inputType,
    required this.validator,
    this.maxLength,
    this.readOnly = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          readOnly: readOnly,
          onTap: onPressed,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.kTextColor.withOpacity(0.5))),
        )
      ],
    );
  }
}

class PasswordInput extends StatefulWidget {
  final String fieldName;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hint;
  final int? maxLength;
  const PasswordInput({
    super.key,
    required this.fieldName,
    required this.controller,
    required this.hint,
    required this.inputType,
    required this.validator,
    this.maxLength,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          keyboardType: widget.inputType,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          obscuringCharacter: '•',
          decoration: InputDecoration(
              suffixIcon: IconButton(
                splashRadius: 1,
                onPressed: () {
                  setState(() => obscureText = !obscureText);
                },
                icon: SvgPicture.asset(
                  obscureText ? AppImages.eyeSlash : AppImages.eye,
                  colorFilter: const ColorFilter.mode(
                      AppColors.kInactiveColor, BlendMode.srcIn),
                ),
                iconSize: 19,
              ),
              hintText: widget.hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.kTextColor.withOpacity(0.5))),
        )
      ],
    );
  }
}
