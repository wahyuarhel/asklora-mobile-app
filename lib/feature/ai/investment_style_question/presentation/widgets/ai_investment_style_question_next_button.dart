part of '../ai_investment_style_question_form.dart';

class AiInvestmentStyleQuestionNextButton extends StatelessWidget {
  final AiThemeType aiThemeType;

  const AiInvestmentStyleQuestionNextButton(
      {required this.aiThemeType, super.key});

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomLeft,
        child: BlocBuilder<AiInvestmentStyleQuestionBloc,
            AiInvestmentStyleQuestionState>(
          buildWhen: (previous, current) =>
              previous.isChatAnimationRunning != current.isChatAnimationRunning,
          builder: (context, state) {
            return state.isChatAnimationRunning
                ? ShimmerWidget(
                    width: S
                            .of(context)
                            .isqNextButton
                            .textWidth(AskLoraTextStyles.body1) +
                        30.2,
                    height: 52)
                : CustomChoiceChips(
                    borderColor: aiThemeType.chatNextButtonBorderColor,
                    verticalPadding: 14,
                    textColor: aiThemeType.secondaryFontColor,
                    textStyle: AskLoraTextStyles.body1,
                    pressedFillColor:
                        AskLoraColors.primaryGreen.withOpacity(0.4),
                    fillColor: Colors.transparent,
                    label: S.of(context).isqNextButton,
                    onTap: () => context
                        .read<AiInvestmentStyleQuestionBloc>()
                        .add(const NextQuestion()),
                  );
          },
        ),
      );
}
