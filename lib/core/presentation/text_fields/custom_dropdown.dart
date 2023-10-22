import 'package:flutter/material.dart';

import '../../styles/asklora_colors.dart';
import '../custom_text_new.dart';
import 'style/text_field_style.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> itemsList;
  final void Function(String?) onChanged;
  final void Function()? onTap;
  final String initialValue;
  final String labelText;
  final EdgeInsets? contentPadding;

  const CustomDropdown({
    Key? key,
    this.initialValue = '',
    this.hintText = '',
    this.labelText = '',
    required this.itemsList,
    required this.onChanged,
    this.contentPadding,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.initialValue.isNotEmpty ? widget.initialValue : null,
      elevation: 2,
      isExpanded: true,
      menuMaxHeight: 260,
      onChanged: (String? newValue) {
        widget.onChanged(newValue);
      },
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AskLoraColors.charcoal,
      ),
      onTap: widget.onTap,
      style: TextFieldStyle.valueTextStyle,
      decoration: TextFieldStyle.inputDecoration.copyWith(
          hintText: widget.hintText,
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: widget.contentPadding),
      borderRadius: BorderRadius.circular(5),
      items: _getDropdownMenuItems(textEllipsis: true),
      selectedItemBuilder: (_) =>
          _getDropdownMenuItems(textEllipsis: true, maxLines: 1),
    );
  }

  List<DropdownMenuItem<String>> _getDropdownMenuItems(
          {bool textEllipsis = true, int maxLines = 2}) =>
      widget.itemsList
          .map(
            (element) => DropdownMenuItem<String>(
              key: Key(element),
              value: element,
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextNew(
                    element,
                    style: TextFieldStyle.valueTextStyle.copyWith(height: 1.3),
                    maxLines: maxLines,
                    ellipsis: textEllipsis,
                  ),
                ],
              ),
            ),
          )
          .toList();
}
