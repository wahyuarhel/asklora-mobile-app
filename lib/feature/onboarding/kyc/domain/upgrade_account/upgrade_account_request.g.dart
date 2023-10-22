// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpgradeAccountRequest _$UpgradeAccountRequestFromJson(
        Map<String, dynamic> json) =>
    UpgradeAccountRequest(
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
          : EmploymentInfo.fromJson(
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
              .toList() ??
          const [
            Agreement(agreement: 'ACA'),
            Agreement(agreement: 'RDS'),
            Agreement(agreement: 'W8BEN')
          ],
    );

Map<String, dynamic> _$UpgradeAccountRequestToJson(
    UpgradeAccountRequest instance) {
  final val = <String, dynamic>{
    'residence_info': instance.residenceInfo?.toJson(),
    'proofs_of_address':
        instance.proofsOfAddress?.map((e) => e.toJson()).toList(),
    'employment_info': instance.employmentInfo?.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('wealth_sources',
      instance.wealthSources?.map((e) => e.toJson()).toList());
  writeNotNull('affiliated_person', instance.affiliatedPerson?.toJson());
  val['agreements'] = instance.agreements?.map((e) => e.toJson()).toList();
  return val;
}
