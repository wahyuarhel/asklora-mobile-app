import 'package:flutter/material.dart';

import '../../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../bot_stock/utils/bot_stock_utils.dart';
import '../../../../../learning/learning_bot_stock_screen.dart';
import '../../../../../onboarding/kyc/presentation/widgets/custom_stepper/custom_stepper.dart';
import 'badge_label.dart';

class MilestonesStepDetails extends StatelessWidget {
  const MilestonesStepDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _startInvestingSteps(context),
        _tradeWithBotsSteps(context),
        _masterAiTradingSteps(context),
      ],
    );
  }

  Widget _headerWithBadge(String number, String label) => Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), border: Border.all()),
            child: Center(
                child: CustomTextNew(number, style: AskLoraTextStyles.h6)),
          ),
          Expanded(child: CustomTextNew(label, style: AskLoraTextStyles.h5))
        ],
      );

  Widget _labelWithBadge(String label, String badgeLabel) => Row(
        children: [
          CustomTextNew(label, style: AskLoraTextStyles.body1),
          BadgeLabel(
            badgeLabel,
            margin: const EdgeInsets.only(left: 10),
          ),
        ],
      );

  Widget _startInvestingStep(String label, String badge,
          {bool drawLine = true, double spaceVertical = 30}) =>
      CustomStep(
        widgetStep: _labelWithBadge(label, badge),
        drawLine: drawLine,
        spaceVertical: spaceVertical,
        spaceHorizontal: 30,
      );

  Widget _startInvestingSteps(BuildContext context) => Column(
        children: [
          _headerWithBadge('1', S.of(context).startInvesting),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              children: [
                _startInvestingStep(S.of(context).privacyEvaluation,
                    S.of(context).min(1.toString())),
                _startInvestingStep(S.of(context).personalisation,
                    S.of(context).min(1.toString())),
                _startInvestingStep(S.of(context).createAnAccount,
                    S.of(context).min(1.toString())),
                _startInvestingStep(
                    S.of(context).defineInvestmentStyle.toTitleCase,
                    S.of(context).min(2.toString())),
                _startInvestingStep(S.of(context).openInvestmentAccount,
                    S.of(context).min(20.toString())),
                _startInvestingStep(S.of(context).getTheFirstBotstockForFree,
                    S.of(context).min(2.toString())),
                _startInvestingStep(S.of(context).payDepositToStartRealTrade,
                    S.of(context).min(10.toString()),
                    drawLine: false, spaceVertical: 10),
              ],
            ),
          ),
        ],
      );

  Widget _labelStepWithButton(BuildContext context,
          {required String label, required VoidCallback onTap}) =>
      Row(
        children: [
          Expanded(
              flex: 5,
              child: CustomTextNew(label, style: AskLoraTextStyles.body1)),
          Expanded(
              flex: 2,
              child: SizedBox(
                height: 25,
                child: PrimaryButton(
                  label: S.of(context).relearn.toUpperCase(),
                  onTap: onTap,
                  buttonPrimarySize: ButtonPrimarySize.small,
                ),
              )),
        ],
      );
  Widget _tradeWithBotsSteps(BuildContext context) => Column(
        children: [
          _headerWithBadge('2', S.of(context).tradeWithBots),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              children: [
                CustomStep(
                  widgetStep: _labelStepWithButton(
                    context,
                    label: S.of(context).introduceBotPlank,
                    onTap: () => LearningBotStockScreen.open(
                      context: context,
                      botType: BotType.plank,
                    ),
                  ),
                  drawLine: true,
                  spaceVertical: 30,
                  spaceHorizontal: 30,
                ),
                CustomStep(
                  widgetStep: _labelStepWithButton(
                    context,
                    label: S.of(context).introduceBotPullup,
                    onTap: () => LearningBotStockScreen.open(
                      context: context,
                      botType: BotType.pullUp,
                    ),
                  ),
                  drawLine: true,
                  spaceVertical: 30,
                  spaceHorizontal: 30,
                ),
                CustomStep(
                  widgetStep: _labelStepWithButton(
                    context,
                    label: S.of(context).introduceBotSquat,
                    onTap: () => LearningBotStockScreen.open(
                      context: context,
                      botType: BotType.squat,
                    ),
                  ),
                  drawLine: true,
                  spaceVertical: 30,
                  spaceHorizontal: 30,
                ),
                CustomStep(
                  widgetStep: _labelStepWithButton(
                    context,
                    label: S.of(context).tradeWithYourFirstBotstock,
                    onTap: () {},
                  ),
                  spaceHorizontal: 30,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _masterAiTradingSteps(BuildContext context) => Column(
        children: [
          _headerWithBadge('3', S.of(context).masterAiTrading),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              children: [
                CustomStep(
                  widgetStep: _labelStepWithButton(
                    context,
                    label: S.of(context).learnBotstockManagement,
                    onTap: () {},
                  ),
                  drawLine: true,
                  spaceVertical: 30,
                  spaceHorizontal: 30,
                ),
                CustomStep(
                  widgetStep: _labelStepWithButton(
                    context,
                    label: S.of(context).manageYourBotstock,
                    onTap: () {},
                  ),
                  drawLine: true,
                  spaceVertical: 30,
                  spaceHorizontal: 30,
                ),
                CustomStep(
                  widgetStep: _labelStepWithButton(
                    context,
                    label: S.of(context).tradeWithANewBotstock,
                    onTap: () {},
                  ),
                  spaceHorizontal: 30,
                ),
              ],
            ),
          ),
        ],
      );
}
