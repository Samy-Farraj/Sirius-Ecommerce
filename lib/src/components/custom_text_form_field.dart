import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';
import '../themes/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final bool obsecureText;
  final FormFieldValidator? validate;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final double? height;
  final bool enabled;
  final String? errorText;
  final TextStyle errorTextStyle;
  final Widget? prefix;
  final Widget? suffixIcon;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool isDateTime;
  final bool isPassword;
  bool isShowPassword;
  final bool readOnly;
  final Function(DateTime)? onChangeDateTime;
  final Function(String)? onChange;
  final void Function(String)? onFieldSubmitted;
  final DateTime? initialDateTime;
  final TextAlign? textAlign;
  final List<TextInputFormatter> inputFormatters;
  final String? hintText;
  final Color? backgroundColor;
  final Color? cursorColor;
  final Color? controllerColor;
  final Color? borderColor;
  final Color? labelColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final VoidCallback? onEditingComplete;
  final double? borderRadius;
  final TextStyle? labelStyle;
  final bool? isMultiLines;
  CustomTextFormField({
    this.label,
    this.obsecureText = false,
    this.validate,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.enabled = true,
    this.errorText,
    this.height,
    this.errorTextStyle = const TextStyle(fontSize: 16.0, color: Colors.grey),
    this.prefix,
    this.suffixIcon,
    this.maxLines,
    this.onTap,
    this.isDateTime = false,
    this.isShowPassword = false,
    this.isPassword = false,
    this.readOnly = false,
    this.autofocus = false,
    this.onChangeDateTime,
    this.onChange,
    this.initialDateTime,
    this.onFieldSubmitted,
    this.textAlign,
    this.inputFormatters = const [],
    this.hintText,
    super.key,
    this.fillColor,
    this.backgroundColor,
    this.cursorColor,
    this.controllerColor,
    this.borderColor,
    this.labelColor,
    this.contentPadding,
    this.focusNode,
    this.textCapitalization,
    this.onEditingComplete,
    this.borderRadius,
    this.labelStyle,
    this.isMultiLines,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {}); // Update state when focus changes
    });
    _errorText = widget.errorText;
  }

  String? _errorText;
  @override
  Widget build(BuildContext context) {
    TextAlign localeTextAlign =
        Localizations.localeOf(context).languageCode == "en"
            ? TextAlign.left
            : TextAlign.right;
    TextAlign textAlign = widget.textAlign ?? localeTextAlign;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: widget.height ?? 45.h,
          padding: EdgeInsets.all(2.sp),
          decoration: BoxDecoration(
              color: widget.backgroundColor == null
                  ? Colors.white
                  : widget.backgroundColor,
              border: Border.all(
                color: _focusNode.hasFocus
                    ? (widget.borderColor ??
                        Colors.transparent) // Focused border color
                    : (widget.borderColor ??
                        Colors.transparent), // Default border color
                width: 1,
              ),
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
          // padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Directionality(
            textDirection: textAlign == TextAlign.right
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: TextFormField(
              onEditingComplete: widget.onEditingComplete,
              autofocus: widget.autofocus,
              focusNode:
                  widget.focusNode == null ? _focusNode : widget.focusNode,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              style: TextStyle(
                  color: widget.enabled == false
                      ? Colors.grey
                      : widget.controllerColor != null
                          ? widget.controllerColor
                          : AppColors.dark),
              controller: widget.controller,
              enabled: !widget.isDateTime && widget.enabled,
              maxLines: widget.maxLines ?? 1,
              readOnly: widget.readOnly,
              textAlign: textAlign,
              onFieldSubmitted: widget.onFieldSubmitted,
              onTap: widget.onTap ??
                  (widget.isDateTime
                      ? () async {
                          DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate:
                                  widget.initialDateTime ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2040));
                          if (dateTime != null) {
                            if (widget.onChangeDateTime != null) {
                              widget.onChangeDateTime!(dateTime);
                            }
                          }
                        }
                      : null),
              validator: (value) {
                if (widget.validate != null) {
                  String? validateMessage = widget.validate!(value);
                  setState(() {
                    _errorText = validateMessage;
                  });
                  return validateMessage;
                } else {
                  return null;
                }
              },
              cursorColor: widget.cursorColor == null
                  ? AppColors.dark
                  : widget.cursorColor,
              obscureText: widget.isShowPassword
                  ? !widget.obsecureText
                  : widget.obsecureText,
              maxLength: widget.maxLength,
              // textAlign: widget.textAlign,
              onChanged: (txt) {
                if (txt.isNotEmpty) {
                  setState(() {
                    _errorText = null;
                  });
                  if (widget.onChange != null) {
                    widget.onChange!(txt);
                  }
                }
              },
              keyboardType: widget.keyboardType,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                  focusedBorder: inputDecorationTheme.focusedBorder,
                  enabledBorder: inputDecorationTheme.enabledBorder,
                  disabledBorder: inputDecorationTheme.disabledBorder,
                  errorBorder: inputDecorationTheme.errorBorder,
                  fillColor: widget.fillColor == null
                      ? AppColors.backGroundButtonGrey
                      : widget.fillColor,
                  filled: true,
                  contentPadding: widget.contentPadding,
                  prefixIcon: widget.prefix,
                  label: widget.label != null
                      ? Directionality(
                          textDirection: localeTextAlign == TextAlign.right
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(widget.label!,
                                      style: widget.labelStyle == null
                                          ? TextStyle(
                                              color: widget.enabled == false
                                                  ? Colors.grey
                                                  : widget.labelColor == null
                                                      ? Colors.white
                                                      : widget.labelColor!)
                                          : widget.labelStyle),
                                  widget.isMultiLines == true
                                      ? SizedBox(
                                          height: 100.h,
                                        )
                                      : SizedBox(
                                          height: 0.h,
                                        )
                                ],
                              ),
                            ],
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  errorStyle: const TextStyle(height: -1, fontSize: 0),
                  errorMaxLines: 1,
                  counterText: "",
                  hintStyle: textTheme.bodySmall,
                  hintText: widget.hintText,
                  suffixIcon: widget.isDateTime
                      ? GestureDetector(
                          onTap: widget.onTap != null
                              ? (() async {
                                  DateTime? dateTime = await showDatePicker(
                                      context: context,
                                      initialDate: widget.initialDateTime ??
                                          DateTime.now(),
                                      firstDate: DateTime(1930),
                                      lastDate: DateTime(2040));
                                  if (dateTime != null) {
                                    if (widget.onChangeDateTime != null) {
                                      widget.onChangeDateTime!(dateTime);
                                    }
                                  }
                                })
                              : null,
                          child: const Icon(Icons.calendar_today_rounded))
                      : widget.isPassword
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.isShowPassword =
                                      !widget.isShowPassword;
                                });
                              },
                              icon: Icon(
                                widget.isShowPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility_sharp,
                                color: Colors.black,
                              ))
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, top: 8.h),
                              child: widget.suffixIcon,
                            )),
              inputFormatters: widget.inputFormatters,
            ),
          ),
        ),
        _errorText != null
            ? Container(
                padding: const EdgeInsets.only(right: 20.0, top: 5.0),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.error_outline_rounded,
                        size: 20.0, color: Colors.red),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(_errorText!,
                              style: widget.errorTextStyle
                                  .merge(TextStyle(color: Colors.red)))),
                    )
                  ],
                ))
            : Container(),
      ],
    );
  }
}

class CustomBirthDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
