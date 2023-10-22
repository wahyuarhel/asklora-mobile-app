part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent() : super();

  @override
  List<Object?> get props => [];
}

class TransactionTypeChanged extends OrderEvent {
  final TransactionType transactionType;

  const TransactionTypeChanged(this.transactionType) : super();

  @override
  List<Object?> get props => [transactionType];
}

class OrderTypeChanged extends OrderEvent {
  final OrderType orderType;

  const OrderTypeChanged(this.orderType) : super();

  @override
  List<Object?> get props => [orderType];
}

class TrailTypeChanged extends OrderEvent {
  final TrailType trailType;

  const TrailTypeChanged(this.trailType) : super();

  @override
  List<Object?> get props => [trailType];
}

class TimeInForceChanged extends OrderEvent {
  final TimeInForce timeInForce;

  const TimeInForceChanged(this.timeInForce) : super();

  @override
  List<Object?> get props => [timeInForce];
}

class TradingHoursChanged extends OrderEvent {
  final TradingHours tradingHours;

  const TradingHoursChanged(this.tradingHours) : super();

  @override
  List<Object?> get props => [tradingHours];
}

class MarketTypeChanged extends OrderEvent {
  final MarketType marketType;

  const MarketTypeChanged(this.marketType) : super();

  @override
  List<Object?> get props => [marketType];
}
