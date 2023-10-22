import 'package:flutter/material.dart';

import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import '../../utils/extensions.dart';
import '../../utils/formatters/currency_formatter.dart';
import '../custom_text_new.dart';
import 'style/text_field_style.dart';

class AmountTextField extends StatefulWidget {
  final String initialValue;
  final String label;
  final String hintText;
  final String prefixText;
  final String errorText;
  final Function(String)? onChanged;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final int decimalDigits;

  const AmountTextField({
    Key? key,
    this.onChanged,
    this.initialValue = '',
    this.hintText = '',
    this.label = '',
    this.errorText = '',
    this.prefixText = 'HKD ',
    this.backgroundColor,
    this.contentPadding,
    this.decimalDigits = 1,
  }) : super(key: key);

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  final TextEditingController controller = TextEditingController();

  FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never;
  String? label;
  Widget? prefixWidget;
  String? hintText;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty) {
      label = widget.label;
      floatingLabelBehavior = FloatingLabelBehavior.always;
      controller.text = widget.initialValue;
    }
    hintText = widget.hintText;
    controller.addListener(() {
      _setFloatingLabelBehavior();
    });
  }

  void _setFloatingLabelBehavior() {
    setState(() {
      if (controller.text.isEmpty) {
        hintText = widget.hintText;
        label = null;
        floatingLabelBehavior = FloatingLabelBehavior.never;
      } else {
        hintText = null;
        label = widget.label;
        floatingLabelBehavior = FloatingLabelBehavior.always;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AskLoraColors.primaryGreen,
              ),
        ),
        child: TextFormField(
            controller: controller,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value.replaceAll(amountRegex, ''));
              }
            },
            inputFormatters: [
              CurrencyTextInputFormatter(
                  symbol: '',
                  decimalDigits: widget.decimalDigits,
                  enableNegative: false,
                  allowDecimal: false),
            ],
            keyboardType: TextInputType.number,
            style: TextFieldStyle.valueTextStyle,
            decoration: TextFieldStyle.inputDecoration.copyWith(
                filled: true,
                fillColor: widget.backgroundColor,
                floatingLabelBehavior: floatingLabelBehavior,
                labelText: label,
                hintText: hintText,
                errorText: widget.errorText.isEmpty ? null : widget.errorText,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 17, top: 12),
                  child: CustomTextNew(
                    widget.prefixText,
                    style: AskLoraTextStyles.body1
                        .copyWith(color: AskLoraColors.gray),
                  ),
                ),
                contentPadding: widget.contentPadding)),
      );
}
