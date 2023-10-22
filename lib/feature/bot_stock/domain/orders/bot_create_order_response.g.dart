// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_create_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotCreateOrderResponse _$BotCreateOrderResponseFromJson(
        Map<String, dynamic> json) =>
    BotCreateOrderResponse(
      json['uid'] as String,
      json['name'] as String,
      json['bot_apps_name'] as String,
      json['status'] as String,
      json['is_active'] as bool,
      json['ticker_name'] as String,
      json['is_dummy'] as bool,
      json['spot_date'] as String,
      json['symbol'] as String,
      json['optimal_time'] as String,
    );

Map<String, dynamic> _$BotCreateOrderResponseToJson(
        BotCreateOrderResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'bot_apps_name': instance.botAppsName,
      'status': instance.status,
      'is_active': instance.isActive,
      'symbol': instance.symbol,
      'ticker_name': instance.tickerName,
      'is_dummy': instance.isDummy,
      'spot_date': instance.spotDate,
      'optimal_time': instance.optimalTime,
    };
