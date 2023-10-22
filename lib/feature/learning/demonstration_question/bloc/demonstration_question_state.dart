part of 'demonstration_question_bloc.dart';

class DemonstrationQuestionState extends Equatable {
  final int questionIndex;
  final List<bool> questionAnsweredList;
  final List<Question> questionCollection;

  const DemonstrationQuestionState(
      {this.questionIndex = 0,
      this.questionAnsweredList = const [],
      this.questionCollection = const []})
      : super();

  DemonstrationQuestionState copyWith({
    int? questionIndex,
    List<bool>? questionAnsweredList,
    List<Question>? questionCollection,
  }) {
    return DemonstrationQuestionState(
        questionIndex: questionIndex ?? this.questionIndex,
        questionCollection: questionCollection ?? this.questionCollection,
        questionAnsweredList:
            questionAnsweredList ?? this.questionAnsweredList);
  }

  @override
  List<Object> get props =>
      [questionIndex, questionAnsweredList, questionCollection];
}
