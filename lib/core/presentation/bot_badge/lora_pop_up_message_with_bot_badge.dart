import 'package:flutter/material.dart';

import '../../../feature/bot_stock/utils/bot_stock_utils.dart';
import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import '../../values/app_values.dart';
import '../buttons/primary_button.dart';
import '../custom_text_new.dart';
import 'bot_badge.dart';

enum BadgePosition { top, belowSubtitle }

class LoraPopUpMessageWithBotBadge extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<BotType> botTypes;
  final BadgePosition badgePosition;
  final Color backgroundColor;
  final List<Color> badgeBackgroundColors;
  final List<Color> badgeTextColors;
  final Color titleColor;
  final Color subTitleColor;
  final String buttonLabel;
  final VoidCallback onButtonTap;
  final String tickerSymbol;

  const LoraPopUpMessageWithBotBadge(
      {required this.title,
      required this.subTitle,
      required this.botTypes,
      this.tickerSymbol = '',
      this.badgePosition = BadgePosition.belowSubtitle,
      this.backgroundColor = AskLoraColors.whiteSmoke,
      this.titleColor = AskLoraColors.charcoal,
      this.subTitleColor = AskLoraColors.charcoal,
      this.badgeBackgroundColors = const [],
      this.badgeTextColors = const [],
      required this.buttonLabel,
      required this.onButtonTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 0),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: AppValues.screenHorizontalPadding,
                  width: double.infinity,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  width: double.infinity,
                  child: Column(
                    children: [
                      if (badgePosition == BadgePosition.top)
                        ...botTypes
                            .map((e) => BotBadge(
                                  botType: e,
                                  tickerSymbol: tickerSymbol,
                                  backgroundColor: _getBadgeBackgroundColor(
                                      botTypes.indexOf(e)),
                                  textColor:
                                      _getBadgeTextColor(botTypes.indexOf(e)),
                                ))
                            .toList(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppValues.screenHorizontalPadding.left + 23,
                            right:
                                AppValues.screenHorizontalPadding.right + 23),
                        child: Column(
                          children: [
                            CustomTextNew(
                              title,
                              style: AskLoraTextStyles.h4
                                  .copyWith(color: titleColor),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomTextNew(
                              subTitle,
                              style: AskLoraTextStyles.body2
                                  .copyWith(color: subTitleColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: badgePosition == BadgePosition.belowSubtitle
                            ? 25
                            : 0,
                      ),
                      if (badgePosition == BadgePosition.belowSubtitle)
                        ...botTypes
                            .map((e) => BotBadge(
                                  backgroundColor: _getBadgeBackgroundColor(
                                      botTypes.indexOf(e)),
                                  textColor:
                                      _getBadgeTextColor(botTypes.indexOf(e)),
                                  botType: e,
                                  tickerSymbol: tickerSymbol,
                                ))
                            .toList(),
                      const SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppValues.screenHorizontalPadding.left + 23,
                            right:
                                AppValues.screenHorizontalPadding.right + 23),
                        child: PrimaryButton(
                            buttonPrimaryType: ButtonPrimaryType.solidCharcoal,
                            label: buttonLabel,
                            onTap: onButtonTap),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color? _getBadgeBackgroundColor(int index) {
    if (badgeBackgroundColors.isNotEmpty &&
        index < badgeBackgroundColors.length) {
      return badgeBackgroundColors[index];
    } else {
      return null;
    }
  }

  Color? _getBadgeTextColor(int index) {
    if (badgeTextColors.isNotEmpty && index < badgeTextColors.length) {
      return badgeTextColors[index];
    } else {
      return null;
    }
  }
}
