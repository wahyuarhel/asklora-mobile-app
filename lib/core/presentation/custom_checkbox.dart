import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import 'custom_text.dart';
import 'custom_text_new.dart';

class CustomCheckbox extends StatelessWidget {
  final Key? checkboxKey;
  final EdgeInsets padding;
  final String text;
  final TextAlign textAlign;
  final bool isChecked;
  final bool disabled;
  final FontType fontType;
  final double? fontHeight;
  final void Function(bool?) onChanged;
  final EdgeInsets textPadding;

  const CustomCheckbox({
    Key? key,
    this.checkboxKey,
    this.fontType = FontType.bodyText,
    required this.text,
    this.padding = EdgeInsets.zero,
    required this.isChecked,
    required this.onChanged,
    this.fontHeight,
    this.textAlign = TextAlign.start,
    this.disabled = false,
    this.textPadding = const EdgeInsets.only(top: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data:
                ThemeData(unselectedWidgetColor: AskLoraColors.primaryMagenta),
            child: Checkbox(
              checkColor: AskLoraColors.white,
              activeColor: AskLoraColors.primaryGreen,
              key: checkboxKey,
              splashRadius: 0,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: isChecked,
              onChanged: disabled ? null : onChanged,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Padding(
              padding: textPadding,
              child: CustomTextNew(
                text,
                style: AskLoraTextStyles.body2
                    .copyWith(color: AskLoraColors.charcoal),
                textAlign: textAlign,
                applyHeightToFirstAscent: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
