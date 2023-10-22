// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_active_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotActiveOrderModel _$BotActiveOrderModelFromJson(Map<String, dynamic> json) =>
    BotActiveOrderModel(
      json['uid'] as String,
      json['status'] as String,
      json['is_active'] as bool,
      (json['total_pnl_pct'] as num).toDouble(),
      json['expire_date'] as String?,
      json['ticker_name'] as String,
      (json['current_price'] as num).toDouble(),
      json['is_dummy'] as bool,
      json['spot_date'] as String,
      json['symbol'] as String,
      json['bot_apps_name'] as String,
      json['bot_duration'] as String,
      json['ticker'] as String,
      json['optimal_time'] as String,
      (json['bot_stock_value'] as num).toDouble(),
    );

Map<String, dynamic> _$BotActiveOrderModelToJson(
        BotActiveOrderModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'status': instance.status,
      'is_active': instance.isActive,
      'total_pnl_pct': instance.totalPnLPct,
      'expire_date': instance.expireDate,
      'ticker_name': instance.tickerName,
      'current_price': instance.currentPrice,
      'is_dummy': instance.isDummy,
      'spot_date': instance.spotDate,
      'symbol': instance.symbol,
      'bot_apps_name': instance.botAppsName,
      'bot_duration': instance.botDuration,
      'optimal_time': instance.optimalTime,
      'ticker': instance.ticker,
      'bot_stock_value': instance.botStockValue,
    };
