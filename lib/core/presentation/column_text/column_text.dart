import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';

class ColumnText extends StatelessWidget {
  final String title;
  final String subTitle;
  final int? maxLines;
  final bool ellipsis;
  final Color? subTitleColor;
  final CrossAxisAlignment crossAxisAlignment;

  const ColumnText(
      {required this.title,
      required this.subTitle,
      this.maxLines,
      this.ellipsis = false,
      this.subTitleColor,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CustomTextNew(
          title,
          style:
              AskLoraTextStyles.body4.copyWith(color: AskLoraColors.charcoal),
          maxLines: maxLines,
          ellipsis: ellipsis,
        ),
        CustomTextNew(
          subTitle,
          style: AskLoraTextStyles.subtitle2
              .copyWith(color: subTitleColor ?? AskLoraColors.charcoal),
          maxLines: maxLines,
          ellipsis: ellipsis,
        ),
      ],
    );
  }
}
