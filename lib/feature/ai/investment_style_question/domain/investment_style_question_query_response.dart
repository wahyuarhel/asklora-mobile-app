import 'package:json_annotation/json_annotation.dart';

import '../../../../core/domain/ai/component.dart';

part 'investment_style_question_query_response.g.dart';

class InvestmentStyleQuestionQueryResponse {
  final InvestmentStyleQuestionProgress investmentStyleQuestionProgress;
  final String sessionId;
  final bool success;
  final String detail;
  final String response;
  final Map<String, String> choices;

  final List<Component> components;

  const InvestmentStyleQuestionQueryResponse(
      this.investmentStyleQuestionProgress,
      this.sessionId,
      this.success,
      this.detail,
      this.response,
      this.choices,
      {this.components = const []});

  factory InvestmentStyleQuestionQueryResponse.fromJson(
          Map<String, dynamic> json) =>
      InvestmentStyleQuestionQueryResponse(
          InvestmentStyleQuestionProgress.fromJson(
              json['progress'] as Map<String, dynamic>),
          json['session_id'] as String,
          json['success'] as bool,
          json['detail'] as String,
          json['response'] as String,
          Map<String, String>.from(json['choices'] as Map),
          components: (json['components'] as List<dynamic>?)?.map((e) {
                if (e['id'] == ComponentType.promptButton.value) {
                  return PromptButton(e['id'], e['label']);
                } else {
                  return NavigationButton(
                      e['id'], e['label'], e['route'] ?? '');
                }
              }).toList() ??
              const []);

  Map<String, dynamic> toJson(InvestmentStyleQuestionQueryResponse instance) =>
      <String, dynamic>{
        'progress': instance.investmentStyleQuestionProgress,
        'session_id': instance.sessionId,
        'success': instance.success,
        'detail': instance.detail,
        'response': instance.response,
        'choices': instance.choices,
      };

  List<Object?> get props => [
        investmentStyleQuestionProgress,
        sessionId,
        success,
        detail,
        response,
        choices
      ];
}

@JsonSerializable()
class InvestmentStyleQuestionProgress {
  @JsonKey(name: 'current_q')
  final int currentQuestion;
  @JsonKey(name: 'isq_results')
  final InvestmentStyleQuestionResult investmentStyleQuestionResult;
  final int interaction;
  final bool progressed;

  const InvestmentStyleQuestionProgress(this.currentQuestion,
      this.investmentStyleQuestionResult, this.interaction, this.progressed);

  factory InvestmentStyleQuestionProgress.fromJson(Map<String, dynamic> json) =>
      _$InvestmentStyleQuestionProgressFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InvestmentStyleQuestionProgressToJson(this);

  List<Object?> get props =>
      [currentQuestion, investmentStyleQuestionResult, interaction, progressed];
}

@JsonSerializable()
class InvestmentStyleQuestionResult {
  final List<String> keywords;
  @JsonKey(name: 'risk_preference')
  final int? riskPreference;
  @JsonKey(name: 'investment_horizon')
  final String? investmentHorizon;
  @JsonKey(name: 'preferred_method')
  final int? preferredMethod;
  @JsonKey(name: 'last_q')
  final int lastQuestion;
  @JsonKey(name: 'q2_ids')
  final List<int> questionTwoIds;
  @JsonKey(name: 'q3_ids')
  final List<int> questionThreeIds;
  @JsonKey(name: 'opener_search_query')
  final String openerSearchQuery;

  const InvestmentStyleQuestionResult(
    this.keywords,
    this.riskPreference,
    this.investmentHorizon,
    this.preferredMethod,
    this.lastQuestion,
    this.questionTwoIds,
    this.questionThreeIds,
    this.openerSearchQuery,
  );

  factory InvestmentStyleQuestionResult.fromJson(Map<String, dynamic> json) =>
      _$InvestmentStyleQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$InvestmentStyleQuestionResultToJson(this);

  List<Object?> get props => [
        keywords,
        riskPreference,
        investmentHorizon,
        preferredMethod,
        lastQuestion,
        questionTwoIds,
        questionThreeIds,
        openerSearchQuery,
      ];
}
