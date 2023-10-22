part of 'for_you_question_bloc.dart';

enum InvestmentStyleQuestionType { omnisearch, others }

class ForYouQuestionState extends Equatable {
  final BaseResponse<Pair<Question?, List<Question>>> response;

  const ForYouQuestionState({this.response = const BaseResponse()}) : super();

  ForYouQuestionState copyWith({
    BaseResponse<Pair<Question?, List<Question>>>? response,
  }) {
    return ForYouQuestionState(
      response: response ?? this.response,
    );
  }

  @override
  List<Object> get props => [response];
}
