import 'package:flutter/material.dart';

import '../../../core/styles/asklora_colors.dart';

enum TabPage {
  home(BackgroundImageType.none),
  forYou(BackgroundImageType.none),
  portfolio(BackgroundImageType.none),
  aiLandingPage(BackgroundImageType.dark),
  none(BackgroundImageType.none);

  final BackgroundImageType backgroundImageType;

  const TabPage(this.backgroundImageType);
}

enum BackgroundImageType {
  light(
    imageAsset: 'assets/light_lora_gpt_background.png',
    baseBackgroundColor: AskLoraColors.white,
    appBarBackgroundColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.transparent,
    tabAiActiveAsset: 'bottom_nav_asklora_ai_selected_black',
    tabAiFilledColor: Colors.transparent,
  ),
  dark(
    imageAsset: 'assets/lora_gpt_background.png',
    baseBackgroundColor: AskLoraColors.black,
    appBarBackgroundColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.transparent,
    tabAiActiveAsset: 'bottom_nav_asklora_ai_selected_white',
    tabForYouFilledColor: AskLoraColors.darkGray,
    tabPortfolioFilledColor: AskLoraColors.darkGray,
    tabAiFilledColor: AskLoraColors.gray,
  ),
  none(
      baseBackgroundColor: AskLoraColors.white,
      appBarBackgroundColor: AskLoraColors.white,
      scaffoldBackgroundColor: AskLoraColors.white,
      tabAiFilledColor: AskLoraColors.gray,
      tabAiActiveAsset: 'bottom_nav_asklora_ai_selected_black');

  final String? imageAsset;
  final String tabAiActiveAsset;
  final Color? tabAiFilledColor;
  final Color? tabForYouFilledColor;
  final Color? tabPortfolioFilledColor;
  final Color baseBackgroundColor;
  final Color appBarBackgroundColor;
  final Color scaffoldBackgroundColor;

  const BackgroundImageType({
    this.imageAsset,
    required this.baseBackgroundColor,
    required this.appBarBackgroundColor,
    required this.scaffoldBackgroundColor,
    required this.tabAiActiveAsset,
    this.tabAiFilledColor,
    this.tabForYouFilledColor,
    this.tabPortfolioFilledColor,
  });
}
