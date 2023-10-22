// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asklora_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AskloraError _$AskloraErrorFromJson(Map<String, dynamic> json) => AskloraError(
      detail: json['detail'] as String? ?? '',
      code: json['code'] as String? ?? 'UNKNOWN',
    );

Map<String, dynamic> _$AskloraErrorToJson(AskloraError instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'code': instance.code,
    };
