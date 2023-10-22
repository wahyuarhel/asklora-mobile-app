part of 'multiple_question_widget_bloc.dart';

class MultipleQuestionWidgetState extends Equatable {
  final int defaultChoiceIndex;

  const MultipleQuestionWidgetState({required this.defaultChoiceIndex})
      : super();

  MultipleQuestionWidgetState copyWith({int? defaultChoiceIndex}) {
    return MultipleQuestionWidgetState(
        defaultChoiceIndex: defaultChoiceIndex ?? this.defaultChoiceIndex);
  }

  @override
  List<Object> get props => [defaultChoiceIndex];
}
