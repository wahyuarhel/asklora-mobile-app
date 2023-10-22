import 'package:flutter/material.dart';

import '../../../../core/presentation/ai/lora_animation_green.dart';
import '../../../../core/presentation/ai/lora_animation_magenta.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';

enum PpiResult { success, failed }

class PpiResultScreen extends StatelessWidget {
  final String title;
  final String additionalMessage;
  final Widget bottomButton;
  final Widget? richText;
  final PpiResult? ppiResult;
  final TextStyle? additionalMessageTextStyle;
  final double bottomPadding;
  final bool isDarkBgColor;

  const PpiResultScreen(
      {required this.title,
      required this.ppiResult,
      this.additionalMessage = '',
      required this.bottomButton,
      this.additionalMessageTextStyle,
      this.richText,
      this.bottomPadding = 35,
      this.isDarkBgColor = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomStretchedLayout(
      contentPadding: EdgeInsets.zero,
      content: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: ppiResult == PpiResult.success
                  ? const LoraAnimationGreen()
                  : const LoraAnimationMagenta()),
          CustomTextNew(title,
              style: AskLoraTextStyles.h4.copyWith(
                  color: isDarkBgColor
                      ? AskLoraColors.white
                      : AskLoraColors.charcoal),
              textAlign: TextAlign.center),
          const SizedBox(height: 40),
          if (additionalMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 0),
              child: CustomTextNew(additionalMessage,
                  style: additionalMessageTextStyle ??
                      AskLoraTextStyles.h4.copyWith(
                          color: isDarkBgColor
                              ? AskLoraColors.white
                              : AskLoraColors.charcoal),
                  textAlign: TextAlign.center),
            ),
          if (richText != null) richText!,
        ],
      ),
      bottomButton: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: bottomButton,
      ),
    );
  }
}
