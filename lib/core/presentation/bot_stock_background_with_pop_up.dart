import 'dart:ui';

import 'package:flutter/material.dart';

import '../../feature/bot_stock/presentation/bot_recommendation/bot_recommendation_screen.dart';
import '../../feature/bot_stock/utils/bot_stock_utils.dart';
import '../styles/asklora_colors.dart';
import '../values/app_values.dart';
import 'buttons/primary_button.dart';
import 'lora_popup_message/lora_popup_message.dart';

class BotStockBackgroundWithPopUp extends StatelessWidget {
  const BotStockBackgroundWithPopUp({
    super.key,
    this.header,
    this.shouldScrollable = false,
    this.onPopUpButtonTap,
    required this.popUpTitle,
    required this.popUpSubTitle,
    required this.popUpButtonLabel,
  });

  final double _spacing = 16;
  final double botCardHeight = 166;
  final double blurPadding = 8;

  final Widget? header;
  final bool shouldScrollable;
  final String popUpTitle;
  final String popUpSubTitle;
  final String? popUpButtonLabel;
  final VoidCallback? onPopUpButtonTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      physics: shouldScrollable ? null : const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(padding: AppValues.screenHorizontalPadding, child: header),
          SizedBox(
            height: _getListHeight,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: blurPadding),
                  padding: AppValues.screenHorizontalPadding
                      .copyWith(top: blurPadding, bottom: blurPadding),
                  child: Wrap(
                    spacing: _spacing,
                    runSpacing: _spacing,
                    children: defaultBotRecommendation
                        .map((e) => BotRecommendationCard(
                              onTap: () {},
                              height: botCardHeight,
                              botRecommendationModel: e,
                              spacing: _spacing,
                            ))
                        .toList(),
                  ),
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: AppValues.screenHorizontalPadding,
                    child: LoraPopUpMessage(
                      backgroundColor: AskLoraColors.charcoal,
                      title: popUpTitle,
                      titleColor: AskLoraColors.white,
                      subTitle: popUpSubTitle,
                      subTitleColor: AskLoraColors.white,
                      primaryButtonLabel: popUpButtonLabel,
                      buttonPrimaryType: ButtonPrimaryType.solidGreen,
                      onPrimaryButtonTap: onPopUpButtonTap,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  double get _getListHeight =>
      botCardHeight * defaultBotRecommendation.length / 2 +
      _spacing * ((defaultBotRecommendation.length / 2).ceil() - 1) +
      2 * blurPadding;
}
