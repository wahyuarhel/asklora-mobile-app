import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/asklora_colors.dart';
import 'style/text_field_style.dart';

class MessageTextField extends StatefulWidget {
  final TextCapitalization textCapitalization;
  final String? initialValue;
  final List<TextInputFormatter>? textInputFormatterList;
  final int? maxLine;
  final String hintText;
  final String errorText;
  final Function(String)? onChanged;

  const MessageTextField(
      {Key? key,
      this.textCapitalization = TextCapitalization.none,
      this.initialValue,
      this.textInputFormatterList,
      this.hintText = '',
      this.errorText = '',
      this.onChanged,
      this.maxLine = 5})
      : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final OutlineInputBorder nonFocusedBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)));

  final OutlineInputBorder focusedBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AskLoraColors.primaryGreen, width: 2));

  FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never;
  Widget? label;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
      textCapitalization: widget.textCapitalization,
      initialValue: widget.initialValue,
      inputFormatters: widget.textInputFormatterList,
      maxLines: widget.maxLine,
      onChanged: widget.onChanged,
      style: TextFieldStyle.valueTextStyle,
      decoration: TextFieldStyle.inputDecoration.copyWith(
        floatingLabelBehavior: floatingLabelBehavior,
        hintText: widget.hintText,
        errorText: widget.errorText.isEmpty ? null : widget.errorText,
      ));
}
