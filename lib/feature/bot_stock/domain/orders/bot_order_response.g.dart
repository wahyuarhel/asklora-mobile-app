// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotOrderResponse _$BotOrderResponseFromJson(Map<String, dynamic> json) =>
    BotOrderResponse(
      json['detail'] as String,
    );

Map<String, dynamic> _$BotOrderResponseToJson(BotOrderResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
    };

TerminateOrderResponse _$TerminateOrderResponseFromJson(
        Map<String, dynamic> json) =>
    TerminateOrderResponse(
      json['detail'] as String,
      json['optimal_time'] as String,
    );

Map<String, dynamic> _$TerminateOrderResponseToJson(
        TerminateOrderResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'optimal_time': instance.optimalTime,
    };

RolloverOrderResponse _$RolloverOrderResponseFromJson(
        Map<String, dynamic> json) =>
    RolloverOrderResponse(
      json['detail'] as String,
      json['new_expire_date'] as String,
    );

Map<String, dynamic> _$RolloverOrderResponseToJson(
        RolloverOrderResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'new_expire_date': instance.newExpireDate,
    };
