part of 'privacy_question_bloc.dart';

class PrivacyQuestionState extends Equatable {
  const PrivacyQuestionState() : super();

  PrivacyQuestionState copyWith() {
    return const PrivacyQuestionState();
  }

  @override
  List<Object> get props => [];
}

class OnNextQuestion<T> extends PrivacyQuestionState {
  final QuestionType questionType;
  final int privacyQuestionIndex;
  final T question;
  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  OnNextQuestion(this.questionType, this.question,
      {required this.privacyQuestionIndex});

  @override
  List<Object> get props => [questionType, timeStamp];
}

class OnNextPersonalisationQuestionScreen extends PrivacyQuestionState {}

class OnNextResultSuccessScreen extends PrivacyQuestionState {}

class OnNextResultFailedScreen extends PrivacyQuestionState {}

class OnNextFinancialSituationScreen extends PrivacyQuestionState {}

class OnPreviousSignInSuccessScreen extends PrivacyQuestionState {}
