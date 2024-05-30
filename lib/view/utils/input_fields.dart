import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class TextInput extends StatelessWidget {
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? header;
  final String hint;
  final bool readOnly;
  final Function()? onPressed;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon, suffixIcon;
  const TextInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.inputType,
    required this.validator,
    this.maxLength,
    this.readOnly = false,
    this.onPressed,
    this.header,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header ?? "",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.bold),
        ),
        header != null ? 6.0.height : 0.0.height,
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          maxLength: maxLength,
          cursorColor: AppColors.kGrey700,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          readOnly: readOnly,
          onTap: onPressed,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.kHintColor),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
        )
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

class PasswordInput extends StatefulWidget {
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? header;
  final String hint;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const PasswordInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.inputType,
    required this.validator,
    this.maxLength,
    this.header,
    this.inputFormatters,
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
          widget.header ?? "",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.bold),
        ),
        widget.header != null ? 6.0.height : 0.0.height,
        TextFormField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          cursorColor: AppColors.kGrey700,
          keyboardType: widget.inputType,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          obscuringCharacter: '*',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.kGrey700, fontWeight: FontWeight.w500),
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
                  .bodyMedium!
                  .copyWith(color: AppColors.kHintColor)),
        )
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
