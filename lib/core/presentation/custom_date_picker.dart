import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import '../values/app_values.dart';
import 'buttons/primary_button.dart';
import 'custom_text_new.dart';
import 'text_fields/style/text_field_style.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final EdgeInsets padding;
  final DateTime? selectedDate;
  final DateTime? initialDateTime;
  final DateTime? maximumDate;
  final void Function(DateTime) onDateTimeChanged;
  final String? errorText;

  const CustomDatePicker(
      {Key? key,
      this.label = '',
      this.padding = EdgeInsets.zero,
      this.selectedDate,
      this.initialDateTime,
      this.maximumDate,
      this.errorText,
      required this.onDateTimeChanged})
      : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final FocusNode _focusNode = FocusNode();
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _focusNode.requestFocus();
        showModalBottomSheet(
            context: (context),
            builder: (_) => SafeArea(
                  child: Padding(
                    padding:
                        AppValues.screenHorizontalPadding.copyWith(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 200,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: widget.onDateTimeChanged,
                            initialDateTime: widget.initialDateTime,
                            maximumDate: widget.maximumDate,
                          ),
                        ),
                        PrimaryButton(
                            label: 'SELECT',
                            onTap: () => Navigator.pop(context))
                      ],
                    ),
                  ),
                ));
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
          decoration: TextFieldStyle.inputDecoration
              .copyWith(labelText: widget.label, errorText: widget.errorText),
          child: CustomTextNew(
            widget.selectedDate != null
                ? '${widget.selectedDate!.year}-${widget.selectedDate!.month}-${widget.selectedDate!.day}'
                : '-',
            style: AskLoraTextStyles.body1.copyWith(
                height: 1,
                color: widget.initialDateTime != null
                    ? AskLoraColors.charcoal
                    : AskLoraColors.gray),
          ),
        ),
      ),
    );
  }
}
