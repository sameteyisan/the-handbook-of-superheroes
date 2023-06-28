import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? label;
  final String? labelText;
  final Color labelColor;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final void Function()? onTap;
  final TextAlign textAlign;
  final int? minLine;
  final int? maxline;
  final Color borderColor;
  final String? inputLabelText;
  final int? maxLength;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final bool autoFocus;
  final EdgeInsets contentPadding;
  final Widget? counter;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool expand;
  final TextCapitalization? textCapitalization;
  final Color backgroundColor;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.suffixText,
    this.suffixIcon,
    this.prefixIcon,
    this.label,
    this.labelText,
    this.labelColor = CColors.white,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.minLine,
    this.maxline = 1,
    this.borderColor = CColors.backgroundcolor,
    this.inputLabelText,
    this.maxLength,
    this.onFieldSubmitted,
    this.focusNode,
    this.inputAction,
    this.autoFocus = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.counter,
    this.inputFormatters,
    this.style,
    this.hintStyle,
    this.expand = false,
    this.textCapitalization,
    this.backgroundColor = CColors.foregroundBlack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        maxLength: maxLength,
        expands: expand,
        minLines: minLine,
        maxLines: maxline,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: initialValue,
        controller: controller,
        textInputAction: inputAction ?? TextInputAction.done,
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        autofocus: autoFocus,
        textAlign: textAlign,
        onTap: onTap,
        style: style ?? TextStyle(color: CColors.textColor, fontSize: 15.sp),
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        readOnly: readOnly,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0),
          counter: counter,
          labelText: inputLabelText,
          prefixIcon: prefixIcon,
          alignLabelWithHint: true,
          suffixIcon: suffixIcon,
          hintText: hintText,
          suffixText: suffixText,
          hintStyle: hintStyle ?? TextStyle(fontSize: 15.sp, color: CColors.subtitleColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: borderColor, width: 0.5.w),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 8,
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: borderColor, width: 0.5),
          ),
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
