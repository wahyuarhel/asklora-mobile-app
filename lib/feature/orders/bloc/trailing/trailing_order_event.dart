part of 'trailing_order_bloc.dart';

abstract class TrailingOrderEvent extends Equatable {
  const TrailingOrderEvent() : super();

  @override
  List<Object?> get props => [];
}

class TrailingAmountChanged extends TrailingOrderEvent {
  final double amount;
  const TrailingAmountChanged(this.amount) : super();

  @override
  List<Object?> get props => [amount];
}

class TrailingPercentageChanged extends TrailingOrderEvent {
  final double percentage;
  const TrailingPercentageChanged(this.percentage) : super();

  @override
  List<Object?> get props => [percentage];
}

class ResetTrailingOrderValue extends TrailingOrderEvent {
  const ResetTrailingOrderValue() : super();

  @override
  List<Object?> get props => [];
}

class QuantityOfTrailingOrderChanged extends TrailingOrderEvent {
  final double quantity;
  const QuantityOfTrailingOrderChanged(this.quantity) : super();

  @override
  List<Object?> get props => [quantity];
}

class TrailingOrderSubmitted extends TrailingOrderEvent {
  final OrderRequest orderRequest;
  const TrailingOrderSubmitted(this.orderRequest) : super();

  @override
  List<Object?> get props => [orderRequest];
}
