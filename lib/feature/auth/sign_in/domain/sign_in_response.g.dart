// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
      userJourney:
          $enumDecodeNullable(_$UserJourneyEnumMap, json['userJourney']),
      detail: json['detail'] as String?,
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
      'userJourney': _$UserJourneyEnumMap[instance.userJourney],
      'detail': instance.detail,
      'statusCode': instance.statusCode,
    };

const _$UserJourneyEnumMap = {
  UserJourney.privacy: 'privacy',
  UserJourney.investmentStyle: 'investmentStyle',
  UserJourney.kyc: 'kyc',
  UserJourney.freeBotStock: 'freeBotStock',
  UserJourney.deposit: 'deposit',
  UserJourney.learnBotPlank: 'learnBotPlank',
};
