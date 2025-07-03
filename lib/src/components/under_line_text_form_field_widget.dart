import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/features/auth/presentation/widgets/choose_country_widget.dart';
import '../../generated/locale_keys.g.dart';
import '../extensions/iterable_extension.dart';
import '../extensions/string_extension.dart';
import '../extensions/widget_extension.dart';
import '../themes/app_colors.dart';
import '../themes/app_icons.dart';
import '../themes/app_theme.dart';
import '../validation/base_validator.dart';

class UnderLineTextFormFieldWidget extends StatefulWidget {
  UnderLineTextFormFieldWidget({
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
    this.inputFormatters,
    this.suffixIcon,
    this.initialValue,
    this.enabled,
    this.maxLines = 1,
    this.isMultiline = false,
    this.contentPadding,
    this.formKey,
    this.textStyle,
    this.textDirection =
        ui.TextDirection.ltr, // جعل الاتجاه الافتراضي من اليسار
  })  : assert(secure == false || suffixIcon == null),
        super(key: key);

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? prefix;
  bool hideText;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final double? width;
  final String? label;
  final bool secure;
  final bool? enabled;
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
  State<UnderLineTextFormFieldWidget> createState() =>
      _UnderLineTextFormFieldWidgetState();
}

class _UnderLineTextFormFieldWidgetState
    extends State<UnderLineTextFormFieldWidget> {
  bool isFieldValid = false;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.textStyle?.copyWith(
        color: AppColors.dark, // تأكد من أن لون النص مرئي
      ),
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onSubmit,

      controller: widget.controller,
      textDirection: widget.textDirection, // استخدام الاتجاه المحدد
      obscureText: widget.hideText,
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
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,

        hintText: widget.hintText,
        hintStyle: textTheme.labelLarge?.copyWith(color: Colors.grey),
        labelText: widget.label,
        labelStyle: textTheme.labelLarge?.copyWith(color: AppColors.dark),
        // prefixIcon: ChooseCountryWidget(),
        prefixIconConstraints: widget.prefixConstraint,
        suffixIcon: widget.secure ? secureWidget : widget.suffixIcon,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.dark),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.dark),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    ).size(w: widget.width);
  }

  Widget get secureWidget => IconButton(
      onPressed: () {
        setState(() {
          widget.hideText = !widget.hideText;
        });
      },
      icon: widget.hideText
          ? const Icon(Icons.remove_red_eye_outlined)
          : AppIcons.eyeSlash.svg());
}
