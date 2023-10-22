// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalResponse _$WithdrawalResponseFromJson(Map<String, dynamic> json) =>
    WithdrawalResponse(
      json['amount'] as String,
      json['uid'] as String,
    );

Map<String, dynamic> _$WithdrawalResponseToJson(WithdrawalResponse instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'uid': instance.uid,
    };
