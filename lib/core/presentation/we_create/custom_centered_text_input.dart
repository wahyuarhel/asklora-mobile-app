import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/asklora_colors.dart';
import '../custom_text_input.dart';

class CustomCenteredTextInput extends StatelessWidget {
  final Function(String) onChanged;
  final String labelText;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatterList;
  final String hintText;
  final String? initialValue;
  final EdgeInsets padding;
  final FontWeight fontWeight;
  final int? maxLength;
  final TextCapitalization textCapitalization;

  const CustomCenteredTextInput(
      {required this.onChanged,
      this.labelText = '',
      this.hintText = '',
      this.initialValue,
      this.padding = EdgeInsets.zero,
      this.textInputType = TextInputType.text,
      this.textInputFormatterList,
      this.fontWeight = FontWeight.w900,
      this.maxLength,
      this.textCapitalization = TextCapitalization.none,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CustomTextInput(
        textCapitalization: textCapitalization,
        textInputType: textInputType,
        initialValue: initialValue,
        labelText: labelText,
        hintText: hintText,
        maxLength: maxLength,
        inputBorder: InputBorder.none,
        textInputFormatterList: textInputFormatterList,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        autoFocus: true,
        hintTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: fontWeight,
            color: AskLoraColors.lightGray),
        textStyle: TextStyle(
            fontSize: 33,
            fontWeight: fontWeight,
            color: AskLoraColors.charcoal),
        textAlign: TextAlign.center,
        onChanged: onChanged,
      ),
    );
  }
}
