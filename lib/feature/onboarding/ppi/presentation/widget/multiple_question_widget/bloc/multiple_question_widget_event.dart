part of 'multiple_question_widget_bloc.dart';

abstract class MultipleQuestionWidgetEvent extends Equatable {
  MultipleQuestionWidgetEvent() : super();

  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [timeStamp];
}

class AnswerChanged extends MultipleQuestionWidgetEvent {
  final int defaultChoiceIndex;

  AnswerChanged(this.defaultChoiceIndex);
}
