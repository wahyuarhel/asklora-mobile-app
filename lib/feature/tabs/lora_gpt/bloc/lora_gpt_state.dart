part of 'lora_gpt_bloc.dart';

class LoraGptState extends Equatable {
  final String debugText;
  final ResponseState status;
  final String query;
  final String userName;
  final String userId;
  final String sessionId;
  final bool isTypingAnimationDone;
  final List<Conversation> conversations;
  final List<Botstock> botstocks;
  final double totalPnl;
  final TabPage tabPage;

  const LoraGptState({
    this.debugText = '',
    this.query = '',
    this.sessionId = '',
    this.status = ResponseState.unknown,
    this.userName = '',
    this.userId = '',
    this.conversations = const [],
    this.isTypingAnimationDone = true,
    // this.shouldShowOverlay = true,
    this.botstocks = const [],
    this.totalPnl = 0,
    this.tabPage = TabPage.forYou,
  });

  LoraGptState copyWith({
    String? debugText,
    String? query,
    String? sessionId,
    String? userName,
    String? userId,
    bool? isTypingAnimationDone,
    List<Conversation>? conversations,
    ResponseState? status,
    List<Botstock>? botstocks,
    double? totalPnl,
    TabPage? tabPage,
  }) {
    return LoraGptState(
      debugText: debugText ?? this.debugText,
      query: query ?? this.query,
      sessionId: sessionId ?? this.sessionId,
      conversations: conversations ?? this.conversations,
      status: status ?? this.status,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      isTypingAnimationDone:
          isTypingAnimationDone ?? this.isTypingAnimationDone,
      botstocks: botstocks ?? this.botstocks,
      totalPnl: totalPnl ?? this.totalPnl,
      tabPage: tabPage ?? this.tabPage,
    );
  }

  PortfolioQueryRequest get getPortfolioRequest => PortfolioQueryRequest(
        totalPnl: totalPnl,
        input: query.trim(),
        userId: userId,
        username: userName,
        platform: aiPlatform,
      );

  PortfolioDetailsRequest get getPortfolioDetailsRequest =>
      PortfolioDetailsRequest(
          ticker: tabPage.getArguments.arguments['ticker'],
          input: query.trim(),
          userId: userId,
          username: userName,
          platform: aiPlatform,
          botType: tabPage.getArguments.arguments['botType'],
          tickerSymbol: tabPage.getArguments.arguments['symbol'],
          duration: tabPage.getArguments.arguments['duration']);

  GeneralQueryRequest get getGeneralChatRequest => GeneralQueryRequest(
        input: query.trim(),
        userId: userId,
        username: userName,
        platform: aiPlatform,
        sessionId: '',
      );

  GeneralQueryRequest get getLandingPageIntroRequest => GeneralQueryRequest(
        input: '',
        userId: userId,
        username: userName,
        platform: aiPlatform,
        sessionId: '',
      );

  BotstockIntro getIntroRequest(
          {required String botType,
          required String tickerSymbol,
          required String ticker,
          required String investmentHorizon}) =>
      BotstockIntro(
          botType: botType,
          tickerSymbol: tickerSymbol,
          ticker: ticker,
          investmentHorizon: investmentHorizon,
          userId: userId,
          platform: aiPlatform,
          username: userName);

  @override
  List<Object> get props => [
        debugText,
        query,
        sessionId,
        conversations,
        status,
        userName,
        userId,
        isTypingAnimationDone,
        botstocks,
        totalPnl,
        tabPage,
        isTextFieldSendButtonDisabled,
      ];

  bool get isTextFieldSendButtonDisabled =>
      !isTypingAnimationDone || query.trim().isEmpty;
}
