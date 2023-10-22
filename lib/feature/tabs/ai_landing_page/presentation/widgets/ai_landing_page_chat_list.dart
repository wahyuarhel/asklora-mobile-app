part of '../ai_landing_page.dart';

class AiLandingPageChatList extends StatelessWidget {
  final AiThemeType aiThemeType;
  final List<Conversation> conversations;

  const AiLandingPageChatList(
      {required this.conversations, required this.aiThemeType, super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Colors.black, Colors.black.withOpacity(0)],
            stops: const [0.05, 0.25]).createShader(rect);
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
                  .map(
                    (conversation) => Padding(
                      padding: const EdgeInsets.only(bottom: 17),
                      child: _getBubbleChat(context, conversation),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _updateConversation(BuildContext context, Conversation conversation) {
    if (conversation.isNeedCallback) {
      context.read<MainAiLoraGptBloc>().add(OnFinishTyping(conversation));
    }
  }

  Widget _getBubbleChat(BuildContext context, Conversation e) {
    if (e is Lora) {
      return OutChatBubbleWidget(
        key: Key(e.text),
        e.text.toString(),
        animateText: e.isNeedCallback,
        onStartAnimation: () =>
            context.read<MainAiLoraGptBloc>().add(const OnStartTyping()),
        onFinishedAnimation: () => _updateConversation(context, e),
      );
    } else if (e is Me) {
      return InChatBubbleWidget(message: e.text, name: e.userName);
    } else if (e is Reset) {
      return const SessionResetWidget();
    } else if (e is Component) {
      _updateConversation(context, e);

      return ComponentWidget(
        aiThemeType: aiThemeType,
        component: e,
      );
    } else if (e is Loading) {
      _updateConversation(context, e);
      return const LoraThinkingWidget();
    } else {
      return const SizedBox.shrink();
    }
  }
}
