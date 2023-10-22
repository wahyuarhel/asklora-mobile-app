part of 'demonstration_question_bloc.dart';

abstract class DemonstrationQuestionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AnswerQuestion extends DemonstrationQuestionEvent {
  final int questionIndex;

  AnswerQuestion(this.questionIndex);
}

class FetchQuestion extends DemonstrationQuestionEvent {}

class NextQuestion extends DemonstrationQuestionEvent {}

class PreviousQuestion extends DemonstrationQuestionEvent {}
