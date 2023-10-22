part of '../ai_investment_style_question_form.dart';

class InteractionWidget extends StatelessWidget {
  final ISQInteraction interaction;
  final AiThemeType aiThemeType;

  const InteractionWidget(
      {required this.interaction, required this.aiThemeType, super.key});

  @override
  Widget build(BuildContext context) {
    switch (interaction.type()) {
      case ISQInteractionType.textField:
        return BlocBuilder<AiInvestmentStyleQuestionBloc,
            AiInvestmentStyleQuestionState>(
          buildWhen: (previous, current) =>
              previous.isTextFieldSendButtonDisabled !=
              current.isTextFieldSendButtonDisabled,
          builder: (context, state) => AiTextField(
            hintText: 'Tell me your interests...',
            aiThemeType: aiThemeType,
            isSendButtonDisabled: state.isTextFieldSendButtonDisabled,
            onFieldSubmitted: (_) {},
            onChanged: (value) => context
                .read<AiInvestmentStyleQuestionBloc>()
                .add(QueryChanged(value)),
            onTap: () => context
                .read<AiInvestmentStyleQuestionBloc>()
                .add(const SubmitQuery()),
          ),
        );
      case ISQInteractionType.choices:
        return BlocBuilder<AiInvestmentStyleQuestionBloc,
                AiInvestmentStyleQuestionState>(
            buildWhen: (previous, current) =>
                previous.isChatAnimationRunning !=
                current.isChatAnimationRunning,
            builder: (context, state) {
              return Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 12,
                runSpacing: 12,
                children: (interaction as ChoicesInteraction)
                    .choices
                    .entries
                    .map((value) => state.isChatAnimationRunning
                        ? ShimmerWidget(
                            width:
                                value.value.textWidth(AskLoraTextStyles.body1) +
                                    30.2,
                            height: 39.2)
                        : CustomChoiceChips(
                            textStyle: AskLoraTextStyles.body1
                                .copyWith(color: aiThemeType.primaryFontColor),
                            textColor: aiThemeType.secondaryFontColor,
                            borderColor:
                                aiThemeType.choicesInteractionBorderColor,
                            pressedFillColor:
                                AskLoraColors.primaryGreen.withOpacity(0.4),
                            fillColor: AskLoraColors.white.withOpacity(0.2),
                            label: value.value,
                            onTap: () => context
                                .read<AiInvestmentStyleQuestionBloc>()
                                .add(SubmitAnswer(
                                    answerId: value.key,
                                    answerText: value.value)),
                          ))
                    .toList(),
              );
            });
      case ISQInteractionType.summary:
        final ButtonPrimaryType buttonPrimaryType =
            aiThemeType == AiThemeType.dark
                ? ButtonPrimaryType.whiteTransparency
                : ButtonPrimaryType.ghostCharcoal;
        return BlocBuilder<AiInvestmentStyleQuestionBloc,
                AiInvestmentStyleQuestionState>(
            buildWhen: (previous, current) =>
                previous.isChatAnimationRunning !=
                current.isChatAnimationRunning,
            builder: (context, state) {
              return Column(
                children: [
                  state.isChatAnimationRunning
                      ? const ShimmerWidget(width: double.infinity, height: 55)
                      : PrimaryButton(
                          label: S.of(context).seeMyRecommendations,
                          onTap: () => context
                              .read<AiInvestmentStyleQuestionBloc>()
                              .add(const SendResultToPpi()),
                          buttonPrimaryType: buttonPrimaryType),
                  const SizedBox(
                    height: 10,
                  ),
                  state.isChatAnimationRunning
                      ? const ShimmerWidget(width: double.infinity, height: 55)
                      : PrimaryButton(
                          label: S.of(context).startAgain,
                          onTap: () => context
                              .read<AiInvestmentStyleQuestionBloc>()
                              .add(const ResetSession()),
                          buttonPrimaryType: buttonPrimaryType,
                        ),
                ],
              );
            });
      case ISQInteractionType.error:
        return BlocBuilder<AiInvestmentStyleQuestionBloc,
            AiInvestmentStyleQuestionState>(
          buildWhen: (previous, current) =>
              previous.isChatAnimationRunning != current.isChatAnimationRunning,
          builder: (context, state) => PrimaryButton(
            label: S.of(context).startAgain,
            onTap: () => context
                .read<AiInvestmentStyleQuestionBloc>()
                .add(const ResetSession()),
            buttonPrimaryType: ButtonPrimaryType.ghostCharcoal,
          ),
        );
      case ISQInteractionType.empty:
        return const SizedBox.shrink();
    }
  }
}
