part of 'limit_order_bloc.dart';

abstract class LimitOrderEvent extends Equatable {
  const LimitOrderEvent() : super();

  @override
  List<Object?> get props => [];
}

class LimitChanged extends LimitOrderEvent {
  final double limit;

  const LimitChanged(this.limit) : super();

  @override
  List<Object?> get props => [limit];
}

class QuantityChanged extends LimitOrderEvent {
  final double quantity;

  const QuantityChanged(this.quantity) : super();

  @override
  List<Object?> get props => [quantity];
}

class OrderSubmitted extends LimitOrderEvent {
  final OrderRequest orderRequest;

  const OrderSubmitted(this.orderRequest) : super();

  @override
  List<Object?> get props => [orderRequest];
}
