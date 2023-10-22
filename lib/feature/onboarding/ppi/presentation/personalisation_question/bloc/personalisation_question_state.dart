part of 'personalisation_question_bloc.dart';

class PersonalisationQuestionState extends Equatable {
  const PersonalisationQuestionState() : super();

  PersonalisationQuestionState copyWith() {
    return const PersonalisationQuestionState();
  }

  @override
  List<Object> get props => [];
}

class OnNextPersonalizationQuestion<T> extends PersonalisationQuestionState {
  final QuestionType questionType;
  final int personalizationQuestionIndex;
  final T question;
  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  OnNextPersonalizationQuestion(
    this.questionType,
    this.question, {
    required this.personalizationQuestionIndex,
  });

  @override
  List<Object> get props => [questionType, timeStamp];
}

class OnNextToInvestmentStyleQuestionScreen
    extends PersonalisationQuestionState {}

class OnPreviousToPrivacyQuestionScreen extends PersonalisationQuestionState {}

class OnNextResultEndScreen extends PersonalisationQuestionState {}
