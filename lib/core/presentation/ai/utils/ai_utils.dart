import 'package:flutter/material.dart';

import '../../../styles/asklora_colors.dart';

enum AiThemeType {
  light(
      backgroundImageAsset: 'assets/light_lora_gpt_background.png',
      baseBackgroundColor: AskLoraColors.white,
      primaryFontColor: AskLoraColors.charcoal,
      secondaryFontColor: AskLoraColors.charcoal,
      startButtonFillColor: Colors.transparent,
      sendChatButtonIconEnableColor: Colors.white,
      sendChatButtonIconDisableColor: AskLoraColors.gray,
      textFieldFillColor: AskLoraColors.whiteSmoke,
      chatNextButtonBorderColor: AskLoraColors.charcoal,
      inChatBubbleWidgetColor: AskLoraColors.primaryGreenAlpha30,
      choicesInteractionBorderColor: AskLoraColors.charcoal,
      loraThingkingWidgetColor: AskLoraColors.whiteSmoke,
      outChatBubbleWidgetColor: AskLoraColors.whiteSmoke,
      scrambledTextColor: AskLoraColors.charcoalAlpha50,
      sendChatButtonEnableColor: AskLoraColors.primaryGreenAlpha70,
      sendChatButtonDisableColor: AskLoraColors.grayAlpha20),
  dark(
      backgroundImageAsset: 'assets/lora_gpt_background.png',
      baseBackgroundColor: AskLoraColors.black,
      primaryFontColor: AskLoraColors.white,
      secondaryFontColor: AskLoraColors.white,
      startButtonFillColor: Color(0xFF373A49),
      textFieldFillColor: AskLoraColors.whiteAlpha15,
      sendChatButtonIconEnableColor: AskLoraColors.white,
      sendChatButtonIconDisableColor: AskLoraColors.gray,
      inChatBubbleWidgetColor: AskLoraColors.whiteAlpha35,
      loraThingkingWidgetColor: AskLoraColors.whiteAlpha20,
      outChatBubbleWidgetColor: AskLoraColors.whiteAlpha15,
      scrambledTextColor: AskLoraColors.whiteAlpha50,
      sendChatButtonDisableColor: AskLoraColors.grayAlpha20,
      sendChatButtonEnableColor: AskLoraColors.primaryGreenAlpha90);

  final String backgroundImageAsset;
  final Color baseBackgroundColor;
  final Color primaryFontColor;
  final Color secondaryFontColor;
  final Color startButtonFillColor;
  final Color sendChatButtonIconDisableColor;
  final Color sendChatButtonIconEnableColor;
  final Color textFieldFillColor;
  final Color sendChatButtonDisableColor;
  final Color sendChatButtonEnableColor;

  final Color scrambledTextColor;
  final Color loraThingkingWidgetColor;
  final Color inChatBubbleWidgetColor;
  final Color outChatBubbleWidgetColor;
  final Color? chatNextButtonBorderColor;
  final Color? choicesInteractionBorderColor;

  const AiThemeType({
    required this.backgroundImageAsset,
    required this.baseBackgroundColor,
    required this.primaryFontColor,
    required this.secondaryFontColor,
    required this.startButtonFillColor,
    required this.sendChatButtonIconEnableColor,
    required this.sendChatButtonIconDisableColor,
    required this.textFieldFillColor,
    required this.inChatBubbleWidgetColor,
    required this.outChatBubbleWidgetColor,
    required this.loraThingkingWidgetColor,
    required this.scrambledTextColor,
    this.chatNextButtonBorderColor,
    this.choicesInteractionBorderColor,
    required this.sendChatButtonEnableColor,
    required this.sendChatButtonDisableColor,
  });
}
