part of 'for_you_question_bloc.dart';

abstract class ForYouQuestionEvent extends Equatable {
  ForYouQuestionEvent() : super();

  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [timeStamp];
}

class LoadQuestion extends ForYouQuestionEvent {}
