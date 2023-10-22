// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_with_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInWithOtpRequest _$SignInWithOtpRequestFromJson(
        Map<String, dynamic> json) =>
    SignInWithOtpRequest(
      json['otp'] as String,
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$SignInWithOtpRequestToJson(
        SignInWithOtpRequest instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'email': instance.email,
      'password': instance.password,
    };
