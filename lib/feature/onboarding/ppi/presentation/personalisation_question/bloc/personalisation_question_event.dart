part of 'personalisation_question_bloc.dart';

abstract class PersonalisationQuestionEvent extends Equatable {
  PersonalisationQuestionEvent() : super();
  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [timeStamp];
}

class NextPersonalisationQuestion extends PersonalisationQuestionEvent {}

class PreviousPersonalisationQuestion extends PersonalisationQuestionEvent {}
