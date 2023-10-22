import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String errorText;
  final int? maxLength;
  final bool obscureText;
  final TextInputType textInputType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? textInputFormatterList;
  final String? initialValue;
  final String prefixText;
  final String suffixText;
  final Widget? suffixIcon;
  final Color? fillColor;
  final InputBorder inputBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final EdgeInsets contentPadding;
  final int? maxLine;
  final bool autoFocus;

  const CustomTextInput(
      {required this.labelText,
      this.onChanged,
      this.onFieldSubmitted,
      this.hintText = '',
      this.textInputType = TextInputType.text,
      this.obscureText = false,
      this.errorText = '',
      this.maxLength,
      this.textInputFormatterList,
      this.initialValue,
      this.fillColor,
      this.inputBorder = const OutlineInputBorder(),
      this.floatingLabelBehavior,
      this.enabledBorder,
      this.disabledBorder,
      this.focusedBorder,
      this.contentPadding = const EdgeInsets.fromLTRB(17, 14, 17, 14),
      this.prefixText = '',
      this.suffixText = '',
      this.suffixIcon,
      this.textCapitalization = TextCapitalization.none,
      this.textAlign = TextAlign.start,
      this.controller,
      this.textStyle,
      this.hintTextStyle,
      this.maxLine,
      this.autoFocus = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        textCapitalization: textCapitalization,
        initialValue: initialValue,
        inputFormatters: textInputFormatterList,
        maxLength: maxLength,
        obscureText: obscureText,
        textAlign: textAlign,
        style: textStyle,
        maxLines: maxLine,
        minLines: 1,
        autofocus: autoFocus,
        decoration: InputDecoration(
            floatingLabelBehavior: floatingLabelBehavior,
            filled: fillColor != null ? true : false,
            fillColor: fillColor,
            border: inputBorder,
            labelText: labelText,
            hintStyle: hintTextStyle,
            contentPadding: contentPadding,
            counterText: '',
            hintText: hintText,
            prefixText: prefixText.isEmpty ? null : '$prefixText  ',
            suffixText: suffixText.isEmpty ? null : '$suffixText  ',
            suffixIcon: suffixIcon,
            enabledBorder: enabledBorder,
            disabledBorder: disabledBorder,
            focusedBorder: focusedBorder,
            errorText: errorText.isEmpty ? null : errorText),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: textInputType,
      );
}
