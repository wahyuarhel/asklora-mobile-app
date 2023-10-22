part of 'descriptive_question_widget_bloc.dart';

class DescriptiveQuestionWidgetState extends Equatable {
  final String answer;

  const DescriptiveQuestionWidgetState({required this.answer}) : super();

  DescriptiveQuestionWidgetState copyWith({String? answer}) {
    return DescriptiveQuestionWidgetState(answer: answer ?? this.answer);
  }

  @override
  List<Object> get props => [answer];
}
