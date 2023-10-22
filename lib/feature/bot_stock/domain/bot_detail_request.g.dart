// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotDetailRequest _$BotDetailRequestFromJson(Map<String, dynamic> json) =>
    BotDetailRequest(
      json['ticker'] as String,
      json['bot_id'] as String,
    );

Map<String, dynamic> _$BotDetailRequestToJson(BotDetailRequest instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'bot_id': instance.botId,
    };
