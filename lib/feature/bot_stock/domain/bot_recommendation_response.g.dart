// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_recommendation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotRecommendationResponse _$BotRecommendationResponseFromJson(
        Map<String, dynamic> json) =>
    BotRecommendationResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  BotRecommendationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      updated: json['updated'] as String? ?? '',
    );

Map<String, dynamic> _$BotRecommendationResponseToJson(
        BotRecommendationResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'updated': instance.updated,
    };
