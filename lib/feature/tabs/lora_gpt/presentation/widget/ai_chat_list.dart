part of '../lora_ai_screen.dart';

class AiChatList extends StatefulWidget {
  final AiThemeType aiThemeType;

  const AiChatList({this.aiThemeType = AiThemeType.dark, super.key});

  @override
  State<AiChatList> createState() => _AiChatListState();
}

class _AiChatListState extends State<AiChatList> {
  final Duration _newChatButtonDuration = const Duration(milliseconds: 200);
  bool _showNewChatButton = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoraGptBloc, LoraGptState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.conversations != current.conversations,
      builder: (context, state) {
        return Stack(children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [Colors.black, Colors.black.withOpacity(0)],
                stops: const [0.0, 0.10],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black, Colors.black.withOpacity(0)],
                  stops: const [0, 0.15],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  setState(() {
                    if (direction == ScrollDirection.reverse) {
                      _showNewChatButton = false;
                    } else if (direction == ScrollDirection.forward) {
                      _showNewChatButton = true;
                    }
                  });
                  return true;
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    reverse: true,
                    child: Column(
                      children: state.conversations
                          .map(
                            (conversation) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 17, left: 20, right: 20),
                              child: _getBubbleChat(conversation),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )

                ///todo: some backup code in case something fishy happening
                /*ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 72),
              reverse: true,
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                final message = state
                    .conversations[(state.conversations.length - 1) - index];
                if (message is Lora) {
                  return OutChatBubbleWidget((message).response,
                      animateText: index == 0 && state.isTyping);
                } else if (message is Me) {
                  return InChatBubbleWidget(
                      message: (message).query, name: state.userName);
                } else if (message is Reset) {
                  return _sessionResetWidget();
                } else {
                  return const LoraThinkingWidget();
                }
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 17),
            )*/
                ,
              ),
            ),
          ),
          if (FeatureFlags.isNewChatHide)
            const SizedBox.shrink()
          else
            AnimatedPositioned(
              bottom: state.status == ResponseState.loading ||
                      state.conversations.isEmpty ||
                      _showNewChatButton
                  ? 0
                  : 64,
              left: 0,
              right: 0,
              duration: _newChatButtonDuration,
              child: UnconstrainedBox(
                constrainedAxis: Axis.vertical,
                child: AnimatedOpacity(
                  opacity: state.status == ResponseState.loading ||
                          state.conversations.isEmpty ||
                          _showNewChatButton
                      ? 0
                      : 1,
                  duration: _newChatButtonDuration,
                  child: ElevatedButton(
                      onPressed: () => context
                          .read<LoraGptBloc>()
                          .add(const OnResetSession()),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: AskLoraColors.gray.withOpacity(0.8),
                        elevation: 0,
                        fixedSize: const Size(124, 32),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          CustomTextNew(
                            'New chat',
                            style: AskLoraTextStyles.body1
                                .copyWith(color: AskLoraColors.white),
                          )
                        ],
                      )),
                ),
              ),
            ),
        ]);
      },
    );
  }

  void _updateConversation(BuildContext context, Conversation conversation) {
    if (conversation.isNeedCallback) {
      context.read<LoraGptBloc>().add(OnFinishTyping(conversation));
    }
  }

  Widget _getBubbleChat(Conversation e) {
    if (e is Lora) {
      return OutChatBubbleWidget(
        e.text.toString(),
        animateText: e.isNeedCallback,
        onStartAnimation: () =>
            context.read<LoraGptBloc>().add(const OnStartTyping()),
        onFinishedAnimation: () => _updateConversation(context, e),
      );
    } else if (e is Me) {
      return InChatBubbleWidget(message: e.text, name: e.userName);
    } else if (e is Reset) {
      return const SessionResetWidget();
    } else if (e is Component) {
      _updateConversation(context, e);
      return ComponentWidget(
        aiThemeType: widget.aiThemeType,
        component: e,
      );
    } else if (e is Loading) {
      _updateConversation(context, e);
      return const LoraThinkingWidget();
    } else {
      return const SizedBox.shrink();
    }
  }

  ///todo: some backup code in case something fishy happening
// Widget _getBubbleChat(LoraGptState state, Conversation e, int index) {
//   final List<Conversation> reversedConversations =
//   List.from(state.conversations.reversed);
//   final message = reversedConversations[
//   (reversedConversations.length - 1) - reversedConversations.indexOf(e)];
//   if (e is Lora) {
//     print('outchat');
//     return OutChatBubbleWidget((e).response,
//       animateText:
//       reversedConversations.indexOf(e) == 0 && state.isTyping,);
//   } else if (e is Me) {
//     return InChatBubbleWidget(message: (e).query, name: state.userName);
//   } else if (e is Reset) {
//     return _sessionResetWidget();
//   } else {
//     return const LoraThinkingWidget();
//   }
// }
}
