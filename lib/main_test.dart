import 'package:flutter/material.dart';

import 'core/presentation/bot_badge/lora_pop_up_message_with_bot_badge.dart';
import 'core/presentation/buttons/button_example.dart';
import 'core/presentation/text_fields/text_field_example.dart';
import 'core/styles/asklora_colors.dart';
import 'feature/bot_stock/utils/bot_stock_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asklora Testing',
      home: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          children: [
            LoraPopUpMessageWithBotBadge(
              backgroundColor: AskLoraColors.primaryGreen,
              badgePosition: BadgePosition.belowSubtitle,
              title: 'No traded BotStocks.',
              subTitle:
                  'You can manage all your investments here after you start trading. Create an account and start trading.',
              botTypes: const [BotType.pullUp, BotType.squat],
              tickerSymbol: 'WTW',
              buttonLabel: 'NEXT',
              onButtonTap: () {},
            ),
            const ButtonExample(),
            const SizedBox(
              height: 24,
            ),
            const TextFieldExample()
          ],
        ),
      ));
}
