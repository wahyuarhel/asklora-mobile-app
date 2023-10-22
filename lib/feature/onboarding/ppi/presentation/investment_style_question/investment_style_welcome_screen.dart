import 'package:flutter/material.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../../core/presentation/lora_animation_header.dart';
import '../../../../../generated/l10n.dart';
import '../../../../ai/investment_style_question/presentation/ai_investment_style_question_welcome_screen.dart';
import '../../../../tabs/presentation/tab_screen.dart';

class InvestmentStyleWelcomeScreen extends StatelessWidget {
  static const String route = '/investment_style_welcome_screen';

  const InvestmentStyleWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScaffold(
        enableBackNavigation: false,
        body: CustomStretchedLayout(
          content: LoraAnimationHeader(
              text: S.of(context).investmentStyleWelcomeTitle),
          bottomButton: ButtonPair(
              primaryButtonOnClick: () =>
                  AiInvestmentStyleQuestionWelcomeScreen.open(context),
              secondaryButtonOnClick: () =>
                  TabScreen.openAndRemoveAllRoute(context),
              primaryButtonLabel: S.of(context).defineInvestmentStyle,
              secondaryButtonLabel: S.of(context).buttonMaybeLater),
        ),
      );

  static void open(BuildContext context) => Navigator.pushNamed(context, route);

  static void openAndRemoveAllRoute(BuildContext context) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
}
