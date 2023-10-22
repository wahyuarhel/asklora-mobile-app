import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../utils/bot_stock_utils.dart';

class BotPriceLevelIndicator extends StatelessWidget {
  final String stopLossPrice;
  final String takeProfitPrice;
  final String currentPrice;
  final BotType botType;

  const BotPriceLevelIndicator(
      {required this.stopLossPrice,
      required this.takeProfitPrice,
      required this.currentPrice,
      required this.botType,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceCard(
            titleBackgroundColor: AskLoraColors.lightMagenta,
            textColor: AskLoraColors.primaryMagenta,
            title: botType == BotType.plank
                ? S.of(context).estStopLossLevel
                : S.of(context).estMaxLossLevel,
            value: stopLossPrice),
        const SizedBox(
          width: 8,
        ),
        _priceCard(
            titleBackgroundColor: AskLoraColors.whiteSmoke,
            textColor: AskLoraColors.charcoal,
            title: S.of(context).currentPrice,
            value: currentPrice),
        const SizedBox(
          width: 8,
        ),
        _priceCard(
            titleBackgroundColor: AskLoraColors.lightGreen,
            textColor: AskLoraColors.primaryGreen,
            title: botType == BotType.plank
                ? S.of(context).estTakeProfitLevel
                : S.of(context).estMaxProfitLevel,
            value: takeProfitPrice),
      ],
    );
  }

  Widget _priceCard(
      {required Color titleBackgroundColor,
      required Color textColor,
      required String title,
      required String value}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 80),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: titleBackgroundColor),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: CustomTextNew(
              title,
              style: AskLoraTextStyles.subtitle5.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          CustomTextNew(
            value,
            style: AskLoraTextStyles.h6,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
