// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      type: json['type'] as String?,
      symbolType: json['symbol_type'] as String?,
      symbol: json['symbol'] as String?,
      side: json['side'] as String?,
      limitPrice: json['limit_price'] as String?,
      stopPrice: json['stop_price'] as String?,
      qty: json['qty'] as String?,
      notional: json['notional'] as String?,
      amount: json['amount'] as String?,
      timeInForce: json['time_in_force'] as String?,
      extendedHours: json['extended_hours'] as String?,
      orderClass: json['order_class'] as String?,
      takeProfit: json['take_profit'] == null
          ? null
          : TakeProfit.fromJson(json['take_profit'] as Map<String, dynamic>),
      stopLoss: json['stop_loss'] == null
          ? null
          : StopLoss.fromJson(json['stop_loss'] as Map<String, dynamic>),
      trailPercent: json['trail_percent'] as String?,
      trailPrice: json['trail_price'] as String?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'symbol_type': instance.symbolType,
      'symbol': instance.symbol,
      'side': instance.side,
      'type': instance.type,
      'limit_price': instance.limitPrice,
      'stop_price': instance.stopPrice,
      'trail_percent': instance.trailPercent,
      'trail_price': instance.trailPrice,
      'qty': instance.qty,
      'notional': instance.notional,
      'amount': instance.amount,
      'time_in_force': instance.timeInForce,
      'extended_hours': instance.extendedHours,
      'order_class': instance.orderClass,
      'take_profit': instance.takeProfit,
      'stop_loss': instance.stopLoss,
    };
