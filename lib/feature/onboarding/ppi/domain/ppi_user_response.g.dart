// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ppi_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PpiUserResponse _$PpiUserResponseFromJson(Map<String, dynamic> json) =>
    PpiUserResponse(
      email: json['email'] as String?,
      snapshot: json['snapshot'] == null
          ? null
          : SnapShot.fromJson(json['snapshot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PpiUserResponseToJson(PpiUserResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'snapshot': instance.snapshot,
    };

SnapShot _$SnapShotFromJson(Map<String, dynamic> json) => SnapShot(
      json['id'] as int,
      json['name'] as String,
      json['account_id'] as String,
      json['device_id'] as String,
      json['created'] as String,
      json['updated'] as String,
      Scores.fromJson(json['scores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SnapShotToJson(SnapShot instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account_id': instance.accountId,
      'device_id': instance.deviceId,
      'created': instance.created,
      'updated': instance.updated,
      'scores': instance.scores,
    };

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      id: json['id'] as int,
      question: json['question'] == null
          ? null
          : Question.fromJson(json['question'] as Map<String, dynamic>),
      name: json['name'] as String?,
      score: json['score'] as String?,
      answerType: json['answer_type'] as String?,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'name': instance.name,
      'score': instance.score,
      'answer_type': instance.answerType,
      'answer': instance.answer,
    };

Scores _$ScoresFromJson(Map<String, dynamic> json) => Scores(
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      conscientiousness: json['conscientiousness'] as int? ?? 0,
      extrovert: (json['extrovert'] as num?)?.toDouble() ?? 0,
      objective: (json['objective'] as num?)?.toDouble() ?? 0,
      investmentStyle: json['investment_style'] as int? ?? 0,
      maxRiskScore: (json['max_risk_score'] as num?)?.toDouble() ?? 0,
      neuroticism: json['neuroticism'] as int? ?? 0,
      openness: json['openness'] as int? ?? 0,
      privacy: json['privacy'] as int? ?? 0,
      suitability: (json['suitability'] as num?)?.toDouble() ?? 0,
      currentQuestionId: json['current_question_id'] as String? ?? '',
    );

Map<String, dynamic> _$ScoresToJson(Scores instance) => <String, dynamic>{
      'answers': instance.answers,
      'conscientiousness': instance.conscientiousness,
      'extrovert': instance.extrovert,
      'objective': instance.objective,
      'investment_style': instance.investmentStyle,
      'max_risk_score': instance.maxRiskScore,
      'neuroticism': instance.neuroticism,
      'openness': instance.openness,
      'privacy': instance.privacy,
      'suitability': instance.suitability,
      'current_question_id': instance.currentQuestionId,
    };

RecommendedBot _$RecommendedBotFromJson(Map<String, dynamic> json) =>
    RecommendedBot(
      json['bot_id'] as String,
      json['ticker'] as String,
      json['ticker_name'] as String,
      json['ticker_symbol'] as String,
      json['bot_app_type'] as String,
      json['bot_word'] as String,
      json['description'] as String,
      json['benefit'] as String,
      json['suitability'] as String,
      json['company_description'] as String,
      DateTime.parse(json['expiredDate'] as String),
      sector: json['sector'] as String? ?? 'Consumer Cyclical',
      ceo: json['ceo'] as String? ?? 'Mr. Elon R. Musk',
      employees: json['employees'] as String? ?? '99,290',
      headquarters: json['headquarters'] as String? ?? 'Austin, TX',
      funded: json['funded'] as String? ?? '2003',
      chartData: json['chartData'] as String?,
      freeBot: json['freeBot'] as bool? ?? false,
      selectable: json['selectable'] as bool? ?? false,
      value: (json['value'] as num?)?.toDouble() ?? 200,
      stopLossLevel: (json['stopLossLevel'] as num?)?.toDouble() ?? 210,
      takeProfitLevel: (json['takeProfitLevel'] as num?)?.toDouble() ?? 210,
      earliestStartTime:
          json['earliestStartTime'] as String? ?? '03/12 15:30 ET',
      optimizedStartTime:
          json['optimizedStartTime'] as String? ?? '03/12 15:30 ET',
      investmentPeriod: json['investmentPeriod'] as String? ?? '2 weeks',
      estimatedEndDate: json['estimatedEndDate'] as String? ?? '03/26',
      prevClose: json['prevClose'] as String? ?? '10/07 16:00:04 ET',
      marketCap: json['marketCap'] as String? ?? '698.98B',
      amount: (json['amount'] as num?)?.toDouble() ?? 223.07,
      profit: (json['profit'] as num?)?.toDouble() ?? -15.060,
      profitPercent: (json['profitPercent'] as num?)?.toDouble() ?? -6.32,
      minPrice: (json['minPrice'] as num?)?.toDouble() ?? 210,
      maxPrice: (json['maxPrice'] as num?)?.toDouble() ?? 240,
      currentPrice: (json['currentPrice'] as num?)?.toDouble() ?? 220,
      status: json['status'] as String? ?? 'active',
    );

Map<String, dynamic> _$RecommendedBotToJson(RecommendedBot instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'ticker_name': instance.tickerName,
      'ticker_symbol': instance.tickerSymbol,
      'bot_app_type': instance.botType,
      'bot_id': instance.botId,
      'bot_word': instance.botWord,
      'description': instance.description,
      'benefit': instance.benefit,
      'suitability': instance.suitability,
      'company_description': instance.companyDescription,
      'expiredDate': instance.expiredDate.toIso8601String(),
      'freeBot': instance.freeBot,
      'selectable': instance.selectable,
      'value': instance.value,
      'sector': instance.sector,
      'ceo': instance.ceo,
      'employees': instance.employees,
      'headquarters': instance.headquarters,
      'funded': instance.funded,
      'stopLossLevel': instance.stopLossLevel,
      'takeProfitLevel': instance.takeProfitLevel,
      'earliestStartTime': instance.earliestStartTime,
      'optimizedStartTime': instance.optimizedStartTime,
      'investmentPeriod': instance.investmentPeriod,
      'estimatedEndDate': instance.estimatedEndDate,
      'prevClose': instance.prevClose,
      'marketCap': instance.marketCap,
      'amount': instance.amount,
      'profit': instance.profit,
      'profitPercent': instance.profitPercent,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'currentPrice': instance.currentPrice,
      'chartData': instance.chartData,
      'status': instance.status,
    };
