import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/ai/conversation.dart';
import '../../../../../core/presentation/ai/chat/chat_lora_header.dart';
import '../../../../../core/presentation/ai/chat/in_chat_bubble_widget.dart';
import '../../../../../core/presentation/ai/chat/lora_thinking_widget.dart';
import '../../../../../core/presentation/ai/chat/out_chat_bubble_widget.dart';
import '../../../../../core/presentation/ai/utils/ai_utils.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/utils/storage/shared_preference.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../core/domain/ai/component.dart';
import '../../../../core/presentation/ai/chat/ai_text_field.dart';
import '../../lora_gpt/bloc/lora_gpt_bloc.dart';
import '../bloc/main_ai_lora_gpt_bloc.dart';
import '../../lora_gpt/presentation/widget/component_widget.dart';
import '../../lora_gpt/presentation/widget/session_reset_widget.dart';
import '../../lora_gpt/repository/lora_gpt_repository.dart';

part 'widgets/ai_landing_page_chat_list.dart';

class AiLandingPage extends StatelessWidget {
  final AiThemeType aiThemeType;
  static const String route = '/ai_landing_page';

  const AiLandingPage({this.aiThemeType = AiThemeType.dark, super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => MainAiLoraGptBloc(
          sharedPreference: SharedPreference(),
          loraGptRepository: LoraGptRepository(),
        )
          ..add(const OnLoraOpened())
          ..add(const FetchIntros()),
        child: WillPopScope(
          onWillPop: () async => false,
          child: CustomScaffold(
            enableBackNavigation: false,
            appBarBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: AppValues.screenHorizontalPadding
                  .copyWith(top: 8, bottom: 12),
              child: Column(
                children: [
                  _header,
                  _chatList,
                  _bottomContent,
                ],
              ),
            ),
          ),
        ),
      );

  Widget get _header => Align(
        alignment: Alignment.topCenter,
        child: ChatLoraHeader(
          title: 'Lora',
          aiThemeType: aiThemeType,
        ),
      );

  Widget get _chatList => Expanded(
        child: BlocBuilder<MainAiLoraGptBloc, LoraGptState>(
          buildWhen: (previous, current) =>
              previous.conversations != current.conversations ||
              previous.status != current.status,
          builder: (context, state) => AiLandingPageChatList(
            aiThemeType: aiThemeType,
            conversations: state.conversations,
          ),
        ),
      );

  Widget get _bottomContent => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BlocBuilder<MainAiLoraGptBloc, LoraGptState>(
              buildWhen: (previous, current) =>
                  previous.isTextFieldSendButtonDisabled !=
                  current.isTextFieldSendButtonDisabled,
              builder: (context, state) {
                return AiTextField(
                  aiThemeType: aiThemeType,
                  isSendButtonDisabled: state.isTextFieldSendButtonDisabled,
                  onFieldSubmitted: (_) {},
                  onChanged: (value) =>
                      context.read<MainAiLoraGptBloc>().add(OnEditQuery(value)),
                  onTap: () => context
                      .read<MainAiLoraGptBloc>()
                      .add(const OnSearchQuery()),
                );
              }),
        ),
      );

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushNamed(route);
}
