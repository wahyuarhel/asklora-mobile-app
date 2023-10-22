part of 'order_bloc.dart';

enum OrderType {
  market,
  limit,
  stop,
  stopLimit,
  trailingStop,
}

extension Type on OrderType {
  String get name {
    switch (this) {
      case OrderType.market:
        return 'Market';
      case OrderType.limit:
        return 'Limit';
      case OrderType.stop:
        return 'Stop';
      case OrderType.stopLimit:
        return 'Stop Limit';
      case OrderType.trailingStop:
        return 'Trailing Stop';
      default:
        return '';
    }
  }
}

enum TransactionType { buy, sell, unknown }

enum TrailType { percentage, amount }

extension TypeOfTrail on TrailType {
  String get name {
    switch (this) {
      case TrailType.amount:
        return 'Amount';
      case TrailType.percentage:
        return 'Percentage';
    }
  }
}

enum TimeInForce { day, goodTillCanceled }

extension TypeOfTimeInForce on TimeInForce {
  String get name {
    switch (this) {
      case TimeInForce.day:
        return 'Day';
      case TimeInForce.goodTillCanceled:
        return 'Good Till Cancelled';
    }
  }
}

enum TradingHours { regular, extended }

extension TypeOfTradingHours on TradingHours {
  String get name {
    switch (this) {
      case TradingHours.regular:
        return 'Regular';
      case TradingHours.extended:
        return 'Extended';
    }
  }
}

extension TypeOfTransaction on TransactionType {
  String get name {
    switch (this) {
      case TransactionType.buy:
        return 'BUY';
      case TransactionType.sell:
        return 'SELL';
      default:
        return '';
    }
  }
}

enum MarketType { amount, shares }

extension TypeOfMarket on MarketType {
  String get name {
    switch (this) {
      case MarketType.amount:
        return 'Amount';
      case MarketType.shares:
        return 'Shares';
      default:
        return '';
    }
  }
}

enum OrderPageStep {
  symbolDetails,
  orderType,
  order,
  orderSubmitted,
  orderDetails,
}

enum SymbolType { ric, symbol }

enum OrderClass { bracket, simple, oco, oto }

class OrderState extends Equatable {
  final TransactionType transactionType;
  final OrderType orderType;
  final TrailType trailType;
  final TimeInForce timeInForce;
  final TradingHours tradingHours;
  final MarketType marketType;

  const OrderState({
    this.transactionType = TransactionType.unknown,
    this.orderType = OrderType.market,
    this.trailType = TrailType.percentage,
    this.timeInForce = TimeInForce.day,
    this.tradingHours = TradingHours.extended,
    this.marketType = MarketType.amount,
  }) : super();

  @override
  List<Object?> get props => [
        transactionType,
        orderType,
        trailType,
        timeInForce,
        tradingHours,
        marketType
      ];

  OrderState copyWith({
    TransactionType? transactionType,
    OrderType? orderType,
    TrailType? trailType,
    TimeInForce? timeInForce,
    TradingHours? tradingHours,
    MarketType? marketType,
  }) {
    return OrderState(
      transactionType: transactionType ?? this.transactionType,
      orderType: orderType ?? this.orderType,
      trailType: trailType ?? this.trailType,
      timeInForce: timeInForce ?? this.timeInForce,
      tradingHours: tradingHours ?? this.tradingHours,
      marketType: marketType ?? this.marketType,
    );
  }
}
