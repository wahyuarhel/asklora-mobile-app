part of 'lora_ai_screen.dart';

class LoraGptScreen extends StatelessWidget {
  const LoraGptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBackNavigation: false,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          if (FeatureFlags.showAiDebugWidget) const AiDebugWidget(),
          _header(context),
          const Expanded(child: AiChatList()),
          _bottomContent
        ],
      ),
    );
  }

  Widget _header(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 60,
        child: Stack(
          children: [
            const Center(child: ChatLoraHeader(title: 'Lora')),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<TabScreenBloc>().add(const CloseAiOverLay());
                },
                child: const Icon(Icons.close, color: AskLoraColors.white),
              ),
            )
          ],
        ),
      );

  Widget get _bottomContent {
    return BlocBuilder<LoraGptBloc, LoraGptState>(
      buildWhen: (previous, current) =>
          previous.isTextFieldSendButtonDisabled !=
          current.isTextFieldSendButtonDisabled,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
        child: AiTextField(
          isSendButtonDisabled: state.isTextFieldSendButtonDisabled,
          onFieldSubmitted: (str) =>
              context.read<LoraGptBloc>().add(OnEditQuery(str)),
          onChanged: (str) => context.read<LoraGptBloc>().add(OnEditQuery(str)),
          onTap: () {
            FocusScope.of(context).unfocus();
            context.read<LoraGptBloc>().add(const OnSearchQuery());
          },
          aiThemeType: AiThemeType.dark,
        ),
      ),
    );
  }
}
