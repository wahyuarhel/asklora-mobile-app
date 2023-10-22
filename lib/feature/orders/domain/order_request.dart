import 'package:json_annotation/json_annotation.dart';

import '../bloc/order_bloc.dart';
import 'stop_loss.dart';
import 'take_profit.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  @JsonKey(name: 'symbol_type')
  final String? symbolType;
  final String? symbol;
  final String? side;
  final String? type;
  @JsonKey(name: 'limit_price')
  final String? limitPrice;
  @JsonKey(name: 'stop_price')
  final String? stopPrice;
  @JsonKey(name: 'trail_percent')
  final String? trailPercent;
  @JsonKey(name: 'trail_price')
  final String? trailPrice;
  final String? qty;
  final String? notional;
  final String? amount;
  @JsonKey(name: 'time_in_force')
  final String? timeInForce;
  @JsonKey(name: 'extended_hours')
  final String? extendedHours;
  @JsonKey(name: 'order_class')
  final String? orderClass;
  @JsonKey(name: 'take_profit')
  final TakeProfit? takeProfit;
  @JsonKey(name: 'stop_loss')
  final StopLoss? stopLoss;

  static OrderRequest marketAmount(
      {required String symbolType,
      required String symbol,
      required String side,
      required String amount}) {
    return OrderRequest(
        symbol: symbol,
        side: side,
        orderClass: OrderClass.simple.name,
        amount: amount);
  }

  static OrderRequest marketShares(
      {required String symbolType,
      required String symbol,
      required String side,
      required String qty}) {
    return OrderRequest(
        symbol: symbol,
        side: side,
        type: OrderType.market.name,
        orderClass: OrderClass.simple.name,
        qty: qty);
  }

  static OrderRequest limit(
      {required String symbolType,
      required String symbol,
      required String side,
      required String quantity,
      required String limitPrice}) {
    return OrderRequest(
        qty: quantity,
        symbol: symbol,
        side: side,
        type: OrderType.limit.name,
        orderClass: OrderClass.simple.name,
        limitPrice: limitPrice);
  }

  static OrderRequest stop(
      {required String symbolType,
      required String symbol,
      required String side,
      required String stopPrice,
      required String quantity}) {
    return OrderRequest(
      symbol: symbol,
      side: side,
      type: OrderType.stop.name,
      orderClass: OrderClass.simple.name,
      stopPrice: stopPrice,
      qty: quantity,
    );
  }

  static OrderRequest stopLimit({
    required String symbolType,
    required String symbol,
    required String side,
    required String stopPrice,
    required String limitPrice,
    required String quantity,
  }) {
    return OrderRequest(
      symbol: symbol,
      side: side,
      type: OrderType.stopLimit.name,
      orderClass: OrderClass.simple.name,
      limitPrice: limitPrice,
      stopPrice: stopPrice,
      qty: quantity,
    );
  }

  static OrderRequest trailingStopAmount({
    required String symbolType,
    required String symbol,
    required String side,
    required String trailPrice,
    required String quantity,
  }) {
    return OrderRequest(
      symbol: symbol,
      side: side,
      type: OrderType.trailingStop.name,
      orderClass: OrderClass.simple.name,
      trailPrice: trailPrice,
      qty: quantity,
    );
  }

  static OrderRequest trailingStopPercentage({
    required String symbolType,
    required String symbol,
    required String side,
    required String trailPercentage,
    required String quantity,
  }) {
    return OrderRequest(
      symbol: symbol,
      side: side,
      type: OrderType.trailingStop.name,
      orderClass: OrderClass.simple.name,
      trailPercent: trailPercentage,
      qty: quantity,
    );
  }

  static OrderRequest bracket(
      {required String symbolType,
      required String symbol,
      required String side,
      required OrderType orderType,
      required String qty,
      required String timeInForce,
      required TakeProfit takeProfit,
      required StopLoss stopLoss}) {
    return OrderRequest(
        symbol: symbol,
        side: side,
        type: orderType.name,
        orderClass: OrderClass.bracket.name,
        qty: qty,
        timeInForce: timeInForce,
        takeProfit: takeProfit,
        stopLoss: stopLoss);
  }

  static OrderRequest oto(
      {required String symbolType,
      required String symbol,
      required String side,
      required OrderType orderType,
      required String qty,
      required String timeInForce,
      TakeProfit? takeProfit,
      StopLoss? stopLoss}) {
    return OrderRequest(
        symbol: symbol,
        side: side,
        type: orderType.name,
        orderClass: OrderClass.oto.name,
        qty: qty,
        timeInForce: timeInForce,
        takeProfit: takeProfit,
        stopLoss: stopLoss);
  }

  static OrderRequest oco(
      {required String symbolType,
      required String symbol,
      required String side,
      required OrderType orderType,
      required String qty,
      required String timeInForce,
      TakeProfit? takeProfit,
      StopLoss? stopLoss}) {
    return OrderRequest(
        symbol: symbol,
        side: side,
        type: orderType.name,
        orderClass: OrderClass.oco.name,
        qty: qty,
        timeInForce: timeInForce,
        takeProfit: takeProfit,
        stopLoss: stopLoss);
  }

  OrderRequest(
      {this.type,
      this.symbolType,
      this.symbol,
      this.side,
      this.limitPrice,
      this.stopPrice,
      this.qty,
      this.notional,
      this.amount,
      this.timeInForce,
      this.extendedHours,
      this.orderClass,
      this.takeProfit,
      this.stopLoss,
      this.trailPercent,
      this.trailPrice});

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}
