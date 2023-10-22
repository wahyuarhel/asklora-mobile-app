import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/presentation/ai/utils/ai_utils.dart';

class AiWelcomeSubtitleText extends StatelessWidget {
  final String subTitle;
  final AiThemeType aiThemeType;

  const AiWelcomeSubtitleText(
      {required this.subTitle, required this.aiThemeType, super.key});

  @override
  Widget build(BuildContext context) => CustomTextNew(
        subTitle,
        style: AskLoraTextStyles.body1
            .copyWith(color: aiThemeType.secondaryFontColor),
        textAlign: TextAlign.center,
      );
}
