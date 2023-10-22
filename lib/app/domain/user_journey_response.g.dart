// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_journey_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJourneyResponse _$UserJourneyResponseFromJson(Map<String, dynamic> json) =>
    UserJourneyResponse(
      json['uid'] as String?,
      json['updated'] as String?,
      json['user_journey'] as String?,
      json['data'] as String?,
      json['user'] as int?,
      json['detail'] as String?,
    );

Map<String, dynamic> _$UserJourneyResponseToJson(
        UserJourneyResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'updated': instance.updated,
      'user_journey': instance.userJourney,
      'data': instance.data,
      'user': instance.user,
      'detail': instance.detail,
    };
