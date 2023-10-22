import 'package:flutter/material.dart';
import '../utils/ai_utils.dart';
import 'jumping_dots_lora_gpt.dart';

class LoraThinkingWidget extends StatelessWidget {
  final AiThemeType aiThemeType;

  const LoraThinkingWidget({this.aiThemeType = AiThemeType.dark, super.key});

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 5, right: 40),
        decoration: BoxDecoration(
          color: aiThemeType.loraThingkingWidgetColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: JumpingDotsLoraGptWidget(),
      ));
}
