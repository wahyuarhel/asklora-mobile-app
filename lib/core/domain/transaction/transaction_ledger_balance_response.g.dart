// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_ledger_balance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionLedgerBalanceResponse _$TransactionLedgerBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionLedgerBalanceResponse(
      (json['fully_settled_balance_hkd'] as num).toDouble(),
      (json['fully_settled_balance_usd'] as num).toDouble(),
      (json['buying_power'] as num).toDouble(),
      (json['withdrawable_balance'] as num).toDouble(),
      json['account_name'] as String,
      (json['user_id'] as num).toDouble(),
    );

Map<String, dynamic> _$TransactionLedgerBalanceResponseToJson(
        TransactionLedgerBalanceResponse instance) =>
    <String, dynamic>{
      'fully_settled_balance_hkd': instance.fullySettledBalanceHkd,
      'fully_settled_balance_usd': instance.fullySettledBalanceUsd,
      'buying_power': instance.buyingPower,
      'withdrawable_balance': instance.withdrawableBalance,
      'account_name': instance.accountName,
      'user_id': instance.userId,
    };
