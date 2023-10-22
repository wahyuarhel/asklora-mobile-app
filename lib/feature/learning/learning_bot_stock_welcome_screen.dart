import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/bot_badge/lora_pop_up_message_with_bot_badge.dart';
import '../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../core/presentation/lora_animation_header.dart';
import '../../core/values/app_values.dart';
import '../bot_stock/utils/bot_stock_utils.dart';
import 'learning_bot_stock_screen.dart';

class LearningBotStockWelcomeScreen extends StatelessWidget {
  final BotType botType;
  final String tickerSymbol;
  static const String route = '/learning_bot_stock_welcome_screen';

  const LearningBotStockWelcomeScreen(
      {required this.botType, required this.tickerSymbol, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        useSafeArea: false,
        body: ListView(
          padding: const EdgeInsets.only(bottom: 30),
          children: [
            Padding(
              padding: AppValues.screenHorizontalPadding.copyWith(bottom: 20),
              child: LoraAnimationHeader(
                  text:
                      'Let’s go through a few reps, and see if ${botType.upperCaseName} bot fits your investment style.'),
            ),
            LoraPopUpMessageWithBotBadge(
              tickerSymbol: tickerSymbol,
              buttonLabel: "LET'S PRACTICE",
              backgroundColor: botType.primaryBgColor,
              title: _getTitle,
              subTitle: _getSubTitle,
              botTypes: [botType],
              badgeBackgroundColors: const [Colors.black],
              badgeTextColors: const [Colors.white],
              badgePosition: BadgePosition.top,
              onButtonTap: () => context
                  .read<NavigationBloc<LearningBotStockPageStep>>()
                  .add(const PageChanged(LearningBotStockPageStep.question)),
            )
          ],
        ));
  }

  String get _getTitle {
    switch (botType) {
      case BotType.pullUp:
        return 'Achieve Rare Big Win';
      case BotType.squat:
        return 'Achieve Frequent Small Win';
      case BotType.plank:
        return 'Achieve Stable Investment';
    }
  }

  String get _getSubTitle {
    switch (botType) {
      case BotType.pullUp:
        return 'Pull-up AI bot is suited for investors who want to try their lucky for a bigger win. Mutiple buy and sell occur. It buys on the rise then sell at a target price. ';
      case BotType.squat:
        return 'Squat AI bot is best suited for investors who want to have a frequent win with small profit. Multiple buy and sell occur. It buys low and sells high for modest. ';
      case BotType.plank:
        return 'Plank AI bot is best suited for investors who want a stable investment. It sells all to stop loss or when it reaches the target profit. ';
    }
  }

  static void open(BuildContext context) => Navigator.pushNamed(
        context,
        route,
      );
}
