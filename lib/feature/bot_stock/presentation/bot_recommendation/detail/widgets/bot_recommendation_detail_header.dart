import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../onboarding/ppi/domain/ppi_user_response.dart';
import '../../../../utils/bot_stock_utils.dart';

class BotRecommendationDetailHeader extends StatelessWidget {
  final RecommendedBot recommendedBot;
  final BotType botType;
  const BotRecommendationDetailHeader(
      {required this.botType, required this.recommendedBot, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: CustomTextNew(
          '${botType.upperCaseName} ${recommendedBot.ticker}',
          style: AskLoraTextStyles.h5.copyWith(color: AskLoraColors.charcoal),
        ),
      ),
    );
  }
}
