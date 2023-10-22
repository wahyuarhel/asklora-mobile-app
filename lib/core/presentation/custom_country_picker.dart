import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import 'custom_text_new.dart';
import 'text_fields/style/text_field_style.dart';

class CustomCountryPicker extends StatefulWidget {
  final String? label;
  final String? initialValue;
  final String hintText;
  final Function(Country) onSelect;
  final bool showPhoneCode;
  final FloatingLabelBehavior floatingLabelBehavior;

  const CustomCountryPicker(
      {required this.onSelect,
      this.initialValue,
      this.label,
      this.hintText = 'Select Country',
      this.showPhoneCode = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.always,
      Key? key})
      : super(key: key);

  @override
  State<CustomCountryPicker> createState() => _CustomCountryPickerState();
}

class _CustomCountryPickerState extends State<CustomCountryPicker> {
  final FocusNode _focusNode = FocusNode();
  bool _focus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _focus = true;
        });
      } else {
        setState(() {
          _focus = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _focusNode.requestFocus();
        showCountryPicker(
          searchAutofocus: true,
          context: context,
          showPhoneCode: widget.showPhoneCode,
          favorite: ['HK', 'US', 'CA', 'GB'],
          onSelect: widget.onSelect,
        );
      },
      child: Focus(
        focusNode: _focusNode,
        onFocusChange: (focus) {
          if (_focusNode.hasFocus) {
            setState(() {
              _focus = true;
            });
          } else {
            setState(() {
              _focus = false;
            });
          }
        },
        child: InputDecorator(
          isFocused: _focus,
          decoration: TextFieldStyle.inputDecoration.copyWith(
              floatingLabelBehavior: widget.floatingLabelBehavior,
              labelText: widget.label,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 17, vertical: 16)),
          child: Row(
            children: [
              Expanded(
                  child: CustomTextNew(
                widget.initialValue != null && widget.initialValue!.isNotEmpty
                    ? widget.initialValue!
                    : widget.hintText,
                style: AskLoraTextStyles.body1.copyWith(
                    height: 1,
                    color: widget.initialValue != null &&
                            widget.initialValue!.isNotEmpty
                        ? AskLoraColors.charcoal
                        : AskLoraColors.gray),
              )),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AskLoraColors.charcoal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
