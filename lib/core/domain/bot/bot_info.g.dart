// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotInfo _$BotInfoFromJson(Map<String, dynamic> json) => BotInfo(
      json['bot_type'] as String,
      json['bot_name'] as String,
      BotDescriptionModel.fromJson(
          json['bot_description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BotInfoToJson(BotInfo instance) => <String, dynamic>{
      'bot_type': instance.botType,
      'bot_name': instance.botName,
      'bot_description': instance.botDescription,
    };
