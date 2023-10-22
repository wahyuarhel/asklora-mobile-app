import 'package:flutter/material.dart';

import '../domain/pair.dart';
import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import '../utils/app_icons.dart';
import 'ai/lora_animation_green.dart';
import 'ai/lora_animation_magenta.dart';
import 'custom_text_new.dart';

enum LoraAnimationType { green, magenta }

class LoraAnimationHeader extends StatelessWidget {
  final String text;
  final Color textColor;
  final double loraAnimationHeight;
  final double loraAnimationWidth;
  final LoraAnimationType loraAnimationType;

  const LoraAnimationHeader({
    this.text = '',
    this.loraAnimationType = LoraAnimationType.green,
    this.textColor = AskLoraColors.charcoal,
    this.loraAnimationHeight = 170,
    this.loraAnimationWidth = 170,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Stack(alignment: Alignment.center, children: [
        getSvgImage(_getHeaderProps().left),
        _getHeaderProps().right,
      ]),
      if (text.isNotEmpty)
        CustomTextNew(
          text,
          style: AskLoraTextStyles.h4.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
    ]);
  }

  Pair<String, Widget> _getHeaderProps() {
    switch (loraAnimationType) {
      case LoraAnimationType.green:
        return Pair(
            'memoji_background_green',
            LoraAnimationGreen(
              width: loraAnimationWidth,
              height: loraAnimationHeight,
            ));
      default:
        return Pair(
            'memoji_background_magenta',
            LoraAnimationMagenta(
                width: loraAnimationWidth, height: loraAnimationHeight));
    }
  }
}
