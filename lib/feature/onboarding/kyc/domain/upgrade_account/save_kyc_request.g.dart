// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_kyc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveKycRequest _$SaveKycRequestFromJson(Map<String, dynamic> json) =>
    SaveKycRequest(
      upgradeAccountRequest: UpgradeAccountRequest.fromJson(
          json['upgrade_account_request'] as Map<String, dynamic>),
      personalInfoRequest: PersonalInfoRequest.fromJson(
          json['proofs_of_address'] as Map<String, dynamic>),
      immediateFamilyAffiliation: json['immediateFamilyAffiliation'] as bool?,
      associatesAffiliation: json['associatesAffiliation'] as bool?,
      isBoundByAskloraAgreementChecked:
          json['isBoundByAskloraAgreementChecked'] as bool?,
      isUnderstandOnTheAgreementChecked:
          json['isUnderstandOnTheAgreementChecked'] as bool?,
      isRiskDisclosureAgreementChecked:
          json['isRiskDisclosureAgreementChecked'] as bool?,
      isSignatureChecked: json['isSignatureChecked'] as bool?,
      legalNameSignature: json['legalNameSignature'] as String?,
    );

Map<String, dynamic> _$SaveKycRequestToJson(SaveKycRequest instance) =>
    <String, dynamic>{
      'upgrade_account_request': instance.upgradeAccountRequest.toJson(),
      'immediateFamilyAffiliation': instance.immediateFamilyAffiliation,
      'associatesAffiliation': instance.associatesAffiliation,
      'proofs_of_address': instance.personalInfoRequest.toJson(),
      'isBoundByAskloraAgreementChecked':
          instance.isBoundByAskloraAgreementChecked,
      'isUnderstandOnTheAgreementChecked':
          instance.isUnderstandOnTheAgreementChecked,
      'isRiskDisclosureAgreementChecked':
          instance.isRiskDisclosureAgreementChecked,
      'isSignatureChecked': instance.isSignatureChecked,
      'legalNameSignature': instance.legalNameSignature,
    };
