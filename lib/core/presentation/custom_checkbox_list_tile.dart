import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import 'custom_text.dart';
import 'custom_text_new.dart';

class CustomCheckboxListTile extends StatelessWidget {
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

  const CustomCheckboxListTile({
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
    return Theme(
      data: ThemeData(unselectedWidgetColor: AskLoraColors.gray),
      child: Container(
        decoration: isChecked
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AskLoraColors.primaryGreen),
                color: AskLoraColors.lightGreen)
            : null,
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          checkColor: AskLoraColors.white,
          activeColor: AskLoraColors.primaryGreen,
          key: checkboxKey,
          splashRadius: 0,
          value: isChecked,
          contentPadding: EdgeInsets.zero,
          onChanged: disabled ? null : onChanged,
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          title: CustomTextNew(
            text,
            style: AskLoraTextStyles.subtitle3
                .copyWith(color: AskLoraColors.charcoal),
            textAlign: textAlign,
            applyHeightToFirstAscent: true,
          ),
        ),
      ),
    );
  }
}
