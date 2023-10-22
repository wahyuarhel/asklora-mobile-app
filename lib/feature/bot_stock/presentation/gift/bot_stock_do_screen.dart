import 'package:flutter/material.dart';

import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/buttons/secondary/extra_info_button.dart';
import '../../../../core/presentation/circular_container.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../generated/l10n.dart';
import '../../utils/bot_stock_utils.dart';
import '../widgets/bot_stock_form.dart';
import 'bot_stock_explanation_screen.dart';

class BotStockDoScreen extends StatelessWidget {
  static const String route = '/gift_bot_stock_do_screen';

  const BotStockDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BotStockForm(
      useHeader: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExtraInfoButton(
            onTap: () => '',
            label: 'Lora\'s tips',
            buttonExtraInfoSize: ButtonExtraInfoSize.small,
          ),
          const SizedBox(height: 20),
          CustomTextNew(
            S.of(context).botStockDoScreenTitle,
            style: AskLoraTextStyles.h4,
          ),
          const SizedBox(height: 10),
          const BotTypeWithAnimation()
        ],
      ),
      bottomButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: PrimaryButton(
          label: S.of(context).buttonGotIt,
          onTap: () => BotStockExplanationScreen.open(context),
        ),
      ),
    );
  }

  static void open(BuildContext context) => Navigator.pushNamed(
        context,
        route,
      );
}

class BotTypeWithAnimation extends StatefulWidget {
  const BotTypeWithAnimation({super.key});

  @override
  State<BotTypeWithAnimation> createState() => _BotTypeWithAnimationState();
}

class _BotTypeWithAnimationState extends State<BotTypeWithAnimation> {
  bool isCard1Visible = false;
  bool isCard2Visible = false;
  bool isCard3Visible = false;
  final double cardSpace = 20;
  final Duration animatedDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => setState(() => isCard1Visible = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: isCard1Visible ? 1 : 0,
          onEnd: () => _fadeInCard(isCard2Visible = true),
          duration: animatedDuration,
          child: _botCard(
              botType: BotType.pullUp,
              description: S.of(context).botStockDoScreenPoint1),
        ),
        AnimatedOpacity(
          opacity: isCard2Visible ? 1 : 0,
          onEnd: () => _fadeInCard(isCard3Visible = true),
          duration: animatedDuration,
          child: _botCard(
              botType: BotType.plank,
              description: S.of(context).botStockDoScreenPoint2),
        ),
        AnimatedOpacity(
          opacity: isCard3Visible ? 1 : 0,
          duration: animatedDuration,
          child: _botCard(
              botType: BotType.squat,
              description: S.of(context).botStockDoScreenPoint3),
        ),
      ],
    );
  }

  void _fadeInCard(bool setStateCard) {
    Future.delayed(
        const Duration(milliseconds: 500), () => setState(() => setStateCard));
  }

  Widget _botCard({required BotType botType, required String description}) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
        child: Row(
          children: [
            CircularContainer(
                padding: const EdgeInsets.all(22),
                backgroundColor: botType.primaryBgColor,
                child: Column(
                  children: [
                    getSvgIcon(botType.botAssetName,
                        color: AskLoraColors.black),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextNew(
                      botType.value,
                      style: AskLoraTextStyles.subtitle3
                          .copyWith(color: AskLoraColors.charcoal),
                    ),
                  ],
                )),
            const SizedBox(
              width: 15,
            ),
            CustomTextNew(
              description,
              style: AskLoraTextStyles.subtitle2
                  .copyWith(color: AskLoraColors.charcoal),
            ),
          ],
        ),
      );
}
