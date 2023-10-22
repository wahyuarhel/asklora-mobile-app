part of 'question_bloc.dart';

class QuestionState extends Equatable {
  const QuestionState({
    this.response = const BaseResponse(),
    this.privacyQuestionIndex = 0,
    this.personalisationQuestionIndex = 0,
    this.totalPrivacyPages = 0,
    this.totalPersonalisationPages = 0,
    this.currentPrivacyPages = 0,
    this.currentPersonalisationPages = 0,
  }) : super();

  final BaseResponse response;
  final int privacyQuestionIndex;
  final int personalisationQuestionIndex;
  final int totalPrivacyPages;
  final int totalPersonalisationPages;
  final int currentPrivacyPages;
  final int currentPersonalisationPages;

  QuestionState copyWith({
    BaseResponse? response,
    int? privacyQuestionIndex,
    int? personalisationQuestionIndex,
    int? totalPrivacyPages,
    int? totalPersonalisationPages,
    int? currentPrivacyPages,
    int? currentPersonalisationPages,
  }) {
    return QuestionState(
      response: response ?? this.response,
      privacyQuestionIndex: privacyQuestionIndex ?? this.privacyQuestionIndex,
      personalisationQuestionIndex:
          personalisationQuestionIndex ?? this.personalisationQuestionIndex,
      totalPrivacyPages: totalPrivacyPages ?? this.totalPrivacyPages,
      totalPersonalisationPages:
          totalPersonalisationPages ?? this.totalPersonalisationPages,
      currentPrivacyPages: currentPrivacyPages ?? this.currentPrivacyPages,
      currentPersonalisationPages:
          currentPersonalisationPages ?? this.currentPersonalisationPages,
    );
  }

  @override
  List<Object> get props => [
        privacyQuestionIndex,
        personalisationQuestionIndex,
        response,
        currentPrivacyPages,
        currentPersonalisationPages,
        totalPrivacyPages,
        totalPersonalisationPages,
      ];
}
