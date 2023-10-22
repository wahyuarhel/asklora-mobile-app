// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOtpRequest _$GetOtpRequestFromJson(Map<String, dynamic> json) =>
    GetOtpRequest(
      json['email'] as String,
      json['otp_type'] as String,
    );

Map<String, dynamic> _$GetOtpRequestToJson(GetOtpRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp_type': instance.otpType,
    };
