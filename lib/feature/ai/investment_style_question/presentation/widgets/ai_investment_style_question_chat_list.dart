part of '../ai_investment_style_question_form.dart';

class AiInvestmentStyleQuestionChatList extends StatelessWidget {
  final AiThemeType aiThemeType;
  final List<Conversation> conversations;
  final bool isTyping;

  const AiInvestmentStyleQuestionChatList(
      {required this.conversations,
      required this.isTyping,
      required this.aiThemeType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Colors.black, Colors.black.withOpacity(0)],
            stops: const [0.1, 0.25]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.black, Colors.black.withOpacity(0)],
              stops: const [0.0, 0.08]).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 72, bottom: 6),
            reverse: true,
            child: Column(
              children: conversations
                  .mapIndexed(
                    (index, conversation) => Padding(
                      padding: const EdgeInsets.only(bottom: 17),
                      child: _getBubbleChat(
                          context, conversation, index, _isAnimateText(index)),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  bool _isAnimateText(int index) =>
      !isTyping &&
      (index == conversations.length - 1 ||
          (index == conversations.length - 2 &&
              conversations.last is NextButton));

  Widget _getBubbleChat(
      BuildContext context, Conversation e, int index, bool animateText) {
    if (e is Lora) {
      return OutChatExpandedBubbleWidget(
        e.text,
        animateText: animateText,
        onFinishedAnimation: () => context
            .read<AiInvestmentStyleQuestionBloc>()
            .add(const FinishChatAnimation()),
        aiThemeType: aiThemeType,
      );
    } else if (e is Me) {
      return InChatBubbleWidget(
        message: e.text,
        name: e.userName,
        aiThemeType: aiThemeType,
      );
    } else if (e is Loading) {
      return LoraThinkingWidget(aiThemeType: aiThemeType);
    } else if (e is Component) {
      _updateConversation(context, e.isNeedCallback);
      return LoraAiButton(
        textStyle: AskLoraTextStyles.button3
            .copyWith(color: aiThemeType.primaryFontColor),
        textColor: aiThemeType.secondaryFontColor,
        borderColor: aiThemeType.choicesInteractionBorderColor,
        pressedFillColor: AskLoraColors.primaryGreen.withOpacity(0.4),
        fillColor: Colors.transparent,
        postfixIconColor: AskLoraColors.charcoal,
        label: e.label,
        onTap: () => {
          context
              .read<AiInvestmentStyleQuestionBloc>()
              .add(QueryChanged(e.label)),
          context.read<AiInvestmentStyleQuestionBloc>().add(const SubmitQuery())
        },
      );
    } else if (e is NextButton) {
      return AiInvestmentStyleQuestionNextButton(aiThemeType: aiThemeType);
    } else {
      return const SizedBox.shrink();
    }
  }

  void _updateConversation(BuildContext context, bool isNeedCallback) {
    if (isNeedCallback) {
      context
          .read<AiInvestmentStyleQuestionBloc>()
          .add(const FinishChatAnimation());
    }
  }
}
