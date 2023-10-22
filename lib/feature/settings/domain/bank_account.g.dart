// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      json['status'] as String?,
      json['country'] as String?,
      json['state_province'] as String?,
      json['postal_code'] as String?,
      json['city'] as String?,
      json['street_address'] as String?,
      json['name'] as String,
      json['bank_id'] as String?,
      json['bank_code'] as String,
      json['bank_code_type'] as String?,
      json['bank_transfer_type'] as String?,
      json['account_number'] as String,
      json['account_name'] as String,
    );

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'status': instance.status,
      'country': instance.country,
      'state_province': instance.stateProvince,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'street_address': instance.streetAddress,
      'name': instance.name,
      'bank_id': instance.bankId,
      'bank_code': instance.bankCode,
      'bank_code_type': instance.bankCodeType,
      'bank_transfer_type': instance.bankTransferType,
      'account_number': instance.accountNumber,
      'account_name': instance.accountName,
    };
