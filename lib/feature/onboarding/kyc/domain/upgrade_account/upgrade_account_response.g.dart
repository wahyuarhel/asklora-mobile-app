// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpgradeAccountResponse _$UpgradeAccountResponseFromJson(
        Map<String, dynamic> json) =>
    UpgradeAccountResponse(
      residenceInfo: json['residence_info'] == null
          ? null
          : ResidenceInfoRequest.fromJson(
              json['residence_info'] as Map<String, dynamic>),
      proofsOfAddress: (json['proofs_of_address'] as List<dynamic>?)
          ?.map(
              (e) => ProofsOfAddressRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      employmentInfo: json['employment_info'] == null
          ? null
          : ProofsOfAddressRequest.fromJson(
              json['employment_info'] as Map<String, dynamic>),
      wealthSources: (json['wealth_sources'] as List<dynamic>?)
          ?.map((e) => WealthSourcesRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      affiliatedPerson: json['affiliated_person'] == null
          ? null
          : AffiliatedPerson.fromJson(
              json['affiliated_person'] as Map<String, dynamic>),
      agreements: (json['agreements'] as List<dynamic>?)
          ?.map((e) => Agreement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpgradeAccountResponseToJson(
        UpgradeAccountResponse instance) =>
    <String, dynamic>{
      'residence_info': instance.residenceInfo?.toJson(),
      'proofs_of_address':
          instance.proofsOfAddress?.map((e) => e.toJson()).toList(),
      'employment_info': instance.employmentInfo?.toJson(),
      'wealth_sources': instance.wealthSources?.map((e) => e.toJson()).toList(),
      'affiliated_person': instance.affiliatedPerson?.toJson(),
      'agreements': instance.agreements?.map((e) => e.toJson()).toList(),
    };
