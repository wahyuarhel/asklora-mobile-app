part of 'ai_investment_style_question_bloc.dart';

class AiInvestmentStyleQuestionState extends Equatable {
  final String query;
  final String userName;
  final String userId;
  final String sessionId;
  final List<Conversation> conversations;
  final bool isTyping;
  final ISQInteraction interaction;
  final InvestmentStyleQuestionResult? result;
  final ResponseState ppiResponseState;
  final bool isChatAnimationRunning;

  const AiInvestmentStyleQuestionState({
    this.query = '',
    this.sessionId = '',
    this.userName = '',
    this.userId = '',
    this.conversations = const [],
    this.isTyping = false,
    this.interaction = const TextFieldInteraction(),
    this.result,
    this.ppiResponseState = ResponseState.unknown,
    this.isChatAnimationRunning = false,
  });

  AiInvestmentStyleQuestionState copyWith({
    String? query,
    String? sessionId,
    String? userName,
    String? userId,
    List<Conversation>? conversations,
    bool? isTyping,
    ISQInteraction? interaction,
    InvestmentStyleQuestionResult? result,
    ResponseState? ppiResponseState,
    bool? isChatAnimationRunning,
  }) {
    return AiInvestmentStyleQuestionState(
      query: query ?? this.query,
      sessionId: sessionId ?? this.sessionId,
      conversations: conversations ?? this.conversations,
      isTyping: isTyping ?? this.isTyping,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      interaction: interaction ?? this.interaction,
      result: result ?? this.result,
      ppiResponseState: ppiResponseState ?? this.ppiResponseState,
      isChatAnimationRunning:
          isChatAnimationRunning ?? this.isChatAnimationRunning,
    );
  }

  @override
  List<Object> get props => [
        query,
        sessionId,
        conversations,
        isTyping,
        userName,
        userId,
        interaction,
        result ?? '',
        ppiResponseState,
        isChatAnimationRunning,
        DateTime.timestamp()
      ];

  bool get isTextFieldSendButtonDisabled =>
      isTyping || query.isEmpty || isChatAnimationRunning;
}
