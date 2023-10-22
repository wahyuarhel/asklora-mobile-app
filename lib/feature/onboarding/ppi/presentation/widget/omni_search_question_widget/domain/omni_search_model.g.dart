// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omni_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmniSearchModel _$OmniSearchModelFromJson(Map<String, dynamic> json) =>
    OmniSearchModel(
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      keywordAnswers: (json['keywordAnswers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OmniSearchModelToJson(OmniSearchModel instance) =>
    <String, dynamic>{
      'keywords': instance.keywords,
      'keywordAnswers': instance.keywordAnswers,
    };
