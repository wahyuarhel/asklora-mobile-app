// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUserRequest _$AddUserRequestFromJson(Map<String, dynamic> json) =>
    AddUserRequest(
      name: json['name'] as String,
      accountId: json['account_id'] as String?,
      deviceId: json['device_id'] as String,
    );

Map<String, dynamic> _$AddUserRequestToJson(AddUserRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'account_id': instance.accountId,
      'device_id': instance.deviceId,
    };
