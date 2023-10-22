// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_activities_transaction_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotActivitiesTransactionHistoryModel
    _$BotActivitiesTransactionHistoryModelFromJson(Map<String, dynamic> json) =>
        BotActivitiesTransactionHistoryModel(
          json['uid'] as String,
          json['created'] as String,
          json['side'] as String,
          json['action'] as String,
          json['status'] as String,
          (json['price'] as num).toDouble(),
          (json['qty'] as num).toDouble(),
          (json['invested'] as num).toDouble(),
          (json['invested_usd'] as num).toDouble(),
          (json['filled_qty'] as num).toDouble(),
          (json['filled_avg_price'] as num?)?.toDouble(),
          json['filled_at'] as String,
          json['filled_at_hkt'] as String?,
          json['expire_at'] as String?,
          json['canceled_at'] as String?,
          json['failed_at'] as String?,
        );

Map<String, dynamic> _$BotActivitiesTransactionHistoryModelToJson(
        BotActivitiesTransactionHistoryModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'created': instance.created,
      'side': instance.side,
      'action': instance.action,
      'status': instance.status,
      'price': instance.price,
      'qty': instance.qty,
      'invested_usd': instance.investedUsd,
      'invested': instance.invested,
      'filled_qty': instance.filledQty,
      'filled_avg_price': instance.filledAvgPrice,
      'filled_at': instance.filledAt,
      'filled_at_hkt': instance.filledAtHkt,
      'expire_at': instance.expiredAt,
      'canceled_at': instance.canceledAt,
      'failed_at': instance.failedAt,
    };
