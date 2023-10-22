import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/extensions.dart';

part 'bot_recommendation_model.g.dart';

@JsonSerializable()
class BotRecommendationModel extends Equatable {
  final int id;
  @JsonKey(name: 'bot_id')
  final String botId;
  @JsonKey(name: 'bot_word')
  final String? botWord;

  final String? updated;

  final String? created;

  @JsonKey(name: 'bot_duration')
  final String botDuration;

  @JsonKey(name: 'bot_type')
  final String botType;
  @JsonKey(name: 'bot_app_type')
  final String botAppType;
  final String ticker;
  @JsonKey(name: 'ticker_name')
  final String tickerName;
  @JsonKey(name: 'ticker_symbol')
  final String tickerSymbol;
  @JsonKey(name: 'latest_price')
  final String latestPrice;
  final bool freeBot;
  final bool selectable;

  const BotRecommendationModel(
      this.id,
      this.botId,
      this.botWord,
      this.botType,
      this.botAppType,
      this.ticker,
      this.tickerName,
      this.tickerSymbol,
      this.latestPrice,
      this.updated,
      this.created,
      this.botDuration,
      {this.freeBot = false,
      this.selectable = false});

  String get botWordString => botWord ?? '';

  String get latestPriceFormatted =>
      checkDouble(latestPrice).convertToCurrencyDecimal();

  BotRecommendationModel copyWith({bool? freeBot}) => BotRecommendationModel(
      id,
      botId,
      botWord,
      botType,
      botAppType,
      ticker,
      tickerName,
      tickerSymbol,
      latestPrice,
      created,
      updated,
      botDuration,
      freeBot: freeBot ?? this.freeBot);

  factory BotRecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$BotRecommendationModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotRecommendationModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        botId,
        botWord,
        botType,
        botAppType,
        ticker,
        tickerName,
        tickerSymbol,
        latestPrice,
        created,
        updated,
        botDuration,
      ];
}
