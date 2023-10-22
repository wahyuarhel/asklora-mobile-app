import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../styles/asklora_colors.dart';
import '../../utils/extensions.dart';

part 'transaction_balance_response.g.dart';

@JsonSerializable()
class TransactionBalanceResponse extends Equatable {
  @JsonKey(name: 'withdrawable_balance_hkd')
  final double withdrawableBalanceHkd;
  @JsonKey(name: 'buying_power_hkd')
  final double buyingPowerHkd;
  @JsonKey(name: 'total_bot_stock_hkd')
  final double totalBotStockHkd;
  @JsonKey(name: 'total_portfolio_hkd')
  final double totalPortfolioHkd;
  @JsonKey(name: 'withdrawable_balance_usd')
  final double withdrawableBalanceUsd;
  @JsonKey(name: 'buying_power_usd')
  final double buyingPowerUsd;
  @JsonKey(name: 'total_bot_stock_usd')
  final double totalBotStockUsd;
  @JsonKey(name: 'total_portfolio_usd')
  final double totalPortfolioUsd;
  @JsonKey(name: 'total_pnl_pct')
  final double totalPnLPct;

  const TransactionBalanceResponse(
    this.withdrawableBalanceHkd,
    this.buyingPowerHkd,
    this.totalBotStockHkd,
    this.totalPortfolioHkd,
    this.withdrawableBalanceUsd,
    this.buyingPowerUsd,
    this.totalBotStockUsd,
    this.totalPortfolioUsd,
    this.totalPnLPct,
  );

  static TransactionBalanceResponse get placeholder =>
      const TransactionBalanceResponse(0, 0, 0, 0, 0, 0, 0, 0, 0);

  factory TransactionBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionBalanceResponseToJson(this);

  String get totalPortfolioHkdStr => totalPortfolioHkd != 0
      ? totalPortfolioHkd.convertToCurrencyDecimal()
      : '0.00';

  String get withdrawableBalanceHkdStr => withdrawableBalanceHkd != 0
      ? withdrawableBalanceHkd.convertToCurrencyDecimal()
      : '0.00';

  String get buyingPowerHkdStr =>
      buyingPowerHkd != 0 ? buyingPowerHkd.convertToCurrencyDecimal() : '0.00';

  String get totalBotstockHkdStr => totalBotStockHkd != 0
      ? totalBotStockHkd.convertToCurrencyDecimal()
      : '0.00';

  String get totalPortfolioUsdStr => totalPortfolioHkd != 0
      ? totalPortfolioUsd.convertToCurrencyDecimal()
      : '0.00';

  String get withdrawableBalanceUsdStr => withdrawableBalanceUsd != 0
      ? withdrawableBalanceUsd.convertToCurrencyDecimal()
      : '0.00';

  String get buyingPowerUsdStr =>
      buyingPowerUsd != 0 ? buyingPowerUsd.convertToCurrencyDecimal() : '0.00';

  String get totalBotstockUsdStr => totalBotStockUsd != 0
      ? totalBotStockUsd.convertToCurrencyDecimal()
      : '0.00';

  String get totalPnLStr => (totalPnLPct < 0)
      ? '${totalPnLPct.convertToCurrencyDecimal()}%'
      : '+${totalPnLPct.convertToCurrencyDecimal()}%';

  Color get totalPnLColor => (totalPnLPct < 0)
      ? AskLoraColors.primaryMagenta
      : AskLoraColors.primaryGreen;

  @override
  List<Object> get props => [
        withdrawableBalanceHkd,
        buyingPowerHkd,
        totalBotStockHkd,
        totalPortfolioHkd,
        withdrawableBalanceUsd,
        buyingPowerUsd,
        totalBotStockUsd,
        totalPnLPct,
        totalPortfolioUsd,
      ];
}
