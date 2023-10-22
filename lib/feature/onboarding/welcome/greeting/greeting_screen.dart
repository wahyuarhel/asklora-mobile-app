import 'package:flutter/material.dart';

import '../../../../core/domain/pair.dart';
import '../../../../core/presentation/ai/lora_animation_green.dart';
import '../../../../core/presentation/ai/utils/ai_utils.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../generated/l10n.dart';
import '../../../ai/presentation/widgets/ai_layout_with_background_layout.dart';
import '../../ppi/bloc/question/question_bloc.dart';
import '../../ppi/presentation/ppi_screen.dart';

class GreetingScreen extends StatelessWidget {
  static const route = '/greeting_screen';
  final String name;

  const GreetingScreen({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AiLayoutWithBackground(
      aiThemeType: AiThemeType.light,
      content: CustomScaffold(
          enableBackNavigation: false,
          appBarBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          body: CustomStretchedLayout(
            contentPadding: EdgeInsets.zero,
            content: Column(
              children: [
                const SizedBox(height: 50),
                const LoraAnimationGreen(),
                Center(
                    child:
                        getPngImage('splash_screen', width: 210, height: 100)),
                Align(
                  alignment: Alignment.center,
                  child: CustomTextNew(
                    S.of(context).throughoutYourInvestmentJourney,
                    style: AskLoraTextStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                _glowingAiChatIcon(),
              ],
            ),
            bottomButton: Padding(
              padding: const EdgeInsets.only(bottom: 35, top: 24),
              child: PrimaryButton(
                key: const Key('next_button'),
                label: S.of(context).letsGo,
                onTap: () => PpiScreen.open(context,
                    arguments: const Pair(
                        QuestionPageType.privacy, QuestionPageStep.privacy)),
              ),
            ),
          )),
    );
  }

  Widget _glowingAiChatIcon() => Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: AskLoraColors.primaryGreen,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
              bottomLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: AskLoraColors.primaryGreen,
                blurRadius: 20,
                spreadRadius: 3),
            BoxShadow(
                color: AskLoraColors.primaryGreen,
                blurRadius: 40,
                spreadRadius: 3),
          ],
        ),
        child: getSvgIcon('bottom_nav_asklora_ai_selected_black',
            width: 100, height: 100),
      );

  static void open(BuildContext context, String name) =>
      Navigator.of(context).pushNamed(route, arguments: name);
}
