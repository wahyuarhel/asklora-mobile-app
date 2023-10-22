// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      json['detail'] as String,
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
    };

GetOtpResponse _$GetOtpResponseFromJson(Map<String, dynamic> json) =>
    GetOtpResponse(
      json['detail'] as String,
      json['phone_number'] as String?,
    );

Map<String, dynamic> _$GetOtpResponseToJson(GetOtpResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'phone_number': instance.phoneNumber,
    };
