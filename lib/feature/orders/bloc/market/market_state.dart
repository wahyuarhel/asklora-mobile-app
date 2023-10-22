part of 'market_bloc.dart';

class MarketState extends Equatable {
  final BaseResponse response;
  final double amount;
  final double sharesAmount;
  final double estimateTotal;
  final double availableBuyingPower;
  final double availableAmountToSell;
  final double numberOfBuyableShares;
  final double numberOfSellableShares;
  final String buyErrorText;
  final String sellErrorText;

  const MarketState(
      {this.response = const BaseResponse(),
      this.amount = 0,
      this.sharesAmount = 0,
      this.estimateTotal = 0,
      required this.availableBuyingPower,
      required this.availableAmountToSell,
      required this.numberOfBuyableShares,
      required this.numberOfSellableShares,
      this.buyErrorText = '',
      this.sellErrorText = ''})
      : super();

  @override
  List<Object?> get props => [
        response,
        amount,
        sharesAmount,
        estimateTotal,
        availableBuyingPower,
        numberOfBuyableShares,
        buyErrorText,
        sellErrorText
      ];

  MarketState copyWith(
      {BaseResponse? response,
      double? amount,
      double? sharesAmount,
      double? estimateTotal,
      double? availableBuyingPower,
      double? numberOfBuyableShares,
      double? availableAmountToSell,
      double? numberOfSellableShares,
      String? buyErrorText,
      String? sellErrorText}) {
    return MarketState(
      response: response ?? this.response,
      amount: amount ?? this.amount,
      sharesAmount: sharesAmount ?? this.sharesAmount,
      estimateTotal: estimateTotal ?? this.estimateTotal,
      availableAmountToSell:
          availableAmountToSell ?? this.availableAmountToSell,
      numberOfSellableShares:
          numberOfSellableShares ?? this.numberOfSellableShares,
      availableBuyingPower: availableBuyingPower ?? this.availableBuyingPower,
      numberOfBuyableShares:
          numberOfBuyableShares ?? this.numberOfBuyableShares,
      buyErrorText:
          (estimateTotal ?? this.estimateTotal) > this.availableBuyingPower
              ? 'Amount exceed the amount of available buying power'
              : '',
      sellErrorText:
          (estimateTotal ?? this.estimateTotal) > this.availableAmountToSell
              ? 'Amount exceed the available amount to sell'
              : '',
    );
  }
}
