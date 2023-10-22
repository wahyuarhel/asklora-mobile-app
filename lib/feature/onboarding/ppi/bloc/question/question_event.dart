part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent() : super();

  @override
  List<Object?> get props => [];
}

class LoadQuestions extends QuestionEvent {
  const LoadQuestions() : super();

  @override
  List<Object?> get props => [];
}

class PrivacyQuestionIndexChanged extends QuestionEvent {
  const PrivacyQuestionIndexChanged(this.privacyQuestionIndex) : super();

  final int privacyQuestionIndex;

  @override
  List<Object> get props => [privacyQuestionIndex];
}

class PersonalisationQuestionIndexChanged extends QuestionEvent {
  final int personalisationQuestionIndex;

  const PersonalisationQuestionIndexChanged(this.personalisationQuestionIndex)
      : super();

  @override
  List<Object> get props => [personalisationQuestionIndex];
}

class CurrentPersonalisationPageIncremented extends QuestionEvent {
  const CurrentPersonalisationPageIncremented() : super();

  @override
  List<Object> get props => [];
}

class CurrentPrivacyPageIncremented extends QuestionEvent {
  const CurrentPrivacyPageIncremented() : super();

  @override
  List<Object> get props => [];
}

class CurrentPrivacyPageDecremented extends QuestionEvent {
  const CurrentPrivacyPageDecremented() : super();

  @override
  List<Object> get props => [];
}

class CurrentPersonalisationPageDecremented extends QuestionEvent {
  const CurrentPersonalisationPageDecremented() : super();

  @override
  List<Object> get props => [];
}

class ResetPrivacyAndPersonalisationPage extends QuestionEvent {
  const ResetPrivacyAndPersonalisationPage() : super();

  @override
  List<Object> get props => [];
}
