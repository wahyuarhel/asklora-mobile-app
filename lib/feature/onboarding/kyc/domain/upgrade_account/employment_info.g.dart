// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmploymentInfo _$EmploymentInfoFromJson(Map<String, dynamic> json) =>
    EmploymentInfo(
      employmentStatus: json['employment_status'] as String?,
      employer: json['employer'] as String?,
      employerBusiness: json['employer_business'] as String?,
      employerBusinessDescription:
          json['employer_business_description'] as String?,
      occupation: json['occupation'] as String?,
      employerAddressLine1: json['employer_address_line_1'] as String?,
      employerAddressLine2: json['employer_address_line_2'] as String?,
      district: json['district'] as String?,
      region: json['region'] as String?,
      country: json['country'] as String?,
      differentCountryReason: json['different_country_reason'] as String?,
    );

Map<String, dynamic> _$EmploymentInfoToJson(EmploymentInfo instance) {
  final val = <String, dynamic>{
    'employment_status': instance.employmentStatus,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('employer', instance.employer);
  writeNotNull('employer_business', instance.employerBusiness);
  writeNotNull(
      'employer_business_description', instance.employerBusinessDescription);
  writeNotNull('occupation', instance.occupation);
  writeNotNull('employer_address_line_1', instance.employerAddressLine1);
  writeNotNull('employer_address_line_2', instance.employerAddressLine2);
  writeNotNull('district', instance.district);
  writeNotNull('region', instance.region);
  writeNotNull('country', instance.country);
  val['different_country_reason'] = instance.differentCountryReason;
  return val;
}
