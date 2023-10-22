part of 'privacy_question_bloc.dart';

abstract class PrivacyQuestionEvent extends Equatable {
  PrivacyQuestionEvent() : super();

  final int timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [timeStamp];
}

class NextQuestion extends PrivacyQuestionEvent {}

class PreviousQuestion extends PrivacyQuestionEvent {}
