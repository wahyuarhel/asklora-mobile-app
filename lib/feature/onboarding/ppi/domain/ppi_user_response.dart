import 'question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ppi_user_response.g.dart';

@JsonSerializable()
class PpiUserResponse {
  final String? email;
  final SnapShot? snapshot;

  factory PpiUserResponse.fromJson(Map<String, dynamic> json) =>
      _$PpiUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PpiUserResponseToJson(this);

  const PpiUserResponse({this.email, this.snapshot});
}

@JsonSerializable()
class SnapShot {
  final int id;

  final String name;

  @JsonKey(name: 'account_id')
  final String accountId;

  @JsonKey(name: 'device_id')
  final String deviceId;

  final String created;

  final String updated;

  final Scores scores;

  SnapShot(this.id, this.name, this.accountId, this.deviceId, this.created,
      this.updated, this.scores);

  factory SnapShot.fromJson(Map<String, dynamic> json) =>
      _$SnapShotFromJson(json);

  Map<String, dynamic> toJson() => _$SnapShotToJson(this);

  @override
  String toString() {
    return 'SnapShot{id: $id, name: $name, accountId: $accountId, deviceId: $deviceId, created: $created, updated: $updated, scores: $scores}';
  }
}

@JsonSerializable()
class Answer {
  final int id;
  @JsonKey(name: 'question')
  final Question? question;
  final String? name;
  final String? score;
  @JsonKey(name: 'answer_type')
  final String? answerType;
  final String? answer;

  Answer(
      {required this.id,
      this.question,
      this.name,
      this.score,
      this.answerType,
      this.answer});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  String toString() {
    return 'Answer{id: $id, question_id: ${question?.questionId}, name: $name, score: $score, answerType: $answerType, answer: $answer}';
  }
}

@JsonSerializable()
class Scores {
  final List<Answer> answers;
  final int conscientiousness;
  final double extrovert;
  final double objective;
  @JsonKey(name: 'investment_style')
  final int investmentStyle;
  @JsonKey(name: 'max_risk_score')
  final double maxRiskScore;
  final int neuroticism;
  final int openness;
  final int privacy;
  final double suitability;
  @JsonKey(name: 'current_question_id')
  final String currentQuestionId;

  Scores(
      {this.answers = const [],
      this.conscientiousness = 0,
      this.extrovert = 0,
      this.objective = 0,
      this.investmentStyle = 0,
      this.maxRiskScore = 0,
      this.neuroticism = 0,
      this.openness = 0,
      this.privacy = 0,
      this.suitability = 0,
      this.currentQuestionId = ''});

  factory Scores.fromJson(Map<String, dynamic> json) => _$ScoresFromJson(json);

  Map<String, dynamic> toJson() => _$ScoresToJson(this);
}

@JsonSerializable()
class RecommendedBot {
  final String ticker;

  @JsonKey(name: 'ticker_name')
  final String tickerName;

  @JsonKey(name: 'ticker_symbol')
  final String tickerSymbol;

  @JsonKey(name: 'bot_app_type')
  final String botType;

  @JsonKey(name: 'bot_id')
  final String botId;

  @JsonKey(name: 'bot_word')
  final String botWord;

  final String description;
  final String benefit;
  final String suitability;

  @JsonKey(name: 'company_description')
  final String companyDescription;

  final DateTime expiredDate;

  final bool freeBot;

  final bool selectable;

  final double value;

  ///adding variables to accomodate detail bot stock
  final String sector;
  final String ceo;
  final String employees;
  final String headquarters;
  final String funded;

  final double stopLossLevel;
  final double takeProfitLevel;
  final String earliestStartTime;
  final String optimizedStartTime;
  final String investmentPeriod;
  final String estimatedEndDate;
  final String prevClose;
  final String marketCap;
  final double amount;
  final double profit;
  final double profitPercent;
  final double minPrice;
  final double maxPrice;
  final double currentPrice;
  final String? chartData;
  final String? status;

  RecommendedBot(
    this.botId,
    this.ticker,
    this.tickerName,
    this.tickerSymbol,
    this.botType,
    this.botWord,
    this.description,
    this.benefit,
    this.suitability,
    this.companyDescription,
    this.expiredDate, {
    this.sector = 'Consumer Cyclical',
    this.ceo = 'Mr. Elon R. Musk',
    this.employees = '99,290',
    this.headquarters = 'Austin, TX',
    this.funded = '2003',
    this.chartData,
    this.freeBot = false,
    this.selectable = false,
    this.value = 200,
    this.stopLossLevel = 210,
    this.takeProfitLevel = 210,
    this.earliestStartTime = '03/12 15:30 ET',
    this.optimizedStartTime = '03/12 15:30 ET',
    this.investmentPeriod = '2 weeks',
    this.estimatedEndDate = '03/26',
    this.prevClose = '10/07 16:00:04 ET',
    this.marketCap = '698.98B',
    this.amount = 223.07,
    this.profit = -15.060,
    this.profitPercent = -6.32,
    this.minPrice = 210,
    this.maxPrice = 240,
    this.currentPrice = 220,
    this.status = 'active',
  });

  factory RecommendedBot.fromJson(Map<String, dynamic> json) =>
      _$RecommendedBotFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedBotToJson(this);
}
