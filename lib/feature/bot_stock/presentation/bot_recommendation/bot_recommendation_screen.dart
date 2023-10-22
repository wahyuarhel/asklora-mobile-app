import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../app/bloc/app_bloc.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/presentation/ai/utils/ai_utils.dart';
import '../../../../core/presentation/auto_sized_text_widget.dart';
import '../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../core/presentation/lora_popup_message/lora_popup_message.dart';
import '../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../core/presentation/shimmer.dart';
import '../../../../core/presentation/tutorial/Utils/tutorial_journey.dart';
import '../../../../core/presentation/tutorial/bloc/tutorial_bloc.dart';
import '../../../../core/presentation/tutorial/custom_show_case_view.dart';
import '../../../../core/utils/feature_flags.dart';
import '../../../../generated/l10n.dart';
import '../../../ai/investment_style_question/presentation/ai_investment_style_question_welcome_screen.dart';
import '../../../tabs/bloc/tab_screen_bloc.dart';
import '../../../tabs/for_you/for_you_screen_form.dart';
import '../../../tabs/for_you/investment_style/presentation/ai_investment_style_question_for_you_screen.dart';
import '../../../tabs/utils/tab_util.dart';
import '../../bloc/bot_stock_bloc.dart';
import '../../domain/bot_recommendation_model.dart';
import '../../utils/bot_stock_utils.dart';
import '../widgets/custom_expansion_panel.dart';
import 'detail/bot_recommendation_detail_screen.dart';

part 'widgets/bot_learn_more_bottom_sheet.dart';

part 'widgets/bot_recommendation_card.dart';

part 'widgets/bot_recommendation_card_shimmer.dart';

part 'widgets/bot_recommendation_faq.dart';

part 'widgets/bot_recommendation_list.dart';

class BotRecommendationScreen extends StatelessWidget {
  final bool enableBackNavigation;

  const BotRecommendationScreen({this.enableBackNavigation = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        enableBackNavigation: enableBackNavigation,
        backgroundColor: AskLoraColors.white,
        body: Padding(
          padding: EdgeInsets.only(top: enableBackNavigation ? 70 : 20),
          child: BlocConsumer<BotStockBloc, BotStockState>(
            listenWhen: (_, current) =>
                current.botRecommendationResponse.state ==
                ResponseState.success,
            listener: (context, state) => context
                .read<TutorialBloc>()
                .add(InitiateBotRecommendationTutorial()),
            buildWhen: (previous, current) =>
                previous.botRecommendationResponse !=
                current.botRecommendationResponse,
            builder: (context, state) {
              return BlocListener<TutorialBloc, TutorialState>(
                listenWhen: (_, current) => current.isBotRecommendationTutorial,
                listener: (context, tutorialState) =>
                    ShowCaseWidget.of(context).startShowCase([
                  TutorialJourney.botRecommendationList,
                  TutorialJourney.tabs,
                ]),
                child: CustomLayoutWithBlurPopUp(
                  loraPopUpMessageModel: _getLoraPopUpMessageModel(
                      context: context,
                      validationCode:
                          state.botRecommendationResponse.validationCode),
                  showPopUp: state.botRecommendationResponse.state ==
                      ResponseState.error,
                  content: Column(
                    children: [
                      _header(
                          context: context,
                          userJourney:
                              context.read<AppBloc>().state.userJourney,
                          updated: state.botRecommendationResponse.data
                                  ?.updatedFormatted ??
                              '-'),
                      Expanded(
                        child: CustomShowcaseView(
                          tooltipPosition: TooltipPosition.top,
                          tutorialKey: TutorialJourney.botRecommendationList,
                          targetBorderRadius: BorderRadius.zero,
                          targetPadding: EdgeInsets.zero,
                          boxShadow: const BoxShadow(color: Colors.transparent),
                          onToolTipClick: () {
                            ShowCaseWidget.of(context).next();
                          },
                          tooltipWidget: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: S
                                        .of(context)
                                        .botRecommendationTutorialDesc1,
                                    style: AskLoraTextStyles.body1),
                                TextSpan(
                                    text: S
                                        .of(context)
                                        .botRecommendationTutorialDesc2,
                                    style: AskLoraTextStyles.subtitle2),
                                TextSpan(
                                    text: S
                                        .of(context)
                                        .botRecommendationTutorialDesc3,
                                    style: AskLoraTextStyles.body1),
                              ],
                            ),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.only(bottom: 35),
                            children: [
                              BotRecommendationList(
                                verticalMargin: 14,
                                botStockState: state,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget _header(
      {required BuildContext context,
      required UserJourney userJourney,
      required String updated}) {
    return Padding(
      padding: AppValues.screenHorizontalPadding.copyWith(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextNew(
            S.of(context).botRecommendationScreenTitle,
            style: AskLoraTextStyles.h2.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(height: 16),
          CustomTextNew(
            S.of(context).updatedAt(updated),
            style:
                AskLoraTextStyles.body2.copyWith(color: AskLoraColors.darkGray),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: AutoSizedTextWidget(
                  S.of(context).notTheStockYouWereLooking,
                  textAlign: TextAlign.center,
                  style: AskLoraTextStyles.subtitle2
                      .copyWith(color: AskLoraColors.primaryMagenta),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: PrimaryButton(
                  label: S.of(context).pressToRedoISQ,
                  onTap: () => _redoIsq(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (userJourney == UserJourney.freeBotStock)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextNew(
                  'Hi! Check out my 20 recommended Botstocks just for you.',
                  style: AskLoraTextStyles.body1
                      .copyWith(color: AskLoraColors.charcoal),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextNew(
                  'Select a Botstock to trade it for FREE!',
                  style: AskLoraTextStyles.subtitle2
                      .copyWith(color: AskLoraColors.charcoal),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const BotLearnMoreBottomSheet(),
                  ),
                  child: CustomTextNew(
                    'Redemption Instructions',
                    style: AskLoraTextStyles.subtitle1.copyWith(
                      color: AskLoraColors.charcoal,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  LoraPopUpMessageModel _getLoraPopUpMessageModel(
      {required BuildContext context, required ValidationCode validationCode}) {
    switch (validationCode) {
      case ValidationCode.redoIsq:
        return LoraPopUpMessageModel(
          title: 'No Botstock recommendations',
          subTitle:
              'Oops! Looks like there aren’t enough recommendations that meet your current investment profile - Let’s go through your Investment Style again to find suitable recommendations.',
          primaryButtonLabel: S.of(context).retakeInvestmentStyle,
          onPrimaryButtonTap: () => _redoIsq(context),
        );
      default:
        return LoraPopUpMessageModel(
          title: S.of(context).errorGettingInformationTitle,
          subTitle:
              S.of(context).errorGettingInformationInvestmentDetailSubTitle,
          primaryButtonLabel: S.of(context).buttonReloadPage,
          onSecondaryButtonTap: () => Navigator.pop(context),
          onPrimaryButtonTap: () => UserJourney.onAlreadyPassed(
              context: context,
              target: UserJourney.freeBotStock,
              onTrueCallback: () =>
                  context.read<BotStockBloc>().add(FetchBotRecommendation()),
              onFalseCallback: () => context
                  .read<BotStockBloc>()
                  .add(FetchFreeBotRecommendation())),
        );
    }
  }

  void _redoIsq(BuildContext context) {
    AiInvestmentStyleQuestionForYouScreen.open(context,
        aiThemeType: AiThemeType.light);
  }
}
