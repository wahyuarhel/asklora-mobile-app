part of 'descriptive_question_widget_bloc.dart';

abstract class DescriptiveQuestionWidgetEvent extends Equatable {
  DescriptiveQuestionWidgetEvent() : super();

  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [timeStamp];
}

class AnswerChanged extends DescriptiveQuestionWidgetEvent {
  final String answer;

  AnswerChanged(this.answer);
}
