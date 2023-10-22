part of 'market_bloc.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent() : super();

  @override
  List<Object?> get props => [];
}

class AmountChanged extends MarketEvent {
  final double amount;

  const AmountChanged(this.amount) : super();

  @override
  List<Object?> get props => [amount];
}

class SharesAmountChanged extends MarketEvent {
  final double sharesAmount;

  const SharesAmountChanged(this.sharesAmount) : super();

  @override
  List<Object?> get props => [sharesAmount];
}

class SharesAmountIncremented extends MarketEvent {
  const SharesAmountIncremented() : super();

  @override
  List<Object?> get props => [];
}

class SharesAmountDecremented extends MarketEvent {
  const SharesAmountDecremented() : super();

  @override
  List<Object?> get props => [];
}

class OrderSubmitted extends MarketEvent {
  final OrderRequest orderRequest;

  const OrderSubmitted(this.orderRequest) : super();

  @override
  List<Object?> get props => [orderRequest];
}

class ResetMarketValue extends MarketEvent {
  const ResetMarketValue() : super();

  @override
  List<Object?> get props => [];
}
