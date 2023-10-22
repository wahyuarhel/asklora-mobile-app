import 'package:flutter/material.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../auto_sized_text_widget.dart';

class ColumnTextWithAutoSizedText extends StatelessWidget {
  final String title;
  final String subTitle;
  final int? maxLines;

  const ColumnTextWithAutoSizedText(
      {required this.title, required this.subTitle, this.maxLines, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizedTextWidget(
          title,
          style:
              AskLoraTextStyles.body4.copyWith(color: AskLoraColors.charcoal),
          maxLines: maxLines,
        ),
        AutoSizedTextWidget(
          subTitle,
          style: AskLoraTextStyles.subtitle2
              .copyWith(color: AskLoraColors.charcoal),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
