// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotBalance _$BotBalanceFromJson(Map<String, dynamic> json) => BotBalance(
      (json['fully_settled_balance_hkd'] as num).toDouble(),
      (json['fully_settled_balance_usd'] as num).toDouble(),
      json['name'] as String,
    );

Map<String, dynamic> _$BotBalanceToJson(BotBalance instance) =>
    <String, dynamic>{
      'fully_settled_balance_hkd': instance.fullySettledBalanceHkd,
      'fully_settled_balance_usd': instance.fullySettledBalanceUsd,
      'name': instance.name,
    };
