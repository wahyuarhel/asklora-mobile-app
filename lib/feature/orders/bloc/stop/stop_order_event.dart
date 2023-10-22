part of 'stop_order_bloc.dart';

abstract class StopOrderEvent extends Equatable {
  const StopOrderEvent() : super();

  @override
  List<Object?> get props => [];
}

class StopPriceChanged extends StopOrderEvent {
  final double stopPrice;

  const StopPriceChanged(this.stopPrice) : super();

  @override
  List<Object?> get props => [stopPrice];
}

class StopQuantityChanged extends StopOrderEvent {
  final double quantity;

  const StopQuantityChanged(this.quantity) : super();

  @override
  List<Object?> get props => [quantity];
}

class StopOrderSubmitted extends StopOrderEvent {
  final OrderRequest orderRequest;

  const StopOrderSubmitted(this.orderRequest) : super();

  @override
  List<Object?> get props => [orderRequest];
}
