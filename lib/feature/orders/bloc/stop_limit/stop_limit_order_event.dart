part of 'stop_limit_order_bloc.dart';

abstract class StopLimitOrderEvent extends Equatable {
  const StopLimitOrderEvent() : super();

  @override
  List<Object?> get props => [];
}

class StopPriceOfStopLimitOrderChanged extends StopLimitOrderEvent {
  final double stopPrice;

  const StopPriceOfStopLimitOrderChanged(this.stopPrice) : super();

  @override
  List<Object?> get props => [stopPrice];
}

class LimitPriceOfStopLimitOrderChanged extends StopLimitOrderEvent {
  final double limitPrice;

  const LimitPriceOfStopLimitOrderChanged(this.limitPrice) : super();

  @override
  List<Object?> get props => [limitPrice];
}

class QuantityOfStopLimitOrderChanged extends StopLimitOrderEvent {
  final double quantity;

  const QuantityOfStopLimitOrderChanged(this.quantity) : super();

  @override
  List<Object?> get props => [quantity];
}

class StopLimitOrderSubmitted extends StopLimitOrderEvent {
  final OrderRequest orderRequest;

  const StopLimitOrderSubmitted(this.orderRequest) : super();

  @override
  List<Object?> get props => [orderRequest];
}
