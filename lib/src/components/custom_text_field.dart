import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/locale_keys.g.dart';
import '../extensions/iterable_extension.dart';
import '../extensions/string_extension.dart';
import '../extensions/widget_extension.dart';
import '../themes/app_colors.dart';
import '../themes/app_icons.dart';
import '../themes/app_theme.dart';
import '../validation/base_validator.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.suffixIcon,
    this.initialValue,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      width: 352.w,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFECECEC)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        initialValue: initialValue,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.lightest),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.lightest),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(8)),
          hintText: hint,
          hintStyle: textTheme.titleLarge!
              .copyWith(color: AppColors.white.withOpacity(0.4)),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    Key? key,
    required this.title,
    required this.widget,
    this.optional = false,
  }) : super(key: key);
  final String title;
  final Widget widget;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.black,
              ),
            ),
            if (optional)
              Text(
                LocaleKeys.optional.tr(),
                style: textTheme.bodyLarge!.copyWith(
                  color: AppColors.red,
                ),
              ),
          ],
        ),
        widget,
      ].addSpaces(height: 8.h).toList(),
    );
  }
}

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget({
    Key? key,
    this.controller,
    this.prefix,
    this.hideText = false,
    this.onSubmit,
    this.width,
    this.onChanged,
    this.label,
    this.hintText,
    this.secure = false,
    this.validator,
    this.prefixConstraint,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.keyboardType,
    this.focusNode,
    this.onTap,
    this.inputFormatters,
    this.suffixIcon,
    this.initialValue,
    this.enabled,
    this.readOnly = false,
    this.maxLines = 1,
    this.isMultiline = false,
    this.contentPadding,
    this.formKey,
    this.textStyle,
    this.textDirection,
  })  : assert(secure == false || suffixIcon == null),
        super(key: key);

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? prefix;
  bool hideText;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final Function()? onTap;
  final double? width;
  final String? label;
  final bool secure;
  final bool? enabled;
  final bool? readOnly;
  final bool isMultiline;
  final BaseValidator? validator;
  final BoxConstraints? prefixConstraint;
  final TextAlign textAlign;
  final int? maxLength;
  final int maxLines;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? suffixIcon;
  final String? initialValue;
  final REdgeInsets? contentPadding;
  final GlobalKey<FormState>? formKey;
  final TextStyle? textStyle;
  final ui.TextDirection? textDirection;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isFieldValid = false;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.textStyle ??
          textTheme.bodyMedium!.copyWith(color: AppColors.dark),
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onSubmit,

      controller: widget.controller,
      textDirection: widget.textDirection,
      obscureText: widget.hideText,
      readOnly: widget.readOnly ?? false,
      enabled: widget.enabled,
      maxLines: widget.isMultiline ? null : widget.maxLines,
      textAlign: widget.textAlign,
      validator: widget.validator?.validator,
      inputFormatters: [
        ...?widget.inputFormatters,
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      onChanged: (text) {
        if (widget.validator != null) {
          String? validationResult = widget.validator!.validator(text);
          setState(() {
            if (validationResult == null) {
              isFieldValid = true;
              errorText = null;
            } else {
              isFieldValid = false;
              errorText = validationResult;
            }
          });
        }
        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
      },
      onTap: widget.onTap,
      decoration: InputDecoration(
        filled: true,
        counterStyle: textTheme.bodyLarge!.copyWith(color: AppColors.medium),
        fillColor: Colors.transparent,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        hintText: widget.hintText,
        hintStyle: textTheme.bodyMedium!.copyWith(color: AppColors.grey),
        labelText: widget.label,
        labelStyle: textTheme.bodyLarge?.copyWith(color: AppColors.hintText),
        prefixIcon: widget.prefix,
        prefixIconColor: AppColors.medium,
        errorStyle: textTheme.bodyLarge?.copyWith(color: AppColors.hintText),
        suffixIconColor: AppColors.medium,
        prefixIconConstraints: widget.prefixConstraint,
        suffixIcon: widget.secure ? secureWidget : widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.medium, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.medium, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // decoration: InputDecoration(
      //   // TODO: Responsive Padding (Test on web)
      //   contentPadding: (widget.contentPadding == null && 1.sw >= 650)
      //       ? EdgeInsets.all(24.h)
      //       : widget.contentPadding,
      //   counterText: '',
      //   hintText: widget.hintText,
      //   hintStyle: textTheme.titleLarge?.copyWith(color: AppColors.dark),
      //   prefixIcon: widget.prefix,
      //   prefixIconConstraints: widget.prefixConstraint,
      //   labelText: widget.label,
      //   labelStyle: textTheme.titleLarge?.copyWith(color: AppColors.dark),
      //   suffixIcon: widget.secure ? secureWidget : widget.suffixIcon,
      //   focusedErrorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: isFieldValid ? Colors.green : Colors.red,
      //       ),
      //       borderRadius: BorderRadius.circular(8)),
      //   errorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: isFieldValid ? Colors.green : Colors.red,
      //       ),
      //       borderRadius: BorderRadius.circular(8)),
      //   focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: isFieldValid ? Colors.green : AppColors.primary,
      //       ),
      //       borderRadius: BorderRadius.circular(8)),
      //   errorMaxLines: 2,
      //   errorText: isFieldValid ? null : errorText,
      //   errorStyle: !isFieldValid
      //       ? null
      //       : const TextStyle(
      //           height: 0, color: Colors.transparent, fontSize: 0),
      // ),
    ).size(w: widget.width);
  }

  Widget get secureWidget => IconButton(
      onPressed: () {
        setState(() {
          widget.hideText = !widget.hideText;
        });
      },
      icon: widget.hideText
          ? Icon(
              size: 19.sp,
              Icons.remove_red_eye_outlined,
              color: Colors.grey,
            )
          : Icon(
              size: 19.sp,
              Icons.remove_red_eye_rounded,
              color: Colors.grey,
            ));
}
