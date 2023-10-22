import 'package:flutter/material.dart';
import '../../../../core/presentation/ai/utils/ai_utils.dart';

class AiLayoutWithBackground extends StatelessWidget {
  final AiThemeType aiThemeType;
  final Widget content;

  const AiLayoutWithBackground(
      {required this.content, required this.aiThemeType, super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: aiThemeType.baseBackgroundColor,
          image: DecorationImage(
              image: AssetImage(aiThemeType.backgroundImageAsset),
              fit: BoxFit.cover),
        ),
        child: content,
      );
}
