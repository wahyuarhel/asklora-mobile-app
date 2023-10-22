// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountResponse _$GetAccountResponseFromJson(Map<String, dynamic> json) =>
    GetAccountResponse(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      dateJoined: json['date_joined'] as String?,
      canTrade: json['can_trade'] as bool,
      bankAccount: json['bank_account'] == null
          ? null
          : BankAccount.fromJson(json['bank_account'] as Map<String, dynamic>),
      personalInfo: json['personal_info'] == null
          ? null
          : PersonalInfoRequest.fromJson(
              json['personal_info'] as Map<String, dynamic>),
      residenceInfo: json['residence_info'] == null
          ? null
          : ResidenceInfoRequest.fromJson(
              json['residence_info'] as Map<String, dynamic>),
      employmentInfo: json['employment_info'] == null
          ? null
          : EmploymentInfo.fromJson(
              json['employment_info'] as Map<String, dynamic>),
      agreements: (json['agreements'] as List<dynamic>?)
          ?.map((e) => Agreement.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastJourney: json['last_journey'] == null
          ? null
          : LastJourney.fromJson(json['last_journey'] as Map<String, dynamic>),
      isStaff: json['is_staff'] as bool,
    );

Map<String, dynamic> _$GetAccountResponseToJson(GetAccountResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'can_trade': instance.canTrade,
      'date_joined': instance.dateJoined,
      'bank_account': instance.bankAccount?.toJson(),
      'personal_info': instance.personalInfo?.toJson(),
      'residence_info': instance.residenceInfo?.toJson(),
      'employment_info': instance.employmentInfo?.toJson(),
      'agreements': instance.agreements?.map((e) => e.toJson()).toList(),
      'last_journey': instance.lastJourney?.toJson(),
      'is_staff': instance.isStaff,
    };

LastJourney _$LastJourneyFromJson(Map<String, dynamic> json) => LastJourney(
      userJourney: json['user_journey'] as String,
      signature: json['data'] as String?,
    );

Map<String, dynamic> _$LastJourneyToJson(LastJourney instance) =>
    <String, dynamic>{
      'user_journey': instance.userJourney,
      'data': instance.signature,
    };
