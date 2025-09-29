import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';
import '../themes/app_theme.dart';
//
// class CustomTextFormField extends StatefulWidget {
//   final String? label;
//   final bool obsecureText;
//   final FormFieldValidator? validate;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final int? maxLength;
//   final double? height;
//   final bool enabled;
//   final String? errorText;
//   final TextStyle errorTextStyle;
//   final Widget? prefix;
//   final Widget? suffixIcon;
//   final int? maxLines;
//   final VoidCallback? onTap;
//   final bool isDateTime;
//   final bool isPassword;
//   bool isShowPassword;
//   final bool readOnly;
//   final Function(DateTime)? onChangeDateTime;
//   final Function(String)? onChange;
//   final void Function(String)? onFieldSubmitted;
//   final DateTime? initialDateTime;
//   final TextAlign? textAlign;
//   final List<TextInputFormatter> inputFormatters;
//   final String? hintText;
//   final Color? backgroundColor;
//   final Color? cursorColor;
//   final Color? controllerColor;
//   final Color? borderColor;
//   final Color? labelColor;
//   final Color? fillColor;
//   final EdgeInsetsGeometry? contentPadding;
//   final bool autofocus;
//   final FocusNode? focusNode;
//   final TextCapitalization? textCapitalization;
//   final VoidCallback? onEditingComplete;
//   final double? borderRadius;
//   final TextStyle? labelStyle;
//   final bool? isMultiLines;
//   CustomTextFormField({
//     this.label,
//     this.obsecureText = false,
//     this.validate,
//     required this.controller,
//     this.keyboardType = TextInputType.text,
//     this.maxLength,
//     this.enabled = true,
//     this.errorText,
//     this.height,
//     this.errorTextStyle = const TextStyle(fontSize: 16.0, color: Colors.grey),
//     this.prefix,
//     this.suffixIcon,
//     this.maxLines,
//     this.onTap,
//     this.isDateTime = false,
//     this.isShowPassword = false,
//     this.isPassword = false,
//     this.readOnly = false,
//     this.autofocus = false,
//     this.onChangeDateTime,
//     this.onChange,
//     this.initialDateTime,
//     this.onFieldSubmitted,
//     this.textAlign,
//     this.inputFormatters = const [],
//     this.hintText,
//     super.key,
//     this.fillColor,
//     this.backgroundColor,
//     this.cursorColor,
//     this.controllerColor,
//     this.borderColor,
//     this.labelColor,
//     this.contentPadding,
//     this.focusNode,
//     this.textCapitalization,
//     this.onEditingComplete,
//     this.borderRadius,
//     this.labelStyle,
//     this.isMultiLines,
//   });
//
//   @override
//   State<CustomTextFormField> createState() => _CustomTextFormFieldState();
// }
//
// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   late FocusNode _focusNode;
//
//   @override
//   void dispose() {
//     if (widget.focusNode == null) {
//       _focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = widget.focusNode ?? FocusNode();
//     _focusNode.addListener(() {
//       setState(() {}); // Update state when focus changes
//     });
//     _errorText = widget.errorText;
//   }
//
//   String? _errorText;
//   @override
//   Widget build(BuildContext context) {
//     TextAlign localeTextAlign =
//         Localizations.localeOf(context).languageCode == "en"
//             ? TextAlign.left
//             : TextAlign.right;
//     TextAlign textAlign = widget.textAlign ?? localeTextAlign;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           height: widget.height ?? 50.h,
//           padding: EdgeInsets.all(2.sp),
//           decoration: BoxDecoration(
//               color: widget.backgroundColor == null
//                   ? Colors.white
//                   : widget.backgroundColor,
//               border: Border.all(
//                 color: _focusNode.hasFocus
//                     ? (widget.borderColor ??
//                         Colors.transparent) // Focused border color
//                     : (widget.borderColor ??
//                         Colors.transparent), // Default border color
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
//           // padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: TextFormField(
//             onEditingComplete: widget.onEditingComplete,
//             autofocus: widget.autofocus,
//             focusNode: widget.focusNode == null ? _focusNode : widget.focusNode,
//             textCapitalization:
//                 widget.textCapitalization ?? TextCapitalization.none,
//             style: TextStyle(
//                 color: widget.enabled == false
//                     ? Colors.grey
//                     : widget.controllerColor != null
//                         ? widget.controllerColor
//                         : AppColors.dark),
//             controller: widget.controller,
//             enabled: !widget.isDateTime && widget.enabled,
//             maxLines: widget.maxLines ?? 1,
//             readOnly: widget.readOnly,
//             textAlign: textAlign,
//             onFieldSubmitted: widget.onFieldSubmitted,
//             onTap: widget.onTap ??
//                 (widget.isDateTime
//                     ? () async {
//                         DateTime? dateTime = await showDatePicker(
//                             context: context,
//                             initialDate:
//                                 widget.initialDateTime ?? DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2040));
//                         if (dateTime != null) {
//                           if (widget.onChangeDateTime != null) {
//                             widget.onChangeDateTime!(dateTime);
//                           }
//                         }
//                       }
//                     : null),
//             validator: (value) {
//               if (widget.validate != null) {
//                 String? validateMessage = widget.validate!(value);
//                 setState(() {
//                   _errorText = validateMessage;
//                 });
//                 return validateMessage;
//               } else {
//                 return null;
//               }
//             },
//             cursorColor: widget.cursorColor == null
//                 ? AppColors.dark
//                 : widget.cursorColor,
//             obscureText: widget.isShowPassword
//                 ? !widget.obsecureText
//                 : widget.obsecureText,
//             maxLength: widget.maxLength,
//             // textAlign: widget.textAlign,
//             onChanged: (txt) {
//               if (txt.isNotEmpty) {
//                 setState(() {
//                   _errorText = null;
//                 });
//                 if (widget.onChange != null) {
//                   widget.onChange!(txt);
//                 }
//               }
//             },
//             keyboardType: widget.keyboardType,
//             obscuringCharacter: '*',
//             decoration: InputDecoration(
//                 focusedBorder: inputDecorationTheme.focusedBorder,
//                 enabledBorder: inputDecorationTheme.enabledBorder,
//                 disabledBorder: inputDecorationTheme.disabledBorder,
//                 errorBorder: inputDecorationTheme.errorBorder,
//                 fillColor: widget.fillColor == null
//                     ? AppColors.backGroundButtonGrey
//                     : widget.fillColor,
//                 filled: true,
//                 contentPadding: widget.contentPadding,
//                 prefixIcon: widget.prefix,
//                 label: widget.label != null
//                     ? Text(widget.label!,
//                         style: widget.labelStyle == null
//                             ? TextStyle(
//                                 color: widget.enabled == false
//                                     ? Colors.grey
//                                     : widget.labelColor == null
//                                         ? Colors.black
//                                         : widget.labelColor!)
//                             : widget.labelStyle)
//                     : null,
//                 border: InputBorder.none,
//                 errorStyle: const TextStyle(height: -1, fontSize: 0),
//                 errorMaxLines: 1,
//                 counterText: "",
//                 hintStyle: textTheme.bodySmall,
//                 hintText: widget.hintText,
//                 suffixIcon: widget.isDateTime
//                     ? GestureDetector(
//                         onTap: widget.onTap != null
//                             ? (() async {
//                                 DateTime? dateTime = await showDatePicker(
//                                     context: context,
//                                     initialDate: widget.initialDateTime ??
//                                         DateTime.now(),
//                                     firstDate: DateTime(1930),
//                                     lastDate: DateTime(2040));
//                                 if (dateTime != null) {
//                                   if (widget.onChangeDateTime != null) {
//                                     widget.onChangeDateTime!(dateTime);
//                                   }
//                                 }
//                               })
//                             : null,
//                         child: const Icon(Icons.calendar_today_rounded))
//                     : widget.isPassword
//                         ? IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 widget.isShowPassword = !widget.isShowPassword;
//                               });
//                             },
//                             icon: Icon(
//                               widget.isShowPassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility_sharp,
//                               color: Colors.black,
//                             ))
//                         : Padding(
//                             padding: EdgeInsets.only(left: 5.w, top: 8.h),
//                             child: widget.suffixIcon,
//                           )),
//             inputFormatters: widget.inputFormatters,
//           ),
//         ),
//         _errorText != null
//             ? Container(
//                 padding: const EdgeInsets.only(right: 20.0, top: 5.0),
//                 child: Row(
//                   children: <Widget>[
//                     const Icon(Icons.error_outline_rounded,
//                         size: 20.0, color: Colors.red),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Expanded(
//                       child: Padding(
//                           padding: const EdgeInsets.only(left: 5.0),
//                           child: Text(_errorText!,
//                               style: widget.errorTextStyle
//                                   .merge(TextStyle(color: Colors.red)))),
//                     )
//                   ],
//                 ))
//             : Container(),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final bool obsecureText;
  final FormFieldValidator<String>? validate;
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
  final Color? textColor;
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
  final TextStyle? hintStyle;
  final bool? isMultiLines;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? filled;
  final TextInputAction? textInputAction; // تضيفها في المتغيرات
  final ui.TextDirection? textDirection;
  CustomTextFormField({
    this.label,
    this.textDirection,
    this.textInputAction,
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
    this.fillColor,
    this.backgroundColor,
    this.cursorColor,
    this.textColor,
    this.borderColor,
    this.labelColor,
    this.contentPadding,
    this.focusNode,
    this.textCapitalization,
    this.onEditingComplete,
    this.borderRadius,
    this.labelStyle,
    this.hintStyle,
    this.isMultiLines,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.floatingLabelBehavior,
    this.filled,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;
  bool _showPassword = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    _showPassword = !widget.obsecureText;
    _errorText = widget.errorText;
  }

  @override
  void didUpdateWidget(CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      _errorText = widget.errorText;
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderRadius = widget.borderRadius ?? 5.0.r;
    final defaultBorderColor = widget.borderColor ?? Colors.white;
    final focusBorderColor = theme.primaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above the field (always visible)
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: widget.labelStyle ??
                TextStyle(
                  color: _focusNode.hasFocus
                      ? focusBorderColor
                      : widget.labelColor ?? AppColors.dark,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: 6.h),
        ],

        // Text Form Field
        Container(
          height: widget.height ?? 45.h,
          width: 353.w,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: TextFormField(
            textDirection:
                widget.textDirection ?? null, // استخدام الاتجاه المحدد

            textInputAction: widget.textInputAction,
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText:
                widget.isPassword ? !_showPassword : widget.obsecureText,
            obscuringCharacter: '*',
            enabled: widget.enabled,
            readOnly: widget.readOnly || widget.isDateTime,
            maxLines: widget.maxLines ?? 1,
            maxLength: widget.maxLength,
            autofocus: widget.autofocus,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            keyboardType: widget.keyboardType,
            textAlign: widget.textAlign ?? TextAlign.start,
            style: TextStyle(
              color: widget.textColor ?? theme.textTheme.bodyLarge?.color,
              fontSize: 13.sp,
            ),
            cursorColor: widget.cursorColor ?? theme.primaryColor,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
              filled: widget.filled ?? true,
              fillColor: widget.fillColor ?? theme.cardColor,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
              prefixIcon: widget.prefix,
              suffixIcon: _buildSuffixIcon(),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: defaultBorderColor),
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              enabledBorder: widget.enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    borderSide: BorderSide(color: defaultBorderColor),
                  ),
              focusedBorder: widget.focusedBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide(color: defaultBorderColor),
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
              disabledBorder: widget.disabledBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide(color: defaultBorderColor),
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
              errorBorder: widget.errorBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    borderSide: BorderSide(color: AppColors.red),
                  ),
              focusedErrorBorder: widget.focusedErrorBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    borderSide: BorderSide(color: AppColors.red, width: 0),
                  ),
              errorStyle: TextStyle(
                height: 0,
                fontSize: 0,
                color: Colors.transparent,
              ),
            ),
            validator: (value) {
              if (widget.validate != null) {
                final error = widget.validate!(value);
                setState(() {
                  _errorText = error;
                });
                return error;
              }
              return null;
            },
            onTap: widget.onTap ?? (widget.isDateTime ? _showDatePicker : null),
            onChanged: (value) {
              setState(() {
                _errorText = null;
              });
              widget.onChange?.call(value);
            },
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
          ),
        ),

        // Error message
        if (_errorText != null) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline, size: 16.w, color: AppColors.red),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    _errorText!,
                    style: widget.errorTextStyle.copyWith(color: AppColors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.initialDateTime ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      widget.onChangeDateTime?.call(date);
    }
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _showPassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      );
    } else if (widget.isDateTime) {
      return IconButton(
        icon: Icon(Icons.calendar_today, color: Colors.grey),
        onPressed: _showDatePicker,
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 4.w),
        child: widget.suffixIcon,
      );
    }
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
