import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';

class BadgeLabel extends StatelessWidget {
  final String label;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  const BadgeLabel(
    this.label, {
    Key? key,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    this.textStyle,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10),
        padding: padding,
        decoration: BoxDecoration(
            color: backgroundColor ?? AskLoraColors.lightGray,
            borderRadius: BorderRadius.circular(5)),
        child: CustomTextNew(label,
            style: textStyle ?? AskLoraTextStyles.subtitle5));
  }
}
