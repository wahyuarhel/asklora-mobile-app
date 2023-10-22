import 'package:flutter/material.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';

class SummaryTextInfo extends StatelessWidget {
  final Widget? titleWidget;
  final String? title;
  final String subTitle;

  const SummaryTextInfo(
      {this.titleWidget, this.title, required this.subTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleWidget != null) titleWidget!,
        if (title != null)
          CustomTextNew(
            title!,
            style: AskLoraTextStyles.body2.copyWith(color: AskLoraColors.gray),
          ),
        const SizedBox(
          height: 10,
        ),
        CustomTextNew(
          subTitle,
          style: AskLoraTextStyles.subtitle2
              .copyWith(color: AskLoraColors.charcoal),
        ),
      ],
    );
  }
}
