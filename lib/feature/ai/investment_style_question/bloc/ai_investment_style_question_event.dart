part of 'ai_investment_style_question_bloc.dart';

abstract class AiInvestmentStyleQuestionEvent extends Equatable {
  const AiInvestmentStyleQuestionEvent();
}

class InitiateAI extends AiInvestmentStyleQuestionEvent {
  const InitiateAI();

  @override
  List<Object?> get props => [];
}

class QueryChanged extends AiInvestmentStyleQuestionEvent {
  final String query;

  const QueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class SubmitQuery extends AiInvestmentStyleQuestionEvent {
  final bool isNewSession;
  final String answerId;

  const SubmitQuery({this.isNewSession = false, this.answerId = '-1'});

  @override
  List<Object?> get props => [isNewSession];
}

class NextQuestion extends AiInvestmentStyleQuestionEvent {
  const NextQuestion();

  @override
  List<Object?> get props => [];
}

class SendResultToPpi extends AiInvestmentStyleQuestionEvent {
  const SendResultToPpi();

  @override
  List<Object?> get props => [];
}

class SubmitAnswer extends AiInvestmentStyleQuestionEvent {
  final String answerId;
  final String answerText;

  const SubmitAnswer({required this.answerId, required this.answerText});

  @override
  List<Object?> get props => [answerId, answerText];
}

class ResetSession extends AiInvestmentStyleQuestionEvent {
  const ResetSession();

  @override
  List<Object?> get props => [];
}

class FinishChatAnimation extends AiInvestmentStyleQuestionEvent {
  const FinishChatAnimation();

  @override
  List<Object?> get props => [];
}
