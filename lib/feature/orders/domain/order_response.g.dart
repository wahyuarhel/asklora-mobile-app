// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      id: json['id'] as String?,
      clientOrderId: json['client_order_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      submittedAt: json['submitted_at'] as String?,
      filledAt: json['filled_at'] as String?,
      expiredAt: json['expired_at'] as String?,
      canceledAt: json['canceled_at'] as String?,
      failedAt: json['failed_at'] as String?,
      replacedAt: json['replaced_at'] as String?,
      replacedBy: json['replaced_by'] as String?,
      replaces: json['replaces'] as String?,
      assetId: json['asset_id'] as String?,
      symbol: json['symbol'] as String?,
      assetClass: json['asset_class'] as String?,
      notional: json['notional'] as String?,
      qty: json['qty'] as String?,
      filledQty: json['filled_qty'] as String?,
      filledAvgPrice: json['filled_avg_price'] as String?,
      orderClass: json['order_class'] as String?,
      orderType: json['order_type'] as String?,
      type: json['type'] as String?,
      side: json['side'] as String?,
      timeInForce: json['time_in_force'] as String?,
      status: json['status'] as String?,
      extendedHours: json['extended_hours'] as String?,
      legs: json['legs'] == null
          ? null
          : Legs.fromJson(json['legs'] as Map<String, dynamic>),
      trailPercent: json['trail_percent'] as String?,
      trailPrice: json['trail_price'] as String?,
      hwm: json['hwm'] as String?,
      commission: json['commission'] as String?,
      stopPrice: json['stop_price'] as String?,
      limitPrice: json['limit_price'] as String?,
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_order_id': instance.clientOrderId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'submitted_at': instance.submittedAt,
      'filled_at': instance.filledAt,
      'expired_at': instance.expiredAt,
      'canceled_at': instance.canceledAt,
      'failed_at': instance.failedAt,
      'replaced_at': instance.replacedAt,
      'replaced_by': instance.replacedBy,
      'replaces': instance.replaces,
      'asset_id': instance.assetId,
      'symbol': instance.symbol,
      'asset_class': instance.assetClass,
      'notional': instance.notional,
      'qty': instance.qty,
      'filled_qty': instance.filledQty,
      'filled_avg_price': instance.filledAvgPrice,
      'order_class': instance.orderClass,
      'order_type': instance.orderType,
      'type': instance.type,
      'side': instance.side,
      'time_in_force': instance.timeInForce,
      'limit_price': instance.limitPrice,
      'stop_price': instance.stopPrice,
      'status': instance.status,
      'extended_hours': instance.extendedHours,
      'legs': instance.legs,
      'trail_percent': instance.trailPercent,
      'trail_price': instance.trailPrice,
      'hwm': instance.hwm,
      'commission': instance.commission,
    };
