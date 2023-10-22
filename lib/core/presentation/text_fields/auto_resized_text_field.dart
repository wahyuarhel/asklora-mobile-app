import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';

class AutoResizedTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String labelText;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatterList;
  final String hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextStyle? hintTextStyle;
  final bool fullWidth;
  final double? minWidth;

  const AutoResizedTextField(
      {this.onChanged,
      this.onFieldSubmitted,
      this.labelText = '',
      this.hintText = '',
      this.initialValue,
      this.controller,
      this.textInputType = TextInputType.text,
      this.textInputFormatterList,
      this.suffixIcon,
      this.prefixIcon,
      this.textStyle,
      this.hintTextStyle,
      this.textAlign = TextAlign.left,
      this.fullWidth = true,
      this.minWidth,
      Key? key})
      : super(key: key);

  @override
  State<AutoResizedTextField> createState() => _AutoResizedTextFieldState();
}

class _AutoResizedTextFieldState extends State<AutoResizedTextField> {
  late TextEditingController _textEditingControllerFour;

  @override
  void initState() {
    super.initState();
    _textEditingControllerFour = TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.dispose();
    }
    _textEditingControllerFour.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextField(
      textAlign: widget.textAlign,
      fullwidth: widget.fullWidth,
      minWidth: widget.minWidth,
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      style: widget.textStyle ?? AskLoraTextStyles.h3,
      controller: widget.controller ?? _textEditingControllerFour,
      onSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.textInputType,
      inputFormatters: widget.textInputFormatterList,
      maxLines: 1,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          hintStyle: widget.hintTextStyle ??
              AskLoraTextStyles.h3.copyWith(color: AskLoraColors.lightGray),
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText),
    );
  }
}
