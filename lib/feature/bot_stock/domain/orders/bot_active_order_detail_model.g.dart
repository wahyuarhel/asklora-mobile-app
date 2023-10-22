// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_active_order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotActiveOrderDetailModel _$BotActiveOrderDetailModelFromJson(
        Map<String, dynamic> json) =>
    BotActiveOrderDetailModel(
      json['uid'] as String,
      json['name'] as String,
      BotInfo.fromJson(json['bot_info'] as Map<String, dynamic>),
      (json['investment_amount'] as num).toDouble(),
      (json['final_return'] as num?)?.toDouble(),
      json['bot_duration'] as String,
      json['spot_date'] as String,
      json['expire_date'] as String?,
      (json['est_max_loss'] as num).toDouble(),
      (json['est_max_profit'] as num).toDouble(),
      json['status'] as String,
      json['rollover_count'] as int,
      (json['bot_stock_value'] as num).toDouble(),
      (json['total_pnl_pct'] as num).toDouble(),
      json['days_to_expire'] as int,
      (json['avg_return_pct'] as num).toDouble(),
      (json['avg_loss_pct'] as num).toDouble(),
      json['start_date'] as String,
      (json['avg_period'] as num).toDouble(),
      json['stock_info'] == null
          ? null
          : StockInfo.fromJson(json['stock_info'] as Map<String, dynamic>),
      (json['current_price'] as num?)?.toDouble(),
      json['bot_asset_in_stock_pct'] as int,
      (json['bot_cash_balance'] as num).toDouble(),
      (json['bot_share'] as num).toDouble(),
      (json['max_loss_pct'] as num).toDouble(),
      (json['target_profit_pct'] as num).toDouble(),
      (json['stock_values'] as num).toDouble(),
      json['termination_requested'] as bool,
      json['est_end_date'] as String?,
    );

Map<String, dynamic> _$BotActiveOrderDetailModelToJson(
        BotActiveOrderDetailModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'bot_info': instance.botInfo,
      'investment_amount': instance.investmentAmount,
      'final_return': instance.finalReturn,
      'bot_duration': instance.botDuration,
      'spot_date': instance.spotDate,
      'expire_date': instance.expireDate,
      'est_max_loss': instance.estMaxLoss,
      'est_max_profit': instance.estMaxProfit,
      'status': instance.status,
      'rollover_count': instance.rolloverCount,
      'bot_stock_value': instance.botStockValue,
      'total_pnl_pct': instance.totalPnLPct,
      'days_to_expire': instance.daysToExpire,
      'avg_return_pct': instance.avgReturnPct,
      'avg_loss_pct': instance.avgLossPct,
      'start_date': instance.startDate,
      'avg_period': instance.avgPeriod,
      'stock_info': instance.stockInfo,
      'current_price': instance.currentPrice,
      'bot_asset_in_stock_pct': instance.botAssetInStockPct,
      'bot_cash_balance': instance.botCashBalance,
      'bot_share': instance.botShare,
      'max_loss_pct': instance.maxLossPct,
      'target_profit_pct': instance.targetProfitPct,
      'stock_values': instance.stockValues,
      'termination_requested': instance.terminationRequested,
      'est_end_date': instance.estEndDate,
    };
