// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_name_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUserNameResponse _$AddUserNameResponseFromJson(Map<String, dynamic> json) =>
    AddUserNameResponse(
      json['created'] as String,
      json['updated'] as String,
      json['name'] as String,
      json['account_id'] as String,
      json['id'] as int,
    );

Map<String, dynamic> _$AddUserNameResponseToJson(
        AddUserNameResponse instance) =>
    <String, dynamic>{
      'created': instance.created,
      'updated': instance.updated,
      'name': instance.name,
      'id': instance.id,
      'account_id': instance.accountId,
    };
