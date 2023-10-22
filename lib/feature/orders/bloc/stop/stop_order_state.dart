part of 'stop_order_bloc.dart';

class StopOrderState extends Equatable {
  final BaseResponse response;
  final double stopPrice;
  final double quantity;
  final double estimateTotal;
  final double availableBuyingPower;
  final double availableAmountToSell;
  final double numberOfSellableShares;
  final String buyErrorText;
  final String sellErrorText;

  const StopOrderState({
    this.response = const BaseResponse(),
    this.stopPrice = 0,
    this.quantity = 0,
    this.estimateTotal = 0,
    required this.availableBuyingPower,
    required this.availableAmountToSell,
    required this.numberOfSellableShares,
    this.buyErrorText = '',
    this.sellErrorText = '',
  }) : super();

  @override
  List<Object?> get props => [
        response,
        stopPrice,
        quantity,
        estimateTotal,
        availableBuyingPower,
        availableAmountToSell,
        numberOfSellableShares,
        buyErrorText,
        sellErrorText
      ];

  StopOrderState copyWith({
    BaseResponse? response,
    double? stopPrice,
    double? quantity,
    double? estimateTotal,
    double? availableBuyingPower,
    double? availableAmountToSell,
    double? numberOfSellableShares,
    String? buyErrorText,
    String? sellErrorText,
  }) {
    return StopOrderState(
      response: response ?? this.response,
      stopPrice: stopPrice ?? this.stopPrice,
      quantity: quantity ?? this.quantity,
      estimateTotal: estimateTotal ?? this.estimateTotal,
      availableBuyingPower: availableBuyingPower ?? this.availableBuyingPower,
      availableAmountToSell:
          availableAmountToSell ?? this.availableAmountToSell,
      numberOfSellableShares:
          numberOfSellableShares ?? this.numberOfSellableShares,
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

  bool disabledConfirmButton(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.buy:
        return !(stopPrice != 0 && quantity != 0 && buyErrorText.isEmpty);
      case TransactionType.sell:
        return !(stopPrice != 0 && quantity != 0 && sellErrorText.isEmpty);
      default:
        return true;
    }
  }
}
