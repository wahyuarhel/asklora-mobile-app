// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_journey_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJourneyRequest _$UserJourneyRequestFromJson(Map<String, dynamic> json) =>
    UserJourneyRequest(
      userJourney: json['user_journey'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$UserJourneyRequestToJson(UserJourneyRequest instance) =>
    <String, dynamic>{
      'user_journey': instance.userJourney,
      'data': instance.data,
    };
