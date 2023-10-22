// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalInfoRequest _$PersonalInfoRequestFromJson(Map<String, dynamic> json) =>
    PersonalInfoRequest(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      gender: json['gender'] as String?,
      hkIdNumber: json['hkid_number'] as String?,
      nationality: json['nationality'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      countryOfBirth: json['country_of_birth'] as String?,
      phoneCountryCode: json['phone_country_code'] as String?,
      phoneNumber: json['phone_number'] as String?,
      isUnitedStateResident: json['isUnitedStateResident'] as bool?,
      isHongKongPermanentResident: json['isHongKongPermanentResident'] as bool?,
    );

Map<String, dynamic> _$PersonalInfoRequestToJson(PersonalInfoRequest instance) {
  final val = <String, dynamic>{
    'first_name': instance.firstName,
    'last_name': instance.lastName,
    'gender': instance.gender,
    'hkid_number': instance.hkIdNumber,
    'nationality': instance.nationality,
    'date_of_birth': instance.dateOfBirth,
    'country_of_birth': instance.countryOfBirth,
    'phone_country_code': instance.phoneCountryCode,
    'phone_number': instance.phoneNumber,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isUnitedStateResident', instance.isUnitedStateResident);
  writeNotNull(
      'isHongKongPermanentResident', instance.isHongKongPermanentResident);
  return val;
}
