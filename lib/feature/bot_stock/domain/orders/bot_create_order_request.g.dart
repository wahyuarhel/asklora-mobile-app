// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotCreateOrderRequest _$BotCreateOrderRequestFromJson(
        Map<String, dynamic> json) =>
    BotCreateOrderRequest(
      ticker: json['ticker'] as String,
      botId: json['bot_id'] as String,
      investmentAmount: (json['investment_amount'] as num).toDouble(),
      fraction: json['fraction'] as bool? ?? true,
      margin: json['margin'] as int? ?? 1,
      isAggregate: json['is_aggregate'] as bool? ?? false,
    );

Map<String, dynamic> _$BotCreateOrderRequestToJson(
        BotCreateOrderRequest instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'bot_id': instance.botId,
      'investment_amount': instance.investmentAmount,
      'fraction': instance.fraction,
      'margin': instance.margin,
      'is_aggregate': instance.isAggregate,
    };
