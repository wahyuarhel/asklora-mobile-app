import 'package:flutter/material.dart';

import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/lora_animation_header.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../generated/l10n.dart';
import '../widgets/bot_stock_form.dart';
import 'bot_stock_do_screen.dart';

class BotStockWelcomeScreen extends StatelessWidget {
  static const String route = '/gift_bot_stock_welcome_screen';

  const BotStockWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: BotStockForm(
        enableBackNavigation: false,
        content: Container(
          width: screenSize.width,
          constraints: BoxConstraints(minHeight: screenSize.height / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LoraAnimationHeader(
                loraAnimationHeight: 208,
                loraAnimationWidth: 208,
              ),
              const SizedBox(height: 30),
              CustomTextNew(
                S.of(context).botStockWelcomeScreenTitle,
                style: AskLoraTextStyles.h4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        bottomButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: PrimaryButton(
            buttonPrimaryType: ButtonPrimaryType.solidCharcoal,
            label: S.of(context).botStockWelcomeScreenBottomButton,
            onTap: () => BotStockDoScreen.open(context),
          ),
        ),
      ),
    );
  }

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushNamed(
        route,
      );
}
