import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/dashed_line_horizontal_painter.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../utils/chart_util.dart';
import 'custom_animated_opacity.dart';

class AnimatedLineTarget extends StatelessWidget {
  final Color color;
  final double width;
  final DashedType dashedType;
  final TargetTextPosition targetTextPosition;
  final String text;
  final double targetTextHeight;

  const AnimatedLineTarget(
      {required this.text,
      required this.width,
      required this.color,
      required this.dashedType,
      required this.targetTextPosition,
      required this.targetTextHeight,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedOpacity(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (targetTextPosition == TargetTextPosition.top)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SizedBox(
              height: targetTextHeight,
              child: CustomTextNew(
                text,
                style: AskLoraTextStyles.body4.copyWith(color: color),
              ),
            ),
          ),
        SizedBox(
          width: width,
          child: CustomPaint(
            painter: DashedLineHorizontalPainter(
                color: color, width: width, dashedType: dashedType),
          ),
        ),
        if (targetTextPosition == TargetTextPosition.bottom)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: SizedBox(
              height: targetTextHeight,
              child: CustomTextNew(
                text,
                style: AskLoraTextStyles.body4.copyWith(color: color),
              ),
            ),
          ),
      ],
    ));
  }
}
