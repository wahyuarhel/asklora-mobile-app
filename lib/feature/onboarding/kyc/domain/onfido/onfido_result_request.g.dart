// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onfido_result_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnfidoResultRequest _$OnfidoResultRequestFromJson(Map<String, dynamic> json) =>
    OnfidoResultRequest(
      json['token'] as String,
      json['reason'] as String,
      json['outcome'] as String,
    );

Map<String, dynamic> _$OnfidoResultRequestToJson(
        OnfidoResultRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
      'reason': instance.reason,
      'outcome': instance.outcome,
    };
