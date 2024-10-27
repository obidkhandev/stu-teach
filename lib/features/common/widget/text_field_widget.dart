// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:scale_button/scale_button.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.onChange,
    required this.hintText,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscure,
    this.textInputAction,
    this.fillColor,
    this.initialValue,
    this.preIconColor,
    this.textEditingController,
    this.readOnly = false,
    this.onTap,
    this.formatter,
    required this.textInputType,
    this.maxLength,
    this.focusNode,
    this.suffixIconOnTap,
    this.borderColor,
    this.onFieldSubmitted,
    required this.label,
  });

  final TextEditingController? textEditingController;
  Function(String value)? onChange;
  final String hintText;
  final String label;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool? obscure;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? preIconColor;
  final Color? borderColor;
  final String? initialValue;
  FormFieldValidator<String>? validator;
  final int? maxLines;
  final TextInputType textInputType;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function()? suffixIconOnTap;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? formatter;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
        ),
        SizedBox(
          height: he(5),
        ),
        TextFormField(
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          validator: validator,
          readOnly: readOnly,
          focusNode: focusNode,
          inputFormatters: formatter,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          initialValue: initialValue,
          style: Theme.of(context).textTheme.titleMedium,
          obscureText: obscure ?? false,
          obscuringCharacter: "*",
          textInputAction: textInputAction,
          keyboardType: textInputType,
          onChanged: onChange,
          controller: textEditingController,
          cursorColor: AppColors.primaryColor,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            counterText: '',
            suffixIconConstraints:
                const BoxConstraints(minHeight: 25, minWidth: 25),
            prefixIcon: prefixIcon == null
                ? null
                : SvgPicture.asset(
                    prefixIcon ?? "",
                    height: he(20),
                    colorFilter: ColorFilter.mode(
                        preIconColor ?? AppColors.grey1, BlendMode.srcIn),
                  ).paddingAll(11),
            suffixIcon: suffixIcon == null
                ? null
                : ScaleButton(
                    onTap: suffixIconOnTap,
                    child: SvgPicture.asset(
                      suffixIcon ?? "",
                      height: he(20),
                      colorFilter: ColorFilter.mode(
                          preIconColor ?? AppColors.grey1, BlendMode.srcIn),
                    )).paddingAll(11),
            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400),
            hintText: hintText,
            filled: true,
            fillColor: fillColor ??
                (const Color(0xffF9FBFF)),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.grey3),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.grey3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.primaryColor,
                width: 1.2,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.grey3),
            ),
          ),
        ),
      ],
    );
  }
}
