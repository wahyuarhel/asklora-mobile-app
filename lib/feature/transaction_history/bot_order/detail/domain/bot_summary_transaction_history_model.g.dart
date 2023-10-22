// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_summary_transaction_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotSummaryTransactionHistoryModel _$BotSummaryTransactionHistoryModelFromJson(
        Map<String, dynamic> json) =>
    BotSummaryTransactionHistoryModel(
      json['uid'] as String,
      json['type'] as String,
      json['date'] as String,
      json['status'] as String,
      (json['amount'] as num).toDouble(),
      (json['fee'] as num).toDouble(),
      (json['total_pnl'] as num).toDouble(),
    );

Map<String, dynamic> _$BotSummaryTransactionHistoryModelToJson(
        BotSummaryTransactionHistoryModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'type': instance.type,
      'date': instance.date,
      'amount': instance.amount,
      'fee': instance.fee,
      'status': instance.status,
      'total_pnl': instance.totalPnL,
    };
