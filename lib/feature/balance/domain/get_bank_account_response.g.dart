// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bank_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBankAccountResponse _$GetBankAccountResponseFromJson(
        Map<String, dynamic> json) =>
    GetBankAccountResponse(
      json['state_province'] as String?,
      json['bank_type'] as String?,
      json['uid'] as String?,
      json['bank_code'] as String?,
      json['account_name'] as String?,
      json['account_number'] as String?,
      json['bank_transfer_type'] as String?,
      json['country'] as String?,
      json['name'] as String?,
      json['postal_code'] as String?,
      json['city'] as String?,
      json['street_address'] as String?,
    );

Map<String, dynamic> _$GetBankAccountResponseToJson(
        GetBankAccountResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'country': instance.country,
      'state_province': instance.stateProvince,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'street_address': instance.streetAddress,
      'name': instance.name,
      'bank_code': instance.bankCode,
      'bank_type': instance.bankType,
      'bank_transfer_type': instance.bankTransferType,
      'account_name': instance.accountName,
      'account_number': instance.accountNumber,
    };
