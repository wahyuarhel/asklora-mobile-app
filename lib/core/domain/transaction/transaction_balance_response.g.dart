// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_balance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionBalanceResponse _$TransactionBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionBalanceResponse(
      (json['withdrawable_balance_hkd'] as num).toDouble(),
      (json['buying_power_hkd'] as num).toDouble(),
      (json['total_bot_stock_hkd'] as num).toDouble(),
      (json['total_portfolio_hkd'] as num).toDouble(),
      (json['withdrawable_balance_usd'] as num).toDouble(),
      (json['buying_power_usd'] as num).toDouble(),
      (json['total_bot_stock_usd'] as num).toDouble(),
      (json['total_portfolio_usd'] as num).toDouble(),
      (json['total_pnl_pct'] as num).toDouble(),
    );

Map<String, dynamic> _$TransactionBalanceResponseToJson(
        TransactionBalanceResponse instance) =>
    <String, dynamic>{
      'withdrawable_balance_hkd': instance.withdrawableBalanceHkd,
      'buying_power_hkd': instance.buyingPowerHkd,
      'total_bot_stock_hkd': instance.totalBotStockHkd,
      'total_portfolio_hkd': instance.totalPortfolioHkd,
      'withdrawable_balance_usd': instance.withdrawableBalanceUsd,
      'buying_power_usd': instance.buyingPowerUsd,
      'total_bot_stock_usd': instance.totalBotStockUsd,
      'total_portfolio_usd': instance.totalPortfolioUsd,
      'total_pnl_pct': instance.totalPnLPct,
    };
